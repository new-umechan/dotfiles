local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

return {
  s("td;", {
	f(function()
	  return os.date("%y%m%d")
	end),
  }),
}
