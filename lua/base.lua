vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true

vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.title = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true 
vim.opt.inccommand = 'split'
vim.opt.smarttab = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.spell = true 
vim.opt.spelllang = "en"
vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.formatoptions:append { 'r'}













