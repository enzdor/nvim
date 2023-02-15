local ls = require("luasnip")
ls.config.set_config({
    enable_autosnippets = true,
    update_events = "TextChanged,TextChangedI",
    store_selection_keys = "1"
})

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/luasnippets/"})
