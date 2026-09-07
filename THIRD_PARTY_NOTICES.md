# Third-party notices

## License scope

The root MIT license covers original material authored by bolens. It does not
replace third-party licenses, copyright notices, trademarks, or service terms.
Imported and modified third-party material keeps its applicable upstream terms.

## Captured configuration

`etc/ananicy.d/` retains its GNU GPLv3 license in `etc/ananicy.d/LICENSE`.
It is excluded from the root MIT grant. `boot/limine.conf` credits diegons490's
CachyOS Limine theme. Its upstream license is retained below.

The captured package defaults under `etc/`, `boot/`, and `user-config/` may
contain upstream material beyond the plugins listed below. The MIT grant covers
only bolens's original contributions. Exact source revisions and license scope
for the remaining captured defaults have not been established. Preserve their
headers and resolve provenance before redistributing them as a cleared bundle.

## GitHub Spec Kit

Imported `.specify/scripts/`, `.specify/templates/`, and
`.agents/skills/speckit-*` integration files retain GitHub's MIT copyright and
permission notice in [.specify/LICENSE](.specify/LICENSE). Include it when
copying these files. Project-authored memory documents have separate ownership.

## Retained upstream license copies

These source URLs identify the retrieved license text. They do not establish
the exact revision of older unrecorded imports. File-level notices take
precedence over a project-wide license.

- **tide**: `functions/_tide_*`, `functions/tide*`, `functions/fish_prompt.fish`, `functions/fish_mode_prompt.fish`, `conf.d/*tide*`, `completions/tide.fish`. [Upstream license](https://github.com/IlanCosman/tide/blob/c4e3831dc4392979478d3d7b66a68f0274996c85/LICENSE.md). Full copy: [LICENSES/tide.txt](LICENSES/tide.txt).
- **fzf-fish**: `functions/__fzf*`, `conf.d/fzf.fish`. [Upstream license](https://github.com/jethrokuan/fzf/blob/479fa67d7439b23095e01b64987ae79a91a4e283/LICENSE.md). Full copy: [LICENSES/fzf-fish.txt](LICENSES/fzf-fish.txt).
- **pisces**: `functions/_pisces_*`, `conf.d/pisces.fish`. [Upstream license](https://github.com/laughedelic/pisces/blob/e45e0869855d089ba1e628b6248434b2dfa709c4/LICENSE.md). Full copy: [LICENSES/pisces.txt](LICENSES/pisces.txt).
- **fish-ghq**: `functions/__ghq_repository_search.fish`, `conf.d/ghq_key_bindings.fish`, `completions/ghq.fish`. [Upstream license](https://github.com/decors/fish-ghq/blob/cafaaabe63c124bf0714f89ec715cfe9ece87fa2/LICENSE). Full copy: [LICENSES/fish-ghq.txt](LICENSES/fish-ghq.txt).
- **fish-done**: `conf.d/done.fish`. [Upstream license](https://github.com/franciscolourenco/done/blob/b86292a52a2b8f646ef8d25daa3cc01ccab60b62/LICENSE). Full copy: [LICENSES/fish-done.txt](LICENSES/fish-done.txt).
- **bass**: `functions/bass.fish`, `functions/__bass.py`. [Upstream license](https://github.com/edc/bass/blob/79b62958ecf4e87334f24d6743e5766475bcf4d0/LICENSE). Full copy: [LICENSES/bass.txt](LICENSES/bass.txt).
- **nvm-fish**: `functions/nvm.fish`, `functions/_nvm_*`, `conf.d/nvm.fish`, `completions/nvm.fish`. [Upstream license](https://github.com/jorgebucaran/nvm.fish/blob/85cadd56f71b11574566dbd6c32e0027e361d085/LICENSE.md). Full copy: [LICENSES/nvm-fish.txt](LICENSES/nvm-fish.txt).
- **fish-git**: `functions/__git.*` and Git aliases, `conf.d/git.fish`. [Upstream license](https://github.com/jhillyerd/plugin-git/blob/85d692987aabbb4018d1c38d528b7a154d6aae3f/LICENSE). Full copy: [LICENSES/fish-git.txt](LICENSES/fish-git.txt).
- **limine-theme**: `boot/limine.conf`. [Upstream license](https://github.com/diegons490/cachyos-limine-theme/blob/81500891c2dd6da1af3eacd650eba86f2e4dc64c/LICENSE). Full copy: [LICENSES/limine-theme.txt](LICENSES/limine-theme.txt).

Pisces uses LGPLv3, which incorporates GPLv3. Both license texts are retained
in `LICENSES/pisces.txt` and `LICENSES/GPL-3.0.txt`. Its covered source remains
available in this repository. Keep it modifiable under those terms.

## Redistribution

Keep applicable full license and copyright notices with copied source and
bundled dependencies, including minified JavaScript and compiled executables.
Use the exact dependency versions selected by the lockfile or build. Preserve
Apache NOTICE material and satisfy copyleft source requirements where they
apply. Development-only tools and separately installed programs keep their own
terms but are not automatically part of a distributed application.

This source inventory is not proof that every historical release, external
asset, fetched dataset, or built container has satisfied its license obligations.
