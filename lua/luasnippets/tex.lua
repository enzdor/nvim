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
	s({ trig = "bb", dscr = "Bold text" },
		fmta([[
			\textbf{<>}<>
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
			]],
			{ i(1), i(0) })
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
	s({ trig = "dd", dscr = "delta" },
		fmta([[\dots]],
			{})
	),
}
