local keymap = vim.keymap

-- Delete Word from the front
keymap.set("n", "x", '"_x')

-- Visual Block
keymap.set("n", "bv", "<C-v>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
keymap.set("n", "te", ":tabedit ")

-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")

-- Move window
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "so", "<C-w><")
keymap.set("n", "sp", "<C-w>>")
keymap.set("n", "s+", "<C-w>+")
keymap.set("n", "s-", "<C-w>-")

-- Buffers
keymap.set("n", "<C-p>", ":bn<CR>")
keymap.set("n", "<C-o>", ":bp<CR>")
keymap.set("n", "<C-x>", ":bd<CR>")
