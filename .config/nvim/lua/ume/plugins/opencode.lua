return {
	"NickvanDyke/opencode.nvim",
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			provider = {
				enabled = "terminal",
				terminal = {
					-- ...
				}
			}
		}

		-- Required for `opts.events.reload`.
		vim.o.autoread = true

		-- keymap
		vim.keymap.set({ "n", "t" }, "<leader>o", function()
		  require("opencode").toggle()
		end, { desc = "opencode: toggle" })

		vim.keymap.set({ "n", "x" }, "?", function()
		  require("opencode").ask("@this: ", { submit = true })
		end, { desc = "opencode: ask" })

		vim.keymap.set({ "n", "x" }, "<leader>:", function()
		  require("opencode").select()
		end, { desc = "opencode: command palette" })


		vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { expr = true, desc = "Add range to opencode" })
		vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" })

		vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
		vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
	end,
}
