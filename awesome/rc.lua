--[[

     Blackburn Awesome WM config 2.0 
     github.com/copycat-killer       
                                     
--]]

-- {{{ Required libraries
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
require("awful.autofocus")
require("eminent")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local drop      = require("scratchdrop")
local lain      = require("lain")
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- run_once("urxvtd")
run_once("unclutter")
run_once("setxkbmap us,ru")
run_once("xscreensaver -no-splash")
run_once("xfce4-clipman &")
run_once("compton &")
run_once("devilspie &")
run_once("rofi -key-run F2 &")
-- }}}

-- {{{ Variable definitions
-- localization
os.setlocale(os.getenv("LANG"))

-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/blackburn_custom/theme.lua")

-- common
modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "alacritty"
editor     = os.getenv("EDITOR") or "vim" or "nano"
editor_cmd = terminal .. " -e " .. editor

-- user defined
browser    = "firefox"
browser2   = "iron"
gui_editor = "gvim"
graphics   = "gimp"

local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.fair, -- good
    lain.layout.uselesstile.left, -- ok
    lain.layout.centerwork,
    -- lain.layout.uselesstile.top, -- 3
    -- lain.layout.termfair,
    -- lain.layout.centerfair,
    -- lain.layout.uselessfair,
    -- lain.layout.uselesspiral,
}
-- }}}

-- {{{ Tags
tags = {
   names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
   layout = { layouts[1], layouts[1], layouts[2], layouts[1], layouts[5] }
}
for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, layouts[2])
end

-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Menu
require("freedesktop/freedesktop")
-- }}}

-- {{{ Wibox
markup = lain.util.markup
gray   = "#9E9C9A"

-- Mail widget
mailicon = wibox.widget.imagebox(beautiful.widget_mail)
mail_widget = lain.widgets.maildir({
	maildir = os.getenv("HOME") .. "/mail/INBOX/new",
	timeout = 60,
	settings = function()
		widget:set_markup(markup("#7AC82E", " " .. newmail))
	end,
})
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell("ls ~/mail/INBOX/new | wc -l") end)))
--
-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(" %a %d %b  %H:%M")

-- Calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })

-- MEM
memicon = wibox.widget.imagebox(beautiful.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_text(" " .. mem_now.used .. "MB ")
    end
})

-- CPU
cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
cpuwidget = wibox.widget.background(lain.widgets.cpu({
    settings = function()
        widget:set_text(" " .. cpu_now.usage .. "% ")
    end
}), "#313131")

-- / fs
fsicon = wibox.widget.imagebox(beautiful.widget_hdd)
fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_text(" " .. fs_now.used .. "% ")
    end
})
fswidgetbg = wibox.widget.background(fswidget, "#313131")

-- Volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(beautiful.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(beautiful.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(beautiful.widget_vol_low)
        else
            volicon:set_image(beautiful.widget_vol)
        end

        widget:set_text(" " .. volume_now.level .. "% ")
    end
})

-- Net
neticon = wibox.widget.imagebox(beautiful.widget_net)
neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(iptraf) end)))
netwidget = wibox.widget.background(lain.widgets.net({
    settings = function()
        widget:set_markup(markup("#7AC82E", " " .. net_now.received)
                          .. " " ..
                          markup("#46A8C3", " " .. net_now.sent .. " "))
    end
}), "#000000")


-- Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "xkb-switch -s"
kbdcfg.layout = { { "us", "" }, { "ru", "" } }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][1] .. " ")
kbdcfg.switch = function (x)
    if x == 'us' then
        kbdcfg.current = 1
    else
        kbdcfg.current = 2
    end
  local t = kbdcfg.layout[kbdcfg.current]
  kbdcfg.widget:set_text(" " .. t[1] .. " ")
  os.execute( kbdcfg.cmd .. " " .. t[1] .. " " )
end
kbdcfgwidgetbg = wibox.widget.background(kbdcfg.widget, "#313131")

 -- Mouse bindings
kbdcfg.widget:buttons(
 awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)

