
import subprocess
import re
import platform

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

mod = "mod4"
alt = "mod1"

TERM = "urxvt"

DISTRO = platform.linux_distribution()[0].lower()


class DistroDependableCmd(object):
    def __init__(self, distro_dict):
        self.distro_dict

    def call(self, *args, **kwargs):
        return self.distro_dict[DISTRO].format(*args, **kwargs)

def language_switch(lang):
    if DISTRO == 'ubuntu':
        cmd = "setxkbmap {}"
    else:
        raise RuntimeError
    return cmd.format(lang)


def screen_lock():
    if DISTRO == 'ubuntu':
        cmd = "gnome-screensaver-command -l"
    else:
        raise RuntimeError
    return cmd

keys = [
    # Switch between windows in current stack pane
    Key([mod], "h",
        lazy.layout.previous(),  # Stack
        lazy.layout.left()),     # xmonad-tall
    Key([mod], "l",
        lazy.layout.next(),      # Stack
        lazy.layout.right()),    # xmonad-tall
    Key(
        [mod], "k",
        lazy.layout.down()
    ),
    Key(
        [mod], "j",
        lazy.layout.up()
    ),

    # Move windows up or down in current stack
    Key(
        [mod, "shift"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [mod, "shift"], "j",
        lazy.layout.shuffle_up()
    ),
    # These are unique to stack layout
    Key([mod, "shift"], "l",
        lazy.layout.client_to_next(),      # Stack
        lazy.layout.swap_right()),         # xmonad-tall
    Key([mod, "shift"], "h",
        lazy.layout.client_to_previous(),  # Stack
        lazy.layout.swap_left()),          # xmonad-tall

    # Switch window focus to other pane(s) of stack
    Key(
        [mod], "Tab",
        lazy.layout.next()
    ),

    # Swap panes of split stack
    Key(
        [mod, "shift"], "space",
        lazy.layout.rotate()
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"], "Return",
        lazy.layout.toggle_split()
    ),
    Key([mod], "Return", lazy.spawn(TERM)),

    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod], "f", lazy.window.toggle_maximize()),

    Key([mod, "control"], "n",
        lazy.layout.normalize()),         # xmonad-tall
    Key([mod, "control"], "l",
        lazy.layout.delete(),             # Stack
        lazy.layout.increase_ratio(),     # Tile
        lazy.layout.grow()),              # xmonad-tall
    Key([mod, "control"], "h",
        lazy.layout.add(),                # Stack
        lazy.layout.decrease_ratio(),     # Tile
        lazy.layout.shrink()),            # xmonad-tall
    Key([mod, "control"], "k",
        lazy.layout.grow(),               # xmonad-tall
        lazy.layout.decrease_nmaster()),  # Tile
    Key([mod, "control"], "j",
        lazy.layout.shrink(),             # xmonad-tall
        lazy.layout.increase_nmaster()),  # Tile

    Key([mod], "t", lazy.window.toggle_floating()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),

    Key([mod], "d", lazy.spawncmd()),
    Key([mod], "g", lazy.switchgroup()),

    # custom keybindings
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB+")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB-")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("amixer -c 0 -q set Master toggle")
    ),

    Key([alt], "Cyrillic_ghe", lazy.spawn(language_switch('us'))),
    Key([alt], "r", lazy.spawn(language_switch('ru'))),

    Key([alt, "control"], "l", lazy.spawn(screen_lock())),
]

groups = [Group(str(i)) for i in range(1, 6)]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

border = dict(
    border_normal='#808080',
    border_width=2,
)

layouts = [
    layout.MonadTall(**border),
    layout.Stack(num_stacks=2, **border),
]

widget_defaults = dict(
    font='Firamono',
    fontsize=16,
    padding=3,
)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.CurrentLayout(),
                widget.Sep(),
                widget.WindowName(),
                widget.Notify(),
                widget.Systray(),
                widget.KeyboardLayout(),
                widget.Sep(),
                widget.Volume(foreground="70ff70"),
                widget.Clock(format='%Y-%m-%d %a %H:%M %p'),
            ],
            30,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.disable_floating())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True


@hook.subscribe.client_new
def dialogs(window):
    if(window.window.get_wm_type() == 'dialog'
       or window.window.get_wm_transient_for()):
        window.floating = True


def is_running(process):
    s = subprocess.Popen(["ps", "axuw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x):
            return True
    return False


def execute_once(process):
    if not is_running(process):
        return subprocess.Popen(process.split())


# start the applications at Qtile startup
@hook.subscribe.startup
def startup():
    subprocess.Popen("sleep 3".split())
    execute_once("urxvtd")
    execute_once("unclutter")
    execute_once("xscreensaver -no-splash")
    execute_once("xfce4-clipman &")
    execute_once("compton &")
    execute_once("devilspie &")
    subprocess.Popen("setxkbmap us,ru".split())


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
