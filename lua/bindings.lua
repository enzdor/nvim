-- BINDINGS
vim.keymap.set('n', '<leader>p', '"+p', {})
vim.keymap.set('v', '<leader>y', '"+yy', {})
vim.keymap.set('n', '<leader>ww', ':set wrap!<CR>', { noremap = true })
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', { noremap = true })
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', { noremap = true })
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', { noremap = true })
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', { noremap = true })
vim.keymap.set('n', '<leader>s', ':Telescope find_files <CR>', {})
vim.keymap.set('n', '<leader>t', ':Telescope live_grep <CR>', {})
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { noremap = true })

-- Auto-correct previous spelling mistake
vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', {})

-- toggle horizontal and vertical split
local toggle_vertical_horizontal = function()
	local layout = vim.fn.winlayout(vim.fn.tabpagenr())
	if layout[1] == "col" then
		vim.cmd("wincmd L")
	elseif layout[1] == "row" then
		vim.cmd("wincmd K")
	end
end
vim.keymap.set('n', '<leader>1', toggle_vertical_horizontal, { noremap = true })

local increase_size = function()
	local layout = vim.fn.winlayout(vim.fn.tabpagenr())
	if layout[1] == "col" then
		vim.cmd("8 wincmd +")
	elseif layout[1] == "row" then
		vim.cmd("8 wincmd >")
	end
end

local decrease_size = function()
	local layout = vim.fn.winlayout(vim.fn.tabpagenr())
	if layout[1] == "col" then
		vim.cmd("8 wincmd -")
	elseif layout[1] == "row" then
		vim.cmd("8 wincmd <")
	end
end


vim.keymap.set('n', '<leader>9', decrease_size, { noremap = true })
vim.keymap.set('n', '<leader>0', increase_size, { noremap = true })

-- toggle_completion() -- <leader>zc -- toggle completion
vim.g.cmp_toggle_flag = true -- initialize
local toggle_completion = function()
	local ok, cmp = pcall(require, "cmp")
	if ok then
		if vim.g.cmp_toggle_flag then
			vim.g.cmp_toggle_flag = false
			cmp.setup.buffer { enabled = false }
			print("completion turned off")
		else
			vim.g.cmp_toggle_flag = true
			cmp.setup.buffer { enabled = true }
			print("completion turned on")
		end
	else
		print("completion not available")
	end
end
vim.keymap.set('n', '<leader>zc', toggle_completion, { noremap = true })


-- toggle_tabsize() -- <leader>zs -- toggle tabSize
local toggle_tabSize = function()
	if vim.bo.tabstop == 8 or vim.bo.shiftwidth == 8 then
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		print("tabsize = 4")
	elseif vim.bo.tabstop == 4 or vim.bo.shiftwidth == 4 then
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		print("tabsize = 2")
	elseif vim.bo.tabstop == 2 or vim.bo.shiftwidth == 2 then
		vim.bo.tabstop = 8
		vim.bo.shiftwidth = 8
		print("tabsize = 8")
	end
end
vim.keymap.set('n', '<leader>zs', toggle_tabSize, { noremap = true })


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end



local capabilities = require('cmp_nvim_lsp').default_capabilities()
require 'mason'.setup {}

require 'lspconfig'.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
require 'lspconfig'.clangd.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--fallback-style=webkit"
	}
}
require 'lspconfig'.gopls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
require 'lspconfig'.pyright.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
require 'lspconfig'.ts_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

vim.diagnostic.config({
	update_in_insert = true,
})
