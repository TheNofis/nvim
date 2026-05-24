# Neovim Configuration

Production-oriented Neovim setup for fullstack development with:
- LSP + formatting
- Git workflows and merge-conflict tooling
- AI workflows through `codecompanion.nvim` with Codex ACP

## Compatibility

- Neovim `>= 0.11` (recommended `0.12.x`)
- Linux/macOS
- `zsh`/`bash`

## Core Features

- LSP stack for JavaScript/TypeScript, HTML/CSS, Prisma, Lua
- Completion with `nvim-cmp` + `LuaSnip`
- Formatting via `conform.nvim` + `prettierd`/`stylua`
- Treesitter syntax and textobjects
- Git tooling:
  - `gitsigns.nvim`
  - `diffview.nvim` for history and conflict resolution
- AI assistant integration:
  - `codecompanion.nvim`
  - Codex ACP adapter

## Architecture

The configuration is split by responsibility. `init.lua` only wires the layers together and does not contain plugin logic.

```text
~/.config/nvim
├── init.lua
├── lua
│   ├── core        # editor platform: bootstrap, globals, options, keymaps, autocmds, health
│   ├── plugins     # lazy.nvim specs grouped by domain
│   ├── config      # runtime setup for individual plugins
│   ├── lang        # language-specific LSP rules
│   └── utils       # small shared helpers
└── scripts         # maintenance and healthcheck scripts
```

Layer rules:

- Put editor-level behavior in `lua/core`.
- Put plugin declarations only in `lua/plugins`.
- Put plugin `.setup()` implementations in `lua/config`.
- Put language-specific server settings in `lua/lang`.
- Keep `init.lua` as an entrypoint only.

## Prerequisites

Install required system packages:

```bash
# Arch
yay -S git curl make unzip ripgrep fd
```

Install Node.js (via `nvm`) and npm:

```bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install --lts
node -v
npm -v
```

## Install Neovim

Use your package manager or official binaries from:

`https://github.com/neovim/neovim/releases`

Verify:

```bash
nvim --version
```

## Installation

Back up old config if needed:

```bash
mv ~/.config/nvim ~/.config/nvim.bak.$(date +%s) 2>/dev/null || true
```

Clone this config:

```bash
git clone https://github.com/TheNofis/nvim ~/.config/nvim
```

Start Neovim and let `lazy.nvim` install plugins:

```bash
nvim
```

Optional manual sync:

```vim
:Lazy sync
```

## Language Tooling

This setup uses `mason.nvim` + `nvim-lspconfig` and auto-manages common tools:

- LSP: `ts_ls`, `eslint`, `tailwindcss`, `html`, `cssls`, `emmet`, `prismals`, `lua_ls`
- Formatters: `prettierd`, `stylua`

Check health:

```vim
:checkhealth vim.lsp
:Mason
```

## AI Setup: CodeCompanion + Codex

### Required binaries

`CodeCompanion` with Codex ACP requires:

- `codex`
- `codex-acp`

Both must be available in `PATH`.

Example for `~/.local/bin`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
which codex
which codex-acp
```

### Authentication

Login once in terminal:

```bash
codex login
```

### Keymaps

- `<leader>aa` open/toggle CodeCompanion chat with Codex
- `<leader>ai` inline action (normal/visual)
- `<leader>ac` open CodeCompanion CLI interaction
- `<leader>ar` open CodeCompanion action palette

## Git and Merge Conflicts

`diffview.nvim` is preconfigured.

Keymaps:

- `<leader>gd` open Diffview
- `<leader>gD` close Diffview
- `<leader>gh` file history for current file
- `<leader>gH` repository history
- `<leader>gp` preview hunk
- `<leader>gn` / `<leader>gN` next/previous hunk

## Keymap Groups

Search:
- `<leader>ff` find files
- `<leader>fg` live grep
- `<leader>fb` buffers
- `<leader>fr` resume telescope
- `<leader>fh` help tags
- `<leader>fs` document symbols
- `<leader>fS` workspace symbols
- `<leader>fk` keymaps

LSP:
- `gd` definition
- `gr` references
- `gD` declaration
- `gi` implementation
- `K` hover
- `[d` / `]d` previous/next diagnostic
- `<leader>la` code action (normal/visual)
- `<leader>lr` rename
- `<leader>lf` format buffer
- `<leader>ld` line diagnostics float
- `<leader>lD` diagnostics to loclist
- `<leader>li` LSP info
- `<leader>lR` restart LSP

Typical conflict workflow:

1. `git merge ...` or `git rebase ...`
2. Open conflict file or run `<leader>gd`
3. Resolve chunks in diff view
4. `git add <file>`
5. Continue merge/rebase

## Troubleshooting

### `codex-acp` not found

Error:

`ENOENT: no such file or directory (cmd): 'codex-acp'`

Fix:

1. Install `codex-acp`
2. Ensure binary is in `PATH`
3. Restart Neovim

### ACP protocol mismatch (`initialize` not found)

Cause: using `codex mcp-server` instead of ACP adapter binary.  
Fix: use `codex-acp` for CodeCompanion ACP integration.

### Plugin state issues

```vim
:Lazy clean
:Lazy sync
```

## Updating

Update plugins:

```vim
:Lazy sync
```

Update Mason tools:

```vim
:Mason
```

## License

Personal configuration repository. Keep original licenses for all third-party plugins.
