local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = string.format
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

ls.add_snippets("tex", {
	s("//", fmta([[
    \frac{<>}{<>}
    ]], {i(1), i(2)})),

	s("!>", t([[\mapsto ]])),
	s("->", t([[\to ]])),
	s("==>", t([[\Rightarrow ]])),
	s("<==", t([[\Leftarrow ]])),

	s("forall", t([[\forall ]])),
	s("inn", t([[\in ]])),
	s("alpha", t([[\alpha]])),
	s("lambda", t([[\lambda]])),
	s("prt", t([[\partial]])),
	s("cc", t([[\subset]])),

    s({ trig = "(%S+)%s%s", regTrig = true },
    fmta([[<> \; ]], {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
    })),

	s("beg", fmta([[
    \begin{<>}
        <>
    \end{<>}
    ]], {i(1), i(2), rep(1)})),

	s("mbb", fmta([[\mathbb{<>}]], {i(1)})),
	s("mbf", fmta([[\mathbf{<>}]], {i(1)})),
	s("norm", fmta([[\left\lVert <> \right\rVert]], {i(1)})),
	s("prn", fmta([[\left( <> \right)]], {i(1)})),
    s("max", fmta([[\max_{<>}]], {i(1)})),
    s("min", fmta([[\min{<>}]], {i(1)})),
    s("inf", fmta([[\max_{<>}]], {i(1)})),
    s("min", fmta([[\min{<>}]], {i(1)})),

	s("0mat", fmta([[
    \begin{bmatrix}
        <>     && <>     && \cdots && <>     \\
        <>     && <>     && \cdots && <>     \\
        \vdots && \vdots && \ddots && \vdots \\
        <>     && <>     && \cdots && <>
    \end{bmatrix}
    ]], 
    {
        i(1), i(2), i(3),
        i(4), i(5), i(6),
        i(7), i(8), i(9),
    })),

	s("3mat", fmta([[
    \begin{bmatrix}
        <> && <> && <> \\
        <> && <> && <> \\
        <> && <> && <>
    \end{bmatrix}
    ]], 
    {
        i(1), i(2), i(3),
        i(4), i(5), i(6),
        i(7), i(8), i(9),
    })),

	s("3vec", fmta([[
    \begin{bmatrix}
        <> \\
        <> \\
        <>
    \end{bmatrix}
    ]], 
    {
        i(1), i(2), i(3),
    })),

	s("2vec", fmta([[
    \begin{bmatrix}
        <> \\
        <>
    \end{bmatrix}
    ]], 
    {
        i(1), i(2)
    })),

	s("0vec", fmta([[
    \begin{bmatrix}
        <> \\
        <> \\
        \vdots \\
        <>
    \end{bmatrix}
    ]], 
    {
        i(1), i(2), i(3),
    })),

	s("2mat", fmta([[
    \begin{bmatrix}
        <> && <>  \\
        <> && <>
    \end{bmatrix}
    ]], 
    {
        i(1), i(2), i(3), i(4)
    })),

	s("lim", fmta([[\lim_{<> \to <>} <> ]], {i(1), i(2, "\\infty"), i(3)})),

	s("sum", fmta([[\sum_{<>}^{<>} <> ]], {i(1, "n = 1"), i(2, "\\infty"), i(3)})),

	s("leqn", fmta([[
    $ \label{eq:<>} $ 
    ]], {i(1)})),
	s("reqn", fmta([[
    $ (\ref{eq:<>}) $ 
    ]], {i(1)})),

	s("mk", fmta([[
    $ <> $ 
    ]], {i(1)})),

	s("dm", fmta([[
    \[
        <>
    \]
    ]], {i(1)})),

    s("vec", fmta([[\vec{<>}]], {
        i(1)
    })),

    s({ trig = "(%a+)vec", regTrig = true },
    fmta([[\vec{<>}<>]], {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        i(1)
    })),

    s("hat", fmta([[\hat{<>}]], {
        i(1)
    })),

    s({ trig = "([A-Za-z0-9\\%^_{}]+)/", regTrig = true },
    fmta([[\frac{<>}{<>}]], {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        i(1)
    })),

    s({ trig = "(%(.+%))/", regTrig = true },
    fmta([[\frac{<>}{<>}]], {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        i(1)
    })),

    s({ trig = "(%a+)hat", regTrig = true },
    fmta([[\hat{<>}]], {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
    })),

    s("bar", fmta([[\overline{<>}]], {
        i(1),
    })),


    s({ trig = "(%a+)bar", regTrig = true },
    fmta([[\overline{<>}]], {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
    })),

    s({ trig = "(%a+)_(%d%d)", regTrig = true },
    fmta("<>_{<><>}", {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        f(function(_, snip)
            return snip.captures[2]
        end, {}),
        i(1),
    })),

    s({ trig = "(%a+)(%d)", regTrig = true },
    fmta("<>_{<><>}", {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        f(function(_, snip)
            return snip.captures[2]
        end, {}),
        i(1),
    })),

}, {
    type = "autosnippets",
    key = "all_auto",
})

ls.add_snippets("tex", {
    s("theorem", fmta([[
    \begin{theorem} <>
    \begin{proof}
        <>
    \end{proof}
    \end{theorem}
    ]], {i(1), i(2)})),
    s("definition", fmta([[
    \begin{definition}
        <>
    \end{definition}
    ]], {i(1)})),

	s("!!!", fmta([[
    % Russian language
    \documentclass{article}
    \usepackage[utf8]{inputenc}
    \usepackage[russian]{babel}

    % Math symbols
    \usepackage{amssymb}
    \usepackage{amsmath}
    \usepackage{amsthm}
    \usepackage{mathtools}

    % Images inplace
    \usepackage{float}
    \usepackage{graphicx}

    \newtheorem{theorem}{Теорема}
    \newtheorem{definition}{Определение}

    \begin{document}
        <>
    \end{document}
    ]], {
        i(1, "Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.")
    }))
})
