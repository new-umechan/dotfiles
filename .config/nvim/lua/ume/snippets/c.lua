local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("c", {
    s("cmain", {  -- トリガーは `;main`
        t({"#include <stdio.h>", "", "int main() {", "    "}),
        i(1, "// ここにコードを書く"),  -- 最初の挿入ポイント
        t({"", "    return 0;", "}"})
    }),
})
