local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet


return {
    s({trig = "gr", dscr = "Create a graph"},
	fmta([[
	    .PS
	    Y: box width 0 height 0 invis at (0, <>)
	    X: box width 0 height 0 invis at (<>, 0)
	    O: box width 0 height 0 invis at (0, 0)
	    YL: box "<>" invis at (-0.25 , <>)
	    XL: box "<>" invis at (<> , -0.25)
	    arrow from O.n to Y.n
	    arrow from O.n to X.n
	    .PE
	]],
	{i(1), i(2), i(3), rep(1), i(4) ,rep(2)}
	)
    ),
    s({trig = "ln", dscr = "Create a line for a graph"},
	fmta([[
	    <>A: box width 0 height 0 invis at (<>, <>)
	    <>B: box width 0 height 0 invis at (<>, <>)
	    line from <>A.n to <>B.n
	]],
	{i(1), i(2), i(3), rep(1), i(4), i(5), rep(1), rep(1)}
	)
    ),
    s({trig = "lb", dscr = "Create a label for a graph"},
	fmta([[
	    <>L: box "<>" invis at (<>, <>)
	]],
	{i(1), i(2), i(3), i(4)}
	)
    ),
    s({trig = "lp", dscr = "Create a point for a label"},
	fmta([[
	    <>P: circle fill radius 0.025 at (<>, <>)
	]],
	{i(1), i(2), i(3)}
	)
    ),
    s({trig = "eq", dscr = "Create range for mathematical notation"},
	fmta([[
	    .EQ L
	    <>
	    .EN
	]],
	{i(0)}
	)
    ),
    s({trig = "ff", dscr = "Create notation for fraction"},
	fmta([[
	    { <> } over { <> }
	]],
	{i(1), i(2)}
	)
    ),
    s({trig = "ss", dscr = "Create notation for summation"},
	fmta([[
	    sum from { <> } to { <> }
	]],
	{i(1), i(2)}
	)
    ),
    s({trig = "pp", dscr = "Create notation for parenthesis"},
	fmta([[
	    left ( <> right )
	]],
	{i(1)}
	)
    ),
    s({trig = "bb", dscr = "Create a box"},
	fmta([[
	    <>: box "<>" invis at (<>, <>)
	]],
	{i(1), i(2), i(3), i(4)}
    )
    ),
    s({trig = "bu", dscr = "Create a bullet point"},
	fmta([[
	    .IP <>
	    <>
	]],
	{i(1, "\\(bu"), i(0)}
	)
    ),
    s({trig = "bo", dscr = "Create bold text"},
	fmta([[
	    .B "<>" <>
	    <>
	    ]],
	{i(1), i(2, ":"), i(0)}
	)
    ),
    s({trig = "tb(%d)", dscr = "Make table", regTrig = true},
	fmt([[
	    .TS
	    box, tab(>), center;
	    []
	    .TE
	]],
	{d(1,
	function(args, snip)
	    local nodes = {}
	    local number = tonumber(snip.captures[1])
	    if number ~= 0 then
		for j = 1, number do
		    if j == number then
			table.insert(nodes, i(j, "c"))
			table.insert(nodes, t({".", ""}))
			for k = 1, number do
			    if k == number then
				table.insert(nodes, i(k + j, " "))
			    else
				table.insert(nodes, i(k + j, " "))
				table.insert(nodes, t(">"))
			    end
			end
		    else
			table.insert(nodes, i(j, "c"))
			table.insert(nodes, t(" "))
		    end
		end
		return sn(nil, nodes)
	    else
	    end
	end
	)},
	{delimiters = "[]"}
	)
    ),
    s({trig = "tc(%d)", dscr = "Make changes to table style", regTrig = true},
	fmt([[
	    .T&
	    []
	]],
	{d(1,
	function(args, snip)
	    local nodes = {}
	    local number = tonumber(snip.captures[1])
	    if number ~= 0 then
		for j = 1, number do
		    if j == number then
			table.insert(nodes, i(j, "c"))
			table.insert(nodes, t({".", ""}))
			for k = 1, number do
			    if k == number then
				table.insert(nodes, i(k + j, " "))
			    else
				table.insert(nodes, i(k + j, " "))
				table.insert(nodes, t(">"))
			    end
			end
		    else
			table.insert(nodes, i(j, "c"))
			table.insert(nodes, t(" "))
		    end
		end
		return sn(nil, nodes)
	    else
	    end
	end
	)},
	{delimiters = "[]"}
	)
    ),
    s({trig = "tl(%d)", dscr = "Create table line", regTrig = true},
	{d(1,
	function(args, snip)
	    local nodes = {}
	    local number = tonumber(snip.captures[1])
	    if number ~= 0 then
		for j = 1, number do
		    if j == number then
			table.insert(nodes, i(j, " "))
		    else
			table.insert(nodes, i(j, " "))
			table.insert(nodes, t(">"))
		    end
		end
		return sn(nil, nodes)
	    else
	    end
	end
	)},
	{delimiters = "[]"}
    ),
}











