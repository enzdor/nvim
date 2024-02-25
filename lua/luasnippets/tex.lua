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

-- make bindings for:

return {
	s({ trig = "ee", dscr = "Create an environment" },
		fmta([[
			\begin{<>}
			<>
			\end{<>}
			]],
			{ i(1), i(0), rep(1) }
		)
	),
	s({ trig = "mm", dscr = "Create an equation environment" },
		fmta([[
			\begin{equation}
			<>
			\end{equation}
			]],
			{ i(0) }
		)
	),
	s({ trig = "ff", dscr = "Create a fraction" },
		fmta([[
			\frac{<>}{<>}<>
			]],
			{ i(1), i(2), i(0) }
		)
	),
	s({ trig = "var", dscr = "Variance" },
		fmta([[
			\mbox{Var}(<>)<>
			]],
			{ i(1), i(0) }
		)
	),
	s({ trig = "im", dscr = "Inline math" },
		fmta([[
			$ <> $<>
			]],
			{ i(1), i(0) })
	),
	s({ trig = "mt", dscr = "Math text box" },
		fmta([[
			\mbox{<>}<>
			]],
			{ i(1), i(0) }
		)
	),
	s({ trig = "vv", dscr = "Verbatim text, used for code" },
		fmta([[
			\verb+<>+<>
			]],
			{ i(1), i(0) }
		)
	),
	s({ trig = "bb", dscr = "Bold text" },
		fmta([[
			\textbf{<>}<>
			]],
			{ i(1), i(0) })
	),
	s({ trig = "ii", dscr = "Italicized text" },
		fmta([[
			\textit{<>}<>
			]],
			{ i(1), i(0) })
	),
	s({ trig = "hh", dscr = "Variable with hat" },
		fmta([[
			\hat{<>}<>
			]],
			{ i(1), i(0) })
	),
	s({ trig = "tt", dscr = "Variable with tilde" },
		fmta([[
			\tilde{<>}<>
			]],
			{ i(1), i(0) })
	),
	s({ trig = "whh", dscr = "Variable with widehat" },
		fmta([[
			\widehat{<>}<>
			]],
			{ i(1), i(0) })
	),
	s({ trig = "oo", dscr = "Variable with overline" },
		fmta([[
			\overline{<>}<>
			]],
			{ i(1), i(0) })
	),
	s({ trig = "nd", dscr = "New document" },
		fmta([[
			\documentclass{article}
			\usepackage{amsmath, amssymb, amsthm}

			\title{<>}
			\author{Enzo Lopes Baitello}

			\begin{document}

			\maketitle

			<>

			\end{document}
			]],
			{ i(1), i(0) })
	),
	s({ trig = "tb", dscr = "New table" },
		fmta([[
			\vspace{0.5cm}
			{
			\centering
			\begin{tabular}{<>}
				<>
			\end{tabular}\par
			}
			\vspace{0.5cm}
			]],
			{ i(1), i(0) })
	),
	s({ trig = "sum", dscr = "Summation" },
		fmta([[
			\sum_{<>}^{<>}<>
			]],
			{ i(1), i(2), i(0) })
	),
	s({ trig = ";a", dscr = "alpha" },
		fmta([[\alpha]],
			{})
	),
	s({ trig = ";b", dscr = "Beta" },
		fmta([[\beta]],
			{})
	),
	s({ trig = ";s", dscr = "Sigma" },
		fmta([[\sigma]],
			{})
	),
	s({ trig = ";D", dscr = "Delta" },
		fmta([[\Delta]],
			{})
	),
	s({ trig = ";d", dscr = "delta" },
		fmta([[\delta]],
			{})
	),
	s({ trig = "dd", dscr = "dots" },
		fmta([[\dots]],
			{})
	),
	s({ trig = ";e", dscr = "epsilon" },
		fmta([[\varepsilon]],
			{})
	),
	s({ trig = ";E", dscr = "Epsilon" },
		fmta([[\Epsilon]],
			{})
	),
	s({ trig = ";g", dscr = "gamma" },
		fmta([[\gamma]],
			{})
	),
	s({ trig = ";t", dscr = "theta" },
		fmta([[\theta]],
			{})
	),
	s({ trig = ";n", dscr = "eta" },
		fmta([[\eta]],
			{})
	),
	s({ trig = ";pi", dscr = "pi" },
		fmta([[\pi]],
			{})
	),
	s({ trig = ";vs", dscr = "variable with subscript" },
		fmta([[{<>}_{<>}<>]],
			{ i(1), i(2), i(0) })
	),
	s({ trig = ";vo", dscr = "variable with overscript" },
		fmta([[{<>}^{<>}<>]],
			{ i(1), i(2), i(0) })
	),
	s({ trig = ";vb", dscr = "variable with subscript and overscript" },
		fmta([[{<>}_{<>}^{<>}<>]],
			{ i(1), i(2), i(3), i(0) })
	),
	s({ trig = "img", dscr = "insert an image according to path" },
		fmta([[
		\begin{center}
			\includegraphics[height=6cm]{<>}
		\end{center}
		<>
		]],
			{ i(1), i(0) })
	),
	s({ trig = "tl(%d)", dscr = "Create table line", regTrig = true },
		{ d(1,
			function(args, snip)
				local nodes = {}
				local number = tonumber(snip.captures[1])
				if number ~= 0 then
					for j = 1, number do
						if j == number then
							table.insert(nodes, i(j, " "))
						else
							table.insert(nodes, i(j, " "))
							table.insert(nodes, t("&"))
						end
					end
					return sn(nil, nodes)
				else
				end
			end
		) },
		{ delimiters = "[]" }
	),
}
