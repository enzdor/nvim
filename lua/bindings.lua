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


-- toggle_completion() -- <leader>zc -- toggle completion
vim.g.cmp_toggle_flag = true -- initialize
local toggle_completion = function()
	local ok, cmp = pcall(require, "cmp")
	if ok then
		if vim.g.cmp_toggle_flag then
			vim.g.cmp_toggle_flag = false
			cmp.setup.buffer { enabled = false }
			print("turned off")
		else
			vim.g.cmp_toggle_flag = true
			cmp.setup.buffer { enabled = true }
			print("turned on")
		end
	else
		print("completion not available")
	end
end
vim.keymap.set('n', '<leader>zc', toggle_completion, { noremap = true })

-- toggle_tabsize() -- <leader>zs -- toggle tabSize
local toggle_tabSize = function()
	if vim.bo.tabstop == 8 or vim.o.shiftwidth == 8 then
		vim.bo.tabstop = 4
		vim.o.shiftwidth = 4
		print("tabsize now 4")
	elseif vim.bo.tabstop == 4 or vim.o.shiftwidth == 4 then
		vim.bo.tabstop = 2
		vim.o.shiftwidth = 2
		print("tabsize now 2")
	elseif vim.bo.tabstop == 2 or vim.o.shiftwidth == 2 then
		vim.bo.tabstop = 8
		vim.o.shiftwidth = 8
		print("tabsize now 8")
	end
end
vim.keymap.set('n', '<leader>zs', toggle_tabSize, { noremap = true })


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
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


-- vim.cmd[[
-- " Expand or jump in insert mode
-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
--
-- " Jump forward through tabstops in visual mode
-- smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
-- imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- ]]


local capabilities = require('cmp_nvim_lsp').default_capabilities()
require 'mason'.setup {}

require 'lspconfig'.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
require 'lspconfig'.clangd.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
require 'lspconfig'.gopls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
require 'lspconfig'.pyright.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
require 'lspconfig'.tsserver.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
	update_in_insert = true,
}
)
