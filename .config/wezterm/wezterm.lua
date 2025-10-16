local wezterm = require("wezterm")
local mytable = require("lib/mystdlib").mytable

local act = wezterm.action
local config = wezterm.config_builder()

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

local local_config = {}
if mytable.isModuleAvailable("cfg_local") then
  local_config = require("cfg_local")
end
local full_config = mytable.merge_all(config, local_config, {})

return full_config
