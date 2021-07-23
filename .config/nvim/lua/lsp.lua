--    ______      __         _      __   Gabriel Moreno
--   / ____/___ _/ /_  _____(_)__  / /   ==============
--  / / __/ __ `/ __ \/ ___/ / _ \/ /    E-mail:   gantoreno@gmail.com
-- / /_/ / /_/ / /_/ / /  / /  __/ /     Website:  https://gantoreno.com
-- \____/\__,_/_.___/_/  /_/\___/_/      GitHub:   https://github.com/gantoreno
--
-- Neovim LSP file

-- Custom `on_attach` function {{{
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { noremap = true, silent = true })
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { noremap = true, silent = true })
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { noremap = true, silent = true })
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { noremap = true, silent = true })
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { noremap = true, silent = true })

  return require("compe").on_attach
end
-- }}}

-- Diagnosticls Setup {{{
require("diagnosticls-nvim").init({
  default_config = false,
  formatting = false,
})

require("diagnosticls-nvim").setup({
  ["javascriptreact"] = {
    formatter = require("diagnosticls-nvim.formatters.prettier"),
    linter = require("diagnosticls-nvim.linters.eslint"),
  },
  ["typescriptreact"] = {
    formatter = require("diagnosticls-nvim.formatters.prettier"),
    linter = require("diagnosticls-nvim.linters.eslint"),
  },
  ["python"] = {
    formatter = require("diagnosticls-nvim.formatters.autopep8"),
  },
  ["lua"] = {
    formatter = {
      sourceName = "stylua",
      command = "stylua",
      args = { "-" },
      rootPatterns = { "stylua.toml" },
    },
  },
})
-- }}}

-- TS Server setup {{{
require("lspconfig").tsserver.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false

    on_attach(client)
  end,
})
-- }}}

-- Clangd setup {{{
require("lspconfig").clangd.setup({ on_attach = on_attach })
-- }}}

-- CMake setup {{{
require("lspconfig").cmake.setup({ on_attach = on_attach })
-- }}}

-- Flow setup {{{
require("lspconfig").flow.setup({ on_attach = on_attach })
-- }}}

-- Pyright setup {{{
require("lspconfig").pyright.setup({ on_attach = on_attach })
-- }}}

-- Bash Setup {{{
require("lspconfig").bashls.setup({ on_attach = on_attach })
-- }}}

-- Rust setup {{{
require("lspconfig").rls.setup({ on_attach = on_attach })
-- }}}

-- Lua setup {{{
local system_name

if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has("win32") == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = vim.fn.stdpath("cache") .. "/lspconfig/sumneko_lua/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ";")

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = runtime_path },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        preloadFileSize = 1000,
      },
      telemetry = { enable = false },
    },
  },
  on_attach = on_attach,
})
-- }}}