-- Separators
first = wibox.widget.textbox('<span font="Tamsyn 4"> </span>')
arrl_pre = wibox.widget.imagebox()
arrl_pre:set_image(beautiful.arrl_lr_pre)
arrl_post = wibox.widget.imagebox()
arrl_post:set_image(beautiful.arrl_lr_post)
spr = wibox.widget.textbox(' ')
arrl = wibox.widget.imagebox()
arrl:set_image(beautiful.arrl)
arrl_dl = wibox.widget.imagebox()
arrl_dl:set_image(beautiful.arrl_dl)
arrl_ld = wibox.widget.imagebox()
arrl_ld:set_image(beautiful.arrl_ld)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 18 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(first)
    left_layout:add(mytaglist[s])
    left_layout:add(arrl_pre)
    left_layout:add(mylayoutbox[s])
    left_layout:add(arrl_post)
    left_layout:add(mypromptbox[s])
    left_layout:add(first)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end

    right_layout:add(mailicon)
	right_layout:add(mail_widget)
    right_layout:add(spr)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(arrl_ld)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(arrl_dl)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(arrl_ld)
    right_layout:add(fsicon)
    right_layout:add(fswidgetbg)
    right_layout:add(arrl_dl)
    right_layout:add(neticon)
    right_layout:add(netwidget)
    right_layout:add(arrl_ld)
    right_layout:add(kbdcfgwidgetbg)
    right_layout:add(arrl_dl)
    right_layout:add(mytextclock)
    right_layout:add(spr)
    right_layout:add(arrl_ld)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

    -- Set proper background, instead of beautiful.bg_normal
    mywibox[s]:set_bg(beautiful.topbar_path .. screen[mouse.screen].workarea.width .. ".png")
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
    awful.key({ altkey }, "p", function() os.execute("screenshot") end),

    --Lock screen
    -- awful.key({ modkey, "Control" }, "l", function () kbdcfg.switch('us') ; awful.util.spawn("xscreensaver-command --lock") end),
    awful.key({ altkey, "Control" }, "l", function () kbdcfg.switch('us') ; awful.util.spawn("gnome-screensaver-command -l") end),
     
    -- Tag browsing
    awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey }, "Escape", awful.tag.history.restore),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

    -- Default client focus
    awful.key({ altkey }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    -- Show Menu
    awful.key({ modkey }, "w",
        function ()
            mymainmenu:show({ keygrabber = true })
        end),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),


    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey,           }, "Tab", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ altkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),
    awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    awful.key({ modkey, "Control" }, "n",      awful.client.restore),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

    -- Dropdown terminal
    awful.key({ modkey,	          }, "z",      function () drop(terminal) end),

    -- Widgets popups
    awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),

    -- ALSA volume control
    awful.key({  }, "XF86AudioRaiseVolume",
        function ()
            awful.util.spawn("amixer -q set Master 1%+")
            volumewidget.update()
        end),
    awful.key({  }, "XF86AudioLowerVolume",
        function ()
            awful.util.spawn("amixer -q set Master 1%-")
            volumewidget.update()
        end),
    awful.key({  }, "XF86AudioMute",
        function ()
            awful.util.spawn("amixer -q set Master playback toggle")
            volumewidget.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            awful.util.spawn("amixer -q set Master playback 100%")
            volumewidget.update()
        end),

    -- Taking screenshots
    awful.key({ }, "#107", function () awful.util.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'") end), 

    -- User programs
    awful.key({ modkey }, "q", function () awful.util.spawn(browser) end),

    -- Prompt
    -- awful.key({ modkey }, "d", function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey }, "d", function () awful.util.spawn("rofi -show drun") end),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

   -- Switche the current keyboard layout
    awful.key({ altkey }, "#26", function () kbdcfg.switch('us') end),
    awful.key({ altkey }, "#27", function () kbdcfg.switch('ru') end)
)


clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
	                   size_hints_honor = false } },
    { rule = { class = "urxvt" },
          properties = { opacity = 0.59 } },
}
-- }}}

-- {{{ Signals
-- signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup and not c.size_hints.user_position
       and not c.size_hints.program_position then
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- the title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c,{size=16}):set_widget(layout)
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_color = beautiful.border_normal
        else
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                if awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width

                -- No borders with only one visible client
                elseif #clients == 1 or layout == "max" then
                    clients[1].border_width = 0
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
-- }}}


