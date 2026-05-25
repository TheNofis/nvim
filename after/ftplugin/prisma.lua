vim.bo.commentstring = "// %s"
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

-- Ensure prisma parser exists for highlighting on first open.
local has_ts = pcall(require, "nvim-treesitter")
if has_ts then
  local parser_files = vim.api.nvim_get_runtime_file("parser/prisma.*", true)
  if #parser_files == 0 then
    pcall(function()
      require("nvim-treesitter").install("prisma")
    end)
  end
end

pcall(vim.treesitter.start, 0, "prisma")

vim.api.nvim_buf_create_user_command(0, "PrismaFormat", function()
  local ok, conform = pcall(require, "conform")
  if ok then
    conform.format({ lsp_fallback = true, timeout_ms = 2000 })
    return
  end

  vim.lsp.buf.format({ timeout_ms = 2000 })
end, { desc = "Format current Prisma file" })

vim.keymap.set("n", "<leader>lf", function()
  vim.cmd("PrismaFormat")
end, { buffer = true, desc = "Format Prisma file" })
