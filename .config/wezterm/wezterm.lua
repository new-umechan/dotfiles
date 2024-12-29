local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- タブタイトルを保存するためのテーブルを作成
local custom_tab_titles = {}

wezterm.on('gui-startup', function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#0F1118"
	local foreground = "#C6C8D2"

	if tab.is_active then
		background = "#262C44"
		-- background = "#CC517A"
		foreground = "#FFFFFF"
	end

	-- タブIDに基づいてカスタムタイトルを取得、なければデフォルトのタイトルを使用
	local user_title = custom_tab_titles[tab.tab_id] or tab.active_pane.title
	local title = "    " .. wezterm.truncate_right(user_title, max_width - 1) .. "    "

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	}
end)

return {
	-- default をweztermへ
	default_prog = {"/bin/zsh", "--login"},

	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 80,

	use_fancy_tab_bar = false,

	-- wezterm.luaの更新を検知して自動的にreloadしてくれます。
	automatically_reload_config = false,
	-- タブの閉じるボタンを非表示にする
	show_new_tab_button_in_tab_bar = false,
	-- バックスラッシュを入力できるようにする
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,

	-- フォントとフォールバック設定
	font = wezterm.font_with_fallback({
		"JetBrains Mono",               -- 英語用フォント
		"Hiragino Kaku Gothic ProN",    -- 日本語用フォント
	}),

	-- リガチャを無効化
	harfbuzz_features = {"calt=0", "clig=0", "liga=0"}, 
	font_size = 13,

	-- Icebergのカラースキーム
	color_scheme = "iceberg-dark",

	-- キー設定
	keys = {
		{
			key = 'R',
			mods = 'CTRL|SHIFT',
			action = act.PromptInputLine {
				description = 'Tab名を書いてね^^',
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						-- タブIDに基づいてタイトルを保存
						local tab = window:active_tab()
						custom_tab_titles[tab:tab_id()] = line
					end
				end),
			},
		},
		{
			key = '¥',
			mods = 'OPT',
			action = act.SendString("\\"),
		},
		{
			key = 'e', -- 小文字に修正
			mods = 'CTRL',
			action = wezterm.action.DisableDefaultAssignment,
		},
	},

	colors = {
		cursor_bg = "#72c9d1",
		cursor_fg = "#ffffff",
		tab_bar = {
			background = "#0F1118",  -- タブバーの背景色
		},
	},
}
