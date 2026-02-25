local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local TAB_PADDING = "    "
local TAB_COLORS = {
	inactive = {
		background = "#0F1118",
		foreground = "#C6C8D2",
	},
	active = {
		background = "#262C44",
		foreground = "#FFFFFF",
	},
}

-- タブIDごとのユーザー定義タイトルを保持する
local custom_tab_titles = {}

local function get_tab_title(tab)
	return custom_tab_titles[tab.tab_id] or tab.active_pane.title
end

local function get_tab_color(tab)
	if tab.is_active then
		return TAB_COLORS.active
	end

	return TAB_COLORS.inactive
end

local function format_tab_title(tab, max_width)
	local color = get_tab_color(tab)
	local title_text = wezterm.truncate_right(get_tab_title(tab), max_width - 1)
	local title = TAB_PADDING .. title_text .. TAB_PADDING

	return {
		{ Background = { Color = color.background } },
		{ Foreground = { Color = color.foreground } },
		{ Text = title },
	}
end

local function prompt_rename_tab_action()
	return act.PromptInputLine({
		description = "Tab名を書いてね^^",
		action = wezterm.action_callback(function(window, _, line)
			if not line then
				return
			end

			local tab = window:active_tab()
			custom_tab_titles[tab:tab_id()] = line
		end),
	})
end

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
	return format_tab_title(tab, max_width)
end)

return {
	default_prog = { "/bin/zsh", "--login" },
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 80,
	use_fancy_tab_bar = false,
	automatically_reload_config = false,
	show_new_tab_button_in_tab_bar = false,
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		"Hiragino Kaku Gothic ProN",
	}),
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	font_size = 13,
	color_scheme = "iceberg-dark",
	keys = {
		{
			key = "r",
			mods = "CMD",
			action = prompt_rename_tab_action(),
		},
		{
			key = "¥",
			mods = "OPT",
			action = act.SendString("\\"),
		},
		{
			key = "e",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
	colors = {
		cursor_bg = "#72c9d1",
		cursor_fg = "#ffffff",
		tab_bar = {
			background = TAB_COLORS.inactive.background,
		},
	},
}
