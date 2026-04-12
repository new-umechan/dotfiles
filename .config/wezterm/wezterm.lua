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
	local title = custom_tab_titles[tab.tab_id] or tab.active_pane.title

    if title == "nvim" then
        local cwd = tab.active_pane.current_working_dir
        if cwd then
            local dir_name = cwd.file_path:gsub("(.*[/\\])(.*)", "%2")
			-- リッチにしたくなったら
            -- return " " .. (dir_name ~= "" and dir_name or "nvim")
			return (dir_name ~= "" and dir_name or "nvim")
        end
    end

	return title
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

wezterm.on("update-right-status", function(window, _)
	local workspaces = wezterm.mux.get_workspace_names()

	-- default しか無いなら表示しない
	if #workspaces == 1 and workspaces[1] == "default" then
		window:set_right_status("")
		return
	end

	window:set_right_status("  " .. window:active_workspace() .. "    ")
end)

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
            key = "LeftArrow",
            mods = "CMD|SHIFT",
            action = act.MoveTabRelative(-1),
        },
        {
            key = "RightArrow",
            mods = "CMD|SHIFT",
            action = act.MoveTabRelative(1),
        },
		{
			key = 'd',
			mods = 'CMD',
			action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, -- これを以下に書き換え
		},
		{
			key = 'd',
			mods = 'CMD|SHIFT',
			action = act.SplitVertical { domain = 'CurrentPaneDomain' }, -- これを以下に書き換え
		},
		{
			key = '[',
			mods = 'CMD',
			action = act.ActivatePaneDirection 'Prev',
		},
		{
			key = ']',
			mods = 'CMD',
			action = act.ActivatePaneDirection 'Next',
		},
		{
			key = 's',
			mods = 'CMD',
			action = act.ActivatePaneDirection 'Next',
		},
		{
			key = 'p',
			mods = 'CMD|SHIFT',
			action = act.ShowLauncherArgs { flags = 'WORKSPACES' , title = "Select workspace" },
		},
		{
			-- Create new workspace
			mods = 'CMD|SHIFT',
			key = 'n',
			action = act.PromptInputLine {
				description = "(wezterm) Create new workspace:",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(
							act.SwitchToWorkspace {
								name = line,
							},
							pane
						)
					end
				end),
			},
		},
		{
			-- Rename workspace
			mods = 'CMD|SHIFT',
			key = 'r',
			action = act.PromptInputLine {
				description = '(wezterm) Set workspace title:',
				action = wezterm.action_callback(function(win,pane,line)
					if line then
						wezterm.mux.rename_workspace(
							wezterm.mux.get_active_workspace(),
							line
						)
					end
				end),
			},
		},
	},
	colors = {
		cursor_bg = "#72c9d1",
		cursor_fg = "#ffffff",
		split = "#0f1117",
		tab_bar = {
			background = TAB_COLORS.inactive.background,
		},
	},
}
