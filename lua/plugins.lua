local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("bluz71/vim-nightfly-guicolors")
	use("nvim-lualine/lualine.nvim")
	use("wbthomason/packer.nvim")
	use("sainnhe/sonokai")
	use("Shatur/neovim-ayu")
	use("dinhhuy258/git.nvim")
	use("lewis6991/gitsigns.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" }) --Snippet
	use("rafamadriz/friendly-snippets")
	use("saadparwaiz1/cmp_luasnip")
	use({ "mangeshrex/everblush.vim" })
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
	use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
	use("hrsh7th/nvim-cmp") -- Completion
	use({
		"numToStr/Comment.nvim",
	})
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"jayp0521/mason-null-ls.nvim",
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use("folke/tokyonight.nvim")
	use("windwp/nvim-ts-autotag")

	use("kyazdani42/nvim-web-devicons") -- File icons

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use("norcalli/nvim-colorizer.lua")
	use("glepnir/lspsaga.nvim") -- LSP UIs
	use("akinsho/nvim-bufferline.lua")
end)
