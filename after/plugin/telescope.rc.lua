local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
	defaults = {
    file_ignore_patterns = {'node_modules', '.git', '.vscode'},
		defaults = {},
		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
		  grouped = true,
      hidden = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					["<C-w>"] = function()
						vim.cmd("normal vbd")
					end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["D"] = fb_actions.remove,
					["r"] = fb_actions.rename,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
	},
})

telescope.load_extension("file_browser")

vim.keymap.set("n", ";f", function()
	builtin.find_files(themes.get_dropdown())
end)
vim.keymap.set("n", ";b", function()
	builtin.live_grep(themes.get_dropdown())
end)
vim.keymap.set("n", ";b", function()
	builtin.buffers(themes.get_dropdown())
end)
vim.keymap.set("n", ";t", function()
	builtin.help_tags(themes.get_dropdown())
end)
vim.keymap.set("n", ";;", function()
	builtin.resume(themes.get_dropdown())
end)
vim.keymap.set("n", ";e", function()
	builtin.diagnostics(themes.get_dropdown())
end)
vim.keymap.set("n", "sf", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
    hidden = true,
		grouped = true,
		initial_mode = "insert",
	})
end)
