local status, telescope = pcall(require, "telescope")
if not status then
    return
end

local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        file_ignore_patterns = {"node_modules", ".git", ".vscode", "target", "packer_compiled.lua"},
        mappings = {
            n = {
                ["q"] = actions.close
            }
        }
    },
    pickers = {
        diagnostics = {
            theme = "ivy",
            initial_mode = "normal",
            layout_config = {
                preview_cutoff = 9999
            }
        }
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            theme = "dropdown",
            previewer = false,
            grouped = true,
            layout_config = {
                height = 40
            },
            mappings = {
                -- your custom insert mode mappings
                ["i"] = {
                    ["<C-w>"] = function()
                        vim.cmd("normal vbd")
                    end
                },
                -- your custom insert mode mappings
                ["n"] = {
                    -- your custom normal mode mappings
                    ["N"] = fb_actions.create,
                    ["h"] = fb_actions.goto_parent_dir,
                    ["D"] = fb_actions.remove,
                    ["r"] = fb_actions.rename,
                    ["/"] = function()
                        vim.cmd("startinsert")
                    end,
                    ["<C-u>"] = function(prompt_bufnr)
                        for i = 1, 10 do
                            actions.move_selection_previous(prompt_bufnr)
                        end
                    end,
                    ["<C-d>"] = function(prompt_bufnr)
                        for i = 1, 10 do
                            actions.move_selection_next(prompt_bufnr)
                        end
                    end,
                    ["<PageUp>"] = actions.preview_scrolling_up,
                    ["<PageDown>"] = actions.preview_scrolling_down
                }
            }
        }
    }
})
telescope.load_extension("fzf")
telescope.load_extension("file_browser")

-- Find Plugin File
vim.keymap.set("n", "<leader>fP", function()
    builtin.find_files({
        cwd = require("lazy.core.config").options.root
    })
end)

-- Lists files in your current working directory, respects .gitignore
vim.keymap.set("n", ";f", function()
    builtin.find_files({
        no_ignore = false,
        hidden = true
    })
end)

-- Search for a string in your current working directory and get results live as you type, respects .gitignore
vim.keymap.set("n", ";d", function()
    builtin.live_grep({
        additional_args = {"--hidden"}
    })
end)

-- Lists open buffers
vim.keymap.set("n", ";b", function()
    builtin.buffers()
end)

-- Lists available help tags and opens a new window with the relevant help info on <cr>
vim.keymap.set("n", ";t", function()
    builtin.help_tags()
end)

-- Resume the previous telescope picker
vim.keymap.set("n", ";;", function()
    builtin.resume()
end)

-- Lists Diagnostics for all open buffers or a specific buffer
vim.keymap.set("n", ";e", function()
    builtin.diagnostics()
end)

-- Lists Function names, variables, from Treesitter
vim.keymap.set("n", ";s", function()
    builtin.diagnostics()
end)

-- Open File Browser with the path of the current buffer
vim.keymap.set("n", "sf", function()
    local function telescope_buffer_dir()
        return vim.fn.expand("%:p:h")
    end

    telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = {
            height = 40
        }
    })
end)
