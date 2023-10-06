require('telescope').setup{
    defaults = {
	mappings = {
	    i = {
		['<C-s>'] = require("telescope.actions").select_vertical,
		['<C-v>'] = false,
	    },
	    n = {
		['<C-s>'] = require("telescope.actions").select_vertical,
		['<C-v>'] = false,
	    }
	}
    }
}

