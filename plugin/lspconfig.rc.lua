require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"tailwindcss",
		"jedi_language_server",
		"rust_analyzer",
		"astro",
		"gopls",
		"cssls",
		"emmet_ls",
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
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function(_)
		return vim.loop.cwd()
	end,
})

require("lspconfig").jedi_language_server.setup({
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
