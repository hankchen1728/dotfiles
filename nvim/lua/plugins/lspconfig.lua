local present, lsp_config = pcall(require, "lspconfig")
local saga_present, saga = pcall(require, "lspsaga")
if not present then
   return
end
-- local cmd = vim.cmd
local util = lsp_config.util
local path = lsp_config.util.path

if saga_present then
  saga.init_lsp_saga {use_saga_diagnostic_sign = true}
end

-- Setting keybinds
local function on_attach(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = {noremap = true, silent = true}

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "<F3>", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<space>bf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  if not saga_present then
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap('n', 'gA', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('v', 'gA', ':<C-U>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap("n", "[e", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]e", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  else
    buf_set_keymap('n', 'gh', "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>", opts)
    -- buf_set_keymap("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
    -- buf_set_keymap("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
    -- buf_set_keymap("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
    buf_set_keymap('n', "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
    buf_set_keymap('n', "gA", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
    buf_set_keymap('v', "gA", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
    buf_set_keymap('n', "[e", "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<cr>", opts)
    buf_set_keymap('n', "]e", "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<cr>", opts)
    vim.cmd("au CursorHold <buffer> lua require('lspsaga.diagnostic').show_cursor_diagnostics()")
  end
end

-- Setup servers for languages
-- local util = require("lspconfig/util")
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = path.join(vim.fn.expand("$HOME"), ".local", "lua-language-server")

local servers = {
  pyright = {},
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      -- "--all-scopes-completion",
      -- "--completion-style=detailed"
    }
  },
  -- Language server for verilog and SystemVerilog
  svls = {
    root_dir = function(fname)
      local root_file = ".svls.toml"
      return util.root_pattern(root_file)(fname) or util.find_git_ancestor(fname)
    end
  },
  sumneko_lua = {
    cmd = {
      sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server",
      "-E", sumneko_root_path .. "/main.lua"
    },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

for server, config in pairs(servers) do
  config.flags = {debounce_text_changes = 500}
  config.on_attach = on_attach
  config.capabilities = capabilities  -- for LSP snippet support
  lsp_config[server].setup(config)
end

-- border for floating window
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = {prefix = "", spacing = 0},
    signs = true,
    underline = true,
    update_in_insert = false, -- update diagnostics insert mode
  }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
   border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
   border = "single",
})

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
   vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefault" .. name })
end

lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Warning", "")
