local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.setup({
	-- Options with default value
	-- "single" | "double" | "rounded" | "bold" | "plus"
	border_style = "rounded",
	--the range of 0 for fully opaque window (disabled) to 100 for fully
	--transparent background. Values between 0-30 are typically most useful.
	saga_winblend = 10,
	lightbulb = {
		virtual_text = true,
		sign = false,
	},
	beacon = {
		enable = false,
	},
	outline = {
		close_after_jump = true,
		layout = "float",
	},
	symbol_in_winbar = {
		enable = true,
		separator = "  ",
		hide_keyword = true,
		show_file = true,
		folder_level = 1,
		respect_root = false,
		color_mode = true,
	},
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "<C-k>", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "gl", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gc", "<Cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga finder<CR>", opts)

vim.keymap.set("n", "gd", "<Cmd>Lspsaga  goto_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga term_toggle<CR>", opts)
vim.keymap.set("n", "<A-f>", "<cmd>Lspsaga outline<CR>", opts)
