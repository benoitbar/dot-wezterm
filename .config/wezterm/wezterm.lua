local wezterm = require("wezterm")
local mytable = require("lib/mystdlib").mytable

local act = wezterm.action
local config = wezterm.config_builder()

config.enable_wayland = true

config.color_scheme = "Tango (terminal.sexy)"
config.default_prog = { "/usr/bin/zsh" }
config.font = wezterm.font("Hack")
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}
config.window_background_opacity = 0.80

config.keys = {
  {
    key = "8",
    mods = "CTRL|SHIFT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "6",
    mods = "CTRL|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
}

config.mouse_bindings = {
  -- Disable the default click behavior
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
  },
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  -- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.Nop,
  },
}

local local_config = {}
if mytable.isModuleAvailable("cfg_local") then
  local_config = require("cfg_local")
end
local full_config = mytable.merge_all(config, local_config, {})

return full_config
