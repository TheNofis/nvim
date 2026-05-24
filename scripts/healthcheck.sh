#!/usr/bin/env bash
set -euo pipefail

nvim --version | head -n 1

for bin in git rg node npm codex codex-acp; do
  if command -v "$bin" >/dev/null 2>&1; then
    printf "ok: %s -> %s\n" "$bin" "$(command -v "$bin")"
  else
    printf "missing: %s\n" "$bin"
  fi
done

nvim --headless "+Lazy! sync" "+checkhealth vim.lsp" +qa

