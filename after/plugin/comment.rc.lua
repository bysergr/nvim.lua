require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	toggler = {
		---Line-comment toggle keymap
		line = ",c",
		---Block-comment toggle keymap
		block = ",d",
	},
	opleader = {
		---Line-comment keymap
		line = ",c",
		---Block-comment keymap
		block = ",b",
	},
})
