-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Colors
local colors = require("chalet_colors")

config.color_scheme = "chalet"
config.color_schemes = {
    ["chalet"] = {
        background = colors.bg,
        foreground = colors.fg,
        brights = {
            colors.ansi.bright_black,
            colors.ansi.bright_red,
            colors.ansi.bright_green,
            colors.ansi.bright_yellow,
            colors.ansi.bright_blue,
            colors.ansi.bright_magenta,
            colors.ansi.bright_cyan,
            colors.ansi.bright_white,
        },
        ansi = {
            colors.ansi.black,
            colors.ansi.red,
            colors.ansi.green,
            colors.ansi.yellow,
            colors.ansi.blue,
            colors.ansi.magenta,
            colors.ansi.cyan,
            colors.ansi.white,
        },
    },
}

-- chalet
config.colors = {
    tab_bar = {
        background = colors.bg,

        active_tab = {
            bg_color = colors.bg,
            fg_color = colors.dark_red,
        },

        inactive_tab = {
            bg_color = colors.bg,
            fg_color = colors.light_brown,
        },

        inactive_tab_hover = {
            bg_color = colors.bg,
            fg_color = colors.light_brown,
            italic = false,
            intensity = "Bold",
        },

        new_tab = {
            bg_color = colors.bg,
            fg_color = colors.light_brown,
        },

        new_tab_hover = {
            bg_color = colors.bg,
            fg_color = colors.light_brown,
            italic = false,
            intensity = "Bold",
        },
    },
    selection_bg = colors.light_brown,
    selection_fg = colors.bg,
    cursor_bg = colors.bg,
    cursor_fg = colors.bg,
    cursor_border = colors.bg,
}
config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.5,
}


-- Background
config.background = {
    {
        source = { Color = colors.bg },
        height = "100%",
        width = "100%",
        opacity = 0.91
    }
}

-- Font
config.font = wezterm.font("UbuntuMono Nerd Font")
config.font_size = 17

-- Tab bar
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 8
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = false
wezterm.on("format-tab-title", function()
    return {
        { Text = "  " },
    }
end)

-- Cursor & Selection
config.force_reverse_video_cursor = true

-- Window
config.window_padding = {
    left = "1cell",
    right = "1cell",
    top = "0.5cell",
    bottom = "0.5cell",
}
config.window_decorations = "RESIZE"

-- Keybindings
config.disable_default_key_bindings = true

config.keys = {
    -- Tabs
    { key = "1",          mods = "ALT",   action = wezterm.action.ActivateTab(0) },
    { key = "2",          mods = "ALT",   action = wezterm.action.ActivateTab(1) },
    { key = "3",          mods = "ALT",   action = wezterm.action.ActivateTab(2) },
    { key = "4",          mods = "ALT",   action = wezterm.action.ActivateTab(3) },
    -- Panes
    -- { key = "Space",      mods = "ALT",   action = wezterm.action.ActivatePaneDirection("Prev") },
    { key = "h",          mods = "ALT",   action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j",          mods = "ALT",   action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k",          mods = "ALT",   action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "l",          mods = "ALT",   action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "d",          mods = "ALT",   action = wezterm.action.CloseCurrentPane { confirm = false } },
    { key = "z",          mods = "ALT",   action = wezterm.action.TogglePaneZoomState },
    { key = "LeftArrow",  mods = "ALT",   action = wezterm.action.AdjustPaneSize { "Left", 1 } },
    { key = "RightArrow", mods = "ALT",   action = wezterm.action.AdjustPaneSize { "Right", 1 } },
    { key = "UpArrow",    mods = "ALT",   action = wezterm.action.AdjustPaneSize { "Up", 1 } },
    { key = "DownArrow",  mods = "ALT",   action = wezterm.action.AdjustPaneSize { "Down", 1 } },
    -- Clipboard
    { key = "Insert",     mods = "CTRL",  action = wezterm.action.CopyTo("Clipboard") },
    { key = "Insert",     mods = "SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "Insert",     mods = "ALT",   action = wezterm.action.PasteFrom("PrimarySelection") },
    -- Debug
    { key = "B",          mods = "ALT",   action = wezterm.action.ShowDebugOverlay },
    -- Font size
    { key = "=",          mods = "ALT",   action = wezterm.action.IncreaseFontSize },
    { key = "-",          mods = "ALT",   action = wezterm.action.DecreaseFontSize },
}


config.mouse_bindings = {
    -- Use Ctrl/Shift + Insert to copy/paste with clipboard
    -- Use Right-Click to paste selection, selection is never sent to clipboard
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wezterm.action.PasteFrom("PrimarySelection"),
    },
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = wezterm.action.CompleteSelection("PrimarySelection"),
    },
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "SHIFT",
        action = wezterm.action.CompleteSelection("PrimarySelection"),
    },
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "ALT",
        action = wezterm.action.CompleteSelection("PrimarySelection"),
    },
    {
        event = { Up = { streak = 2, button = "Left" } },
        mods = "NONE",
        action = wezterm.action.CompleteSelection("PrimarySelection"),
    },
    {
        event = { Up = { streak = 3, button = "Left" } },
        mods = "NONE",
        action = wezterm.action.CompleteSelection("PrimarySelection"),
    },
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

config.window_close_confirmation = "NeverPrompt"

wezterm.on("gui-startup", function(cmd)
    local shell_bin = "/bin/zsh"
    local tab, _, window = wezterm.mux.spawn_window(cmd or { args = { shell_bin } })

    for _ = 1, 3 do
        window:spawn_tab { args = { shell_bin } }
    end

    tab:activate()
end)

return config
