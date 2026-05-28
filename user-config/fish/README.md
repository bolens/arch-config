# fish-config

Personal Fish shell configuration for Arch Linux. Managed with [Fisher](https://github.com/jorgebucaran/fisher) and the [Tide](https://github.com/IlanCosman/tide) prompt.

## Structure

```
.
├── config.fish          # Top-level config (greeting, PATH, editor, locale)
├── fish_plugins         # Fisher plugin manifest
├── conf.d/              # Auto-sourced config modules
├── functions/           # Custom functions and wrappers
├── completions/         # Tab completion scripts
└── .gitignore           # Excludes fish_variables, fish_history, private config
```

## Plugins

| Plugin | Purpose |
|---|---|
| [ilancosman/tide](https://github.com/IlanCosman/tide) | Prompt |
| [jhillyerd/plugin-git](https://github.com/jhillyerd/plugin-git) | Git abbreviations |
| [jethrokuan/fzf](https://github.com/jethrokuan/fzf) | fzf key bindings |
| [franciscolourenco/done](https://github.com/franciscolourenco/done) | Notify on long commands |
| [laughedelic/pisces](https://github.com/laughedelic/pisces) | Auto-close brackets/quotes |
| [decors/fish-ghq](https://github.com/decors/fish-ghq) | ghq repo navigation (Ctrl+G) |
| [jorgebucaran/nvm.fish](https://github.com/jorgebucaran/nvm.fish) | Node version management |
| [edc/bass](https://github.com/edc/bass) | Run bash scripts in fish |

## Modern CLI tool integrations

The config wraps or defaults to modern alternatives where available:

| Wrapper | Replaces | Tool |
|---|---|---|
| `cat` | cat | [bat](https://github.com/sharkdp/bat) |
| `ls` / `ll` / `la` / `lt` | ls | [eza](https://github.com/eza-community/eza) |
| `grep` | grep | [ripgrep](https://github.com/BurntSushi/ripgrep) |
| `find` | find | [fd](https://github.com/sharkdp/fd) |
| `curl` | curl | [curlie](https://github.com/rs/curlie) |
| `dig` | dig | [dog](https://github.com/ogham/dog) |
| `watch` | watch | [viddy](https://github.com/sachaos/viddy) |
| `du` | du | [duf](https://github.com/muesli/duf) |
| `top` / `htop` | htop | [glances](https://github.com/nicolargo/glances) |
| `gdv` | vim diff | [delta](https://github.com/dandavison/delta) |
| `lg` | — | [lazygit](https://github.com/jesseduffield/lazygit) |
| `ld` | — | [lazydocker](https://github.com/jesseduffield/lazydocker) |
| `yy` | — | [yazi](https://github.com/sxyazi/yazi) (cd on exit) |

Other integrations: [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide), [mise](https://github.com/jdx/mise), [navi](https://github.com/denisidoro/navi) (Alt+N), [delta](https://github.com/dandavison/delta) as git pager, [bat](https://github.com/sharkdp/bat) as MANPAGER.

## Private config

Machine-specific secrets and personal values (SSH key names, API tokens) live in
`conf.d/private.fish`, which is excluded from git via `.gitignore`. Create it locally:

```fish
# conf.d/private.fish — not tracked in git

set -gx MY_API_TOKEN "..."

if status is-interactive
    keychain --eval --quiet your-key-name | source
end
```
