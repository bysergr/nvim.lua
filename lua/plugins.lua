local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo(
			{ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } },
			true,
			{}
		)
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opts = {
	defaults = {
		lazy = true,
		version = false,
	},
	checker = {
		enabled = true,
	},
	performance = {
		cache = {
			enabled = true,
		},
	},
	debug = false,
}

local plugins = { -- Themes
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				undercurl = true, -- enable undercurls
				commentStyle = {
					italic = false,
				},
				keywordStyle = {
					italic = false,
				},
				statementStyle = {
					bold = true,
				},
				typeStyle = {},
				transparent = true, -- do not set background color
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				theme = "dragon", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "dragon", -- try "dragon" !
					light = "lotus",
				},
			})
		end,
	},
	{
		"loctvl842/monokai-pro.nvim",
		name = "monokai-pro",
		lazy = false,
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				transparent_background = true,
				terminal_colors = true,
				devicons = true, -- highlight the icons of `nvim-web-devicons`
				styles = {
					comment = {
						italic = true,
					},
					keyword = {
						italic = true,
					}, -- any other keyword
					type = {
						italic = true,
					}, -- (preferred) int, long, char, etc
					storageclass = {
						italic = true,
					}, -- static, register, volatile, etc
					structure = {
						italic = true,
					}, -- struct, union, enum, etc
					parameter = {
						italic = true,
					}, -- parameter pass in function
					annotation = {
						italic = true,
					},
					tag_attribute = {
						italic = true,
					}, -- attribute of tag in reactjs
				},
				filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
				-- Enable this will disable filter option
				day_night = {
					enable = false, -- turn off by default
					day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
					night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
				},
				inc_search = "background", -- underline | background
				background_clear = { -- "float_win",
					"toggleterm",
					"telescope", -- "which-key",
					"renamer",
					"notify", -- "nvim-tree",
				},
				plugins = {
					bufferline = {
						underline_selected = false,
						underline_visible = false,
					},
					indent_blankline = {
						context_highlight = "default", -- default | pro
						context_start_underline = false,
					},
				},
			})

			-- vim.cmd("colorscheme monokai-pro")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = true, -- Force no italic
			})

			vim.cmd("colorscheme catppuccin")
		end,
	},
	-- Git
	"dinhhuy258/git.nvim",
	"lewis6991/gitsigns.nvim",

	-- ui
	"nvim-lualine/lualine.nvim",
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},

	"kyazdani42/nvim-web-devicons",
	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		dependencies = { "windwp/nvim-ts-autotag" },
		config = function()
			-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
			-- 	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			-- 		underline = true,
			-- 		virtual_text = {
			-- 			spacing = 5,
			-- 		},
			-- 		update_in_insert = true,
			-- 	})

			require("nvim-treesitter.configs").setup({
				sync_install = true,
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				ensure_installed = {
					"tsx",
					"lua",
					"cpp",
					"go",
					"rust",
					"python",
					"css",
					"html",
					"json5",
					"javascript",
					"typescript",
					"markdown",
					"markdown_inline",
					"astro",
					"sql",
					"gomod",
					"gosum",
					"bash",
					"dockerfile",
					"php",
				},
			})
		end,
	},

	-- UTILS
	{
		"github/copilot.vim",
		lazy = false,
	},
	"numToStr/Comment.nvim",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufRead",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
	"nvim-telescope/telescope-file-browser.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-lua/plenary.nvim", -- LSP
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig",
	"jose-elias-alvarez/null-ls.nvim",
	"onsails/lspkind-nvim",
	"glepnir/lspsaga.nvim", -- CMP
	{
		"hrsh7th/nvim-cmp",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
		lazy = false,
	},
}

require("lazy").setup(plugins, opts)
