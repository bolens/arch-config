# Rust environment setup
# rustup.fish (env.fish) handles adding ~/.cargo/bin to PATH.
set -gx RUSTFLAGS "-C target-cpu=native -C opt-level=3"
