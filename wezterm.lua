-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = 'midnight-in-mojave'
config.font = wezterm.font 'Fira Code'
config.font_size = 18.0
config.scrollback_lines = 100000

-- and finally, return the configuration to wezterm
return config
