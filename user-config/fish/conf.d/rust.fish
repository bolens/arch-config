# Rust environment setup (modernized)
set -gx RUSTFLAGS "-C target-cpu=native -C opt-level=3"
fish_add_path -p --path $HOME/.cargo/bin
