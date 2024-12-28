require("mason").setup()

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

	vim.cmd([[
            augroup formatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
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
local lspconfig = require("lspconfig")

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	root_dir = function(_)
		return vim.loop.cwd()
	end,
})

lspconfig.clojure_lsp.setup({
	capabilities = capabilities,
})

lspconfig.metals.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.phan.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
})

lspconfig.elixirls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/bysergr/.config/elixir/language_server.sh" },
})

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.emmet_language_server.setup({})

lspconfig.ts_ls.setup({
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/home/bysergr/.nvm/versions/node/v20.12.2/lib/node_modules/@vue/language-server",
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},

	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = false,
			},
			checkOnSave = {
				command = "clippy",
				extraArg = { "--fix" },
			},
		},
	},
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

lspconfig.volar.setup({})

lspconfig.dartls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.astro.setup({
	capabilities = capabilities,
})

lspconfig.svelte.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

local function organize_imports(client, bufnr)
	local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
	params.context = { only = { "source.organizeImports" } }

	local resp = client.request_sync("textDocument/codeAction", params, 3000, bufnr)
	for _, r in pairs(resp and resp.result or {}) do
		if r.edit then
			vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
		else
			vim.lsp.buf.execute_command(r.command)
		end
	end
end

lspconfig.gopls.setup({
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				organize_imports(client, bufnr)
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
	capabilities = capabilities,
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
})

lspconfig.golangci_lint_ls.setup({
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
})

local clangd_capabilities = capabilities
clangd_capabilities.textDocument.semanticHighlighting = true
clangd_capabilities.offsetEncoding = "utf-8"
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = clangd_capabilities,
})
