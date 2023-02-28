local cmp = require("cmp")
local ls = require("luasnip")

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
	expand = function(args)
	    ls.lsp_expand(args.body)
	end,
    },
    mapping = {
    --     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
	['<C-Space>'] = cmp.mapping.complete(),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
	["<Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
		cmp.select_next_item()
	      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
	      -- they way you will only jump inside the snippet region
	      elseif ls.expand_or_jumpable() then
		ls.expand_or_jump()
	      elseif has_words_before() then
		cmp.complete()
	      else
		fallback()
	      end
	    end, { "i", "s" }),

	    ["<S-Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
		cmp.select_prev_item()
	      elseif ls.jumpable(-1) then
		ls.jump(-1)
	      else
		fallback()
	      end
	    end, { "i", "s" }),
    },
    sources = cmp.config.sources({
	{ name = 'nvim_lsp'},
	{ name = 'luasnip' },
	{ name = 'buffer' }
    }),
})



