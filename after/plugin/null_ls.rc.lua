local null_ls = require("null-ls")

-- for conciseness
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
	formatting.prettierd,
	formatting.prettier,
	formatting.stylua,
	formatting.rubocop,
	formatting.blue,
	formatting.rustfmt,
	formatting.sql_formatter,
	formatting.gofumpt,
	formatting.clang_format,

	--[[ code actions ]]
	code_actions.eslint_d,
}

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})
