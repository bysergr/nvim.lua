require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"tailwindcss",
		"pyright",
		"rust_analyzer",
		"astro",
		"cssls",
		"emmet_ls",
    "svelte-language-server",
  },
  automatic_installation = { exclude = { "clangd" } }
})

require("mason-null-ls").setup({
	ensure_installed = {
		"prettierd",
		"prettier",
		"rustfmt",
		"gofumpt",

		"eslint_d",
	},
	automatic_installation = true,
})

local util = require("lspconfig/util")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
vim.lsp.set_log_level("debug")

local on_attach = function(_client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)

	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)

	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)

  vim.cmd([[
            augroup formatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                autocmd BufWritePre <buffer> lua goimports(1000)
            augroup END
        ]])

  -- Set autocommands conditional on server_capabilities
  vim.cmd([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])

end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())


  function goimports(timeoutms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end


require("lspconfig").tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function(_)
		return vim.loop.cwd()
	end,
})

require'lspconfig'.elixirls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

require("lspconfig").pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig")["tsserver"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig")["rust_analyzer"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").astro.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").svelte.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
	flags = {
		debounce_text_changes = 150,
	},
})

require("lspconfig").golangci_lint_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}

local clangd_capabilities = capabilities
clangd_capabilities.textDocument.semanticHighlighting = true
clangd_capabilities.offsetEncoding = "utf-8"
require("lspconfig").clangd.setup({
	on_attach = on_attach,
	capabilities = clangd_capabilities,
})

require("lspconfig").emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
