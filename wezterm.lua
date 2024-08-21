local utf8 = require("utf8")

-- Import the wezterm module
local wezterm = require("wezterm")
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- config.color_scheme = "Tokyo Night"

-- Slightly transparent and blurred background
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 0,
}
-- config.enable_tab_bar = false -- update when I start using tmux?
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 3500

-- Close window without prmpting
config.window_close_confirmation = "NeverPrompt"

wezterm.on("update-right-status", function(window)
	-- Grab the utf8 character for the "powerline" left facing
	-- solid arrow. Fiddle with the colors to see it...
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

	local fg = window:effective_config().char_select_fg_color

	-- Make it italic and underlined
	window:set_right_status(wezterm.format({
		-- First, we draw the arrow...
		{ Background = { Color = "none" } },
		{ Foreground = { Color = "black" } },
		{ Text = SOLID_LEFT_ARROW },
		-- Then we draw our text
		{ Background = { Color = "black" } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. wezterm.hostname() .. "   " },
	}))
end)

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
