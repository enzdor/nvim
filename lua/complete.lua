local cmp = require("cmp")
local ls = require("luasnip")

cmp.setup({
    snippet = {
	expand = function(args)
	    ls.lsp_expand(args.body)
	end,
    },
    mapping = {
	['<C-b>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
    },
    sources = cmp.config.sources({
	{ name = 'luasnip' },
    }),
    {
	{ name = 'buffer' }
    }
})

