local configs = require'nvim-treesitter.configs'
configs.setup {
	ensure_installed = {"c", "css", "html", "javascript", "typescript", "lua", "python", "bash", "go"}, -- Only use parsers that are maintained
	highlight = { -- enable highlighting
		enable = true, 
	},
	indent = {
		enable = false, -- default is disabled anyways
	}, 
}
