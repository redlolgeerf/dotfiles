--[[
                                     
     Blackburn Awesome WM config 2.0 
     github.com/copycat-killer       
                                     
--]]

theme                               = {}

theme.dir                           = os.getenv("HOME") .. "/.config/awesome/themes/blackburn_custom"
theme.wallpaper                     = theme.dir .. "/wall.jpg"
theme.topbar_path                   = "png:" .. theme.dir .. "/icons/topbar/"

theme.font                          = "Firamono 10.5"
theme.taglist_font                  = "Icons 10"
theme.fg_normal                     = "#D7D7D7"
theme.fg_focus                      = "#F6784F"
theme.bg_normal                     = "#060606"
theme.bg_focus                      = "#060606"
theme.fg_urgent                     = "#CC9393"
theme.bg_urgent                     = "#2A1F1E"
theme.border_width                  = "1"
theme.border_normal                 = "#0E0E0E"
theme.border_focus                  = "#F79372"

theme.taglist_fg_focus              = "#F6784F"
theme.taglist_bg_focus              = "#060606"
theme.tasklist_fg_focus             = "#F6784F"
theme.tasklist_bg_focus             = "#060606"
theme.menu_height                   = "16"
theme.menu_width                    = "140"

theme.menu_submenu_icon             = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel           = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel         = theme.dir .. "/icons/square_unsel.png"
theme.arrl_lr_pre                   = theme.dir .. "/icons/arrl_lr_pre.png"
theme.arrl_lr_post                  = theme.dir .. "/icons/arrl_lr_post.png"


theme.arrl                          = theme.dir .. "/icons/arrl.png"
theme.arrl_dl                       = theme.dir .. "/icons/arrl_dl.png"
theme.arrl_ld                       = theme.dir .. "/icons/arrl_ld.png"

theme.widget_ac                     = theme.dir .. "/icons/ac.png"
theme.widget_battery                = theme.dir .. "/icons/battery.png"
theme.widget_battery_low            = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty          = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                    = theme.dir .. "/icons/mem.png"
theme.widget_cpu                    = theme.dir .. "/icons/cpu.png"
theme.widget_temp                   = theme.dir .. "/icons/temp.png"
theme.widget_net                    = theme.dir .. "/icons/net.png"
theme.widget_hdd                    = theme.dir .. "/icons/hdd.png"
theme.widget_music                  = theme.dir .. "/icons/note.png"
theme.widget_music_on               = theme.dir .. "/icons/note_on.png"
theme.widget_vol                    = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                 = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute               = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                   = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                = theme.dir .. "/icons/mail_on.png"

theme.layout_tile                   = theme.dir .. "/icons/tile.png"
theme.layout_tileleft               = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom             = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                  = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                  = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                 = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                = theme.dir .. "/icons/dwindle.png"
theme.layout_max                    = theme.dir .. "/icons/max.png"
theme.layout_fullscreen             = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier              = theme.dir .. "/icons/magnifier.png"
theme.layout_floating               = theme.dir .. "/icons/floating.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- lain related
theme.useless_gap_width             = 10
theme.layout_uselesstile            = theme.dir .. "/icons/uselesstile.png"
theme.layout_uselesstileleft        = theme.dir .. "/icons/uselesstileleft.png"
theme.layout_uselesstiletop         = theme.dir .. "/icons/uselesstiletop.png"

return theme
