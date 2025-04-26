local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("cpp", {
    s("kyopro", {  -- トリガーは `;main`
        t({"#include <bits/stdc++.h>", "using namespace std;", "", "int main(void) {", "    "}),
        i(1, "// ここにコードを書く"),  -- 最初の挿入ポイント
		t({"", "", "    return 0;", "}"})
    }),
})
