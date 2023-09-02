local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Themes
	{
		"catppuccin/nvim",
	},

	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("kanagawa").setup({
				undercurl = true, -- enable undercurls
				commentStyle = { italic = false },
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})

			vim.cmd("colorscheme kanagawa")
		end,
	},

	{ "folke/tokyonight.nvim" },

	-- Git
	"dinhhuy258/git.nvim",
	"lewis6991/gitsigns.nvim",

	--- Github Copilot
	"github/copilot.vim",

	-- UI
	"nvim-lualine/lualine.nvim",
	{
		"lukas-reineke/indent-blankline.nvim",
		priority = 900, -- make sure to load this before all the other start plugins
	},
	"kyazdani42/nvim-web-devicons",
	"nvim-treesitter/nvim-treesitter",

	-- UTILS
	"numToStr/Comment.nvim",
	"windwp/nvim-autopairs",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"nvim-telescope/telescope-file-browser.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-lua/plenary.nvim",

	-- LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"jayp0521/mason-null-ls.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"onsails/lspkind-nvim",
	"glepnir/lspsaga.nvim",

	-- CMP
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
})
