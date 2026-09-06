"""Exercise capture only against disposable sources and Git repositories."""

import os
from pathlib import Path
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).resolve().parents[1] / "sync.fish"


class CaptureTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.source = self.root / "system source"
        self.user = self.root / "user config"
        self.dest = self.root / "repository"
        self.bin = self.root / "bin"
        for directory in (self.source, self.user, self.dest, self.bin):
            directory.mkdir()
        for relative in ("etc/makepkg.conf", "etc/pacman.conf", "etc/fstab",
                         "etc/environment", "etc/security/limits.conf", "boot/limine.conf"):
            path = self.source / relative
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text("fixture\n")
        for relative in ("etc/sysctl.d", "etc/systemd", "etc/udev/rules.d", "etc/ananicy.d"):
            (self.source / relative).mkdir(parents=True, exist_ok=True)
        (self.user / "fish/conf.d").mkdir(parents=True)
        (self.user / "fish/config.fish").write_text("set -g fixture 1\n")
        for relative in ("fish/conf.d/private.fish", "fish/fish_variables", "fish/fish_history"):
            (self.user / relative).write_text("PRIVATE_FIXTURE\n")
        (self.user / "fish/external.fish").symlink_to(self.user / "fish/conf.d/private.fish")
        (self.user / "fish/relative.fish").symlink_to("config.fish")
        (self.dest / "unrelated.txt").write_text("preserve\n")
        subprocess.run(["git", "init", "-q", str(self.dest)], check=True)
        self.stub("pacman", "printf 'fixture-package\\n'\n")
        self.env = dict(os.environ, PATH=f"{self.bin}:/usr/bin:/bin")

    def stub(self, name, body):
        path = self.bin / name
        path.write_text("#!/bin/sh\n" + body)
        path.chmod(0o755)

    def run_capture(self, *args):
        return subprocess.run([
            "fish", "--no-config", str(SCRIPT), "--source-root", str(self.source),
            "--user-config-root", str(self.user), "--destination", str(self.dest), *args,
        ], env=self.env, capture_output=True, text=True, timeout=20)

    def snapshot(self):
        return {str(p.relative_to(self.dest)): p.read_bytes()
                for p in self.dest.rglob("*") if p.is_file()}

    def test_preview_does_not_write_anything(self):
        before = self.snapshot()
        result = self.run_capture()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.snapshot(), before)

    def test_apply_preserves_unrelated_files_and_excludes_private_state(self):
        result = self.run_capture("--apply")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual((self.dest / "unrelated.txt").read_text(), "preserve\n")
        self.assertTrue((self.dest / "user-config/fish/config.fish").is_file())
        self.assertEqual((self.dest / "pkglist.txt").read_text(), "fixture-package\n")
        self.assertFalse((self.dest / "user-config/fish/external.fish").exists())
        self.assertTrue((self.dest / "user-config/fish/relative.fish").is_symlink())
        self.assertEqual(os.readlink(self.dest / "user-config/fish/relative.fish"), "config.fish")
        self.assertNotIn(b"PRIVATE_FIXTURE", b"".join(self.snapshot().values()))
        self.assertFalse((self.dest / ".git/index").exists(), "capture must not stage files")
        self.assertFalse((self.dest / ".git/logs/HEAD").exists(), "capture must not commit")

    def test_symlinked_capture_roots_fail_before_writes(self):
        for relative in ("etc", "boot", "user-config"):
            for dangling in (False, True):
                with self.subTest(relative=relative, dangling=dangling):
                    outside = self.root / (relative + "-outside")
                    if not dangling:
                        outside.mkdir()
                        (outside / "sentinel").write_text("preserve\n")
                    link = self.dest / relative
                    link.symlink_to(outside, target_is_directory=True)
                    before = self.snapshot()
                    result = self.run_capture("--apply")
                    self.assertNotEqual(result.returncode, 0, result.stdout)
                    self.assertIn("Capture destination must not be a symlink", result.stderr)
                    self.assertTrue(link.is_symlink())
                    self.assertEqual(self.snapshot(), before)
                    if not dangling:
                        self.assertEqual(list(outside.iterdir()), [outside / "sentinel"])
                        self.assertEqual((outside / "sentinel").read_text(), "preserve\n")
                        (outside / "sentinel").unlink()
                        outside.rmdir()
                    else:
                        self.assertFalse(outside.exists())
                    link.unlink()

    def test_package_failure_precedes_capture(self):
        self.stub("pacman", "exit 7\n")
        before = self.snapshot()
        self.assertNotEqual(self.run_capture("--apply").returncode, 0)
        self.assertEqual(self.snapshot(), before)

    def test_copy_failure_is_reported(self):
        self.stub("rsync", "exit 23\n")
        result = self.run_capture("--apply")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Capture failed", result.stderr)
        self.assertFalse((self.dest / "pkglist.txt").exists())

    def test_missing_source_and_invalid_options_fail_without_writes(self):
        before = self.snapshot()
        for args in (("--unknown",), ("--apply", "--preview"), ("unexpected",)):
            self.assertNotEqual(self.run_capture(*args).returncode, 0)
        (self.source / "etc/fstab").unlink()
        self.assertNotEqual(self.run_capture("--apply").returncode, 0)
        self.assertEqual(self.snapshot(), before)

    def test_non_repository_destination_is_rejected(self):
        self.dest = self.root / "not-a-repo"
        self.dest.mkdir()
        self.assertNotEqual(self.run_capture("--apply").returncode, 0)
        self.assertEqual(list(self.dest.iterdir()), [])


if __name__ == "__main__":
    unittest.main()
