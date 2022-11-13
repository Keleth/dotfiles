# -*- coding: utf-8 -*-
# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from typing import List
#from libqtile.utils import guess_terminal

mod = "mod4"
mod1 = "mod1"
mod2 = "control"
mod3 = "shift"
terminal = "sakura"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.shrink(), lazy.layout.decrease_nmaster(), desc="Shrink window (MonadTall), decrease number in master pane (Tile)"),
    Key([mod], "l", lazy.layout.grow(), lazy.layout.increase_nmaster(), desc="Expand window (MonadTall), increase number in master pane (Tile)"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "n", lazy.layout.normalize(), desc='normalize window size ratios'),
    Key([mod], "m", lazy.layout.maximize(), desc='toggle window between minimum and maximum sizes'),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc='toggle floating'),

# Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), lazy.layout.section_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), lazy.layout.section_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    #Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"], "Return", lazy.spawn("pcmanfm"), desc="launch file manager",
#        lazy.layout.toggle_split(),
#        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    #Keys for close|quit Qtile
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    # dmenu
    Key([mod], "d", lazy.spawn("dmenu_run -i -nb '#282c34' -nf '#bbc2cf' -sb '#3e4451' -sf '#98be65' -fn JetBrainsMono:bold:pixelsize=14"), desc="Launch dmenu"),
    #Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    #Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Audio controls
    Key([], "XF86AudioMute", lazy.spawn("amixer -D pulse sset Master toggle"), desc="Mute volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -D pulse sset Master 5%-"), desc="Lower volume"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -D pulse sset Master 5%+"), desc="Increase volume"),
    Key([], "XF86AudioPlay", lazy.spawn("mocp -G"), desc="Play|Pause toggle"),
    Key([], "XF86AudioNext", lazy.spawn("mocp -f"), desc="Next song"),
    Key([], "XF86AudioPrev", lazy.spawn("mocp -r"), desc="Prev song"),
 #    Key([], "ISO_Next_Group", lazy.widget["keyboardlayout"].next_keyboard(), desc="Change keyboard layout"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "e1acff",
                "border_normal": "1D2330"
                }

layouts = [
    layout.MonadTall(**layout_theme),
#    layout.MonadWide(margin=15, border_width=4, border_focus="#bc7cf7", border_normal="#4c566a"),
#    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="JetBrainsMono",
    fontsize=16,
    padding=3,
    background=colors[2]
)

colors = [["#282c34", "#282c34"],
          ["#1c1f24", "#1c1f24"],
          ["#dfdfdf", "#dfdfdf"],
          ["#ff6c6b", "#ff6c6b"],
          ["#98be65", "#98be65"],
          ["#da8548", "#da8548"],
          ["#51afef", "#51afef"],
          ["#c678dd", "#c678dd"],
          ["#46d9ff", "#46d9ff"],
          ["#a9a1e1", "#a9a1e1"]]

extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.Image(
                       filename = "~/.config/qtile/icons/python-white.png",
                       scale = "False",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal)}
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.GroupBox(
                       font = "Ubuntu Bold",
                       fontsize = 9,
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 5,
                       padding_x = 3,
                       borderwidth = 3,
                       active = colors[2],
                       inactive = colors[7],
                       rounded = False,
                       highlight_color = colors[1],
                       highlight_method = "line",
                       this_current_screen_border = colors[6],
                       this_screen_border = colors [4],
                       other_current_screen_border = colors[6],
                       other_screen_border = colors[4],
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.TextBox(
                       text = '|',
                       font = "Ubuntu Mono",
                       background = colors[0],
                       foreground = '474747',
                       padding = 2,
                       fontsize = 14
                       ),
              widget.CurrentLayoutIcon(
                       custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                       foreground = colors[2],
                       background = colors[0],
                       padding = 0,
                       scale = 0.7
                       ),
#              widget.CurrentLayout(
#                       foreground = colors[2],
#                       background = colors[0],
#                       padding = 5
#                       ),
             widget.TextBox(
                       text = '|',
                       font = "Ubuntu Mono",
                       background = colors[0],
                       foreground = '474747',
                       padding = 2,
                       fontsize = 14
                       ),
              widget.WindowName(
                       foreground = colors[6],
                       background = colors[0],
                       padding = 0
                       ),
              widget.Systray(
                       background = colors[0],
                       padding = 5
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[0],
                       background = colors[0]
                       ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[0],
                       foreground = colors[4],
                       padding = 0,
                       fontsize = 37
                       ),
#             widget.Net(
#                       interface = "enp5s0",
#                       format = 'Net: {down} ↓↑ {up}',
#                       foreground = colors[1],
#                       background = colors[3],
#                       padding = 5
#                       ),
#              widget.TextBox(
#                       text = '',
#                       font = "Ubuntu Mono",
#                       background = colors[3],
#                       foreground = colors[4],
#                       padding = 0,
#                       fontsize = 37
#                       ),
              widget.ThermalSensor(
                       foreground = colors[1],
                       background = colors[4],
                       threshold = 90,
                       fmt = 'Temp: {}',
                       padding = 5
                       ),
              widget.TextBox(
                       text='',
                       font = "Ubuntu Mono",
                       background = colors[4],
                       foreground = colors[5],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.CheckUpdates(
                       update_interval = 1800,
                       distro = "Debian",
                       display_format = "Updates: {updates} ",
                       foreground = colors[1],
                       colour_have_updates = colors[1],
                       colour_no_updates = colors[1],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e sudo apt upgrade')},
                       padding = 5,
                       background = colors[5]
                       ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[5],
                       foreground = colors[6],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.Memory(
                       foreground = colors[1],
                       background = colors[6],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e htop')},
                       fmt = 'Mem: {}',
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[6],
                       foreground = colors[7],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.Volume(
                       foreground = colors[1],
                       background = colors[7],
                       fmt = 'Vol: {}',
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[7],
                       foreground = colors[8],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.GenPollText(
                       update_interval=1,
                       func=lambda: subprocess.check_output("/home/danila/develop/bash/current-layout.sh").decode("utf-8").strip(),
                       foreground = colors[1],
                       background = colors[8],
                       padding=5
                  ),
              widget.TextBox(
                       text = '',
                       font = "Ubuntu Mono",
                       background = colors[8],
                       foreground = colors[9],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.Clock(
                       foreground = colors[1],
                       background = colors[9],
                       format = "%d.%m.%Y %H:%M "
                       ),
              ]
    return widgets_list

screens = [
    Screen(
        top=bar.Bar(widgets=init_widgets_list(),
#            [
#                widget.CurrentLayout(),
#                widget.GroupBox(),
#                widget.Prompt(),
#                widget.WindowName(),
#                widget.Chord(
#                    chords_colors={
#                        "launch": ("#ff0000", "#ffffff"),
#                    },
#                    name_transform=lambda name: name.upper(),
#                ),
#                widget.TextBox("my raw config", name="default"),
#                #widget.TextBox("Press &lt;M-d&gt; to spawn", foreground="#d75f5f"),
#                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
#                # widget.StatusNotifier(),
#                widget.Systray(),
#                widget.Clock(format="%Y-%m-%d %a %H:%M %p"),
# #               widget.KeyboardLayout(configured_keyboards=['us', 'ru']),
#            ],
            size=24,
            opacity=1.0
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

#def init_screens():
#    return [Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=1.0, size=24))
            #Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20)),
            #Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20))
#            ]


#if __name__ in ["config", "__main__"]:
#    screens = init_screens()
#    widgets_list = init_widgets_list()
#    widgets_screen1 = init_widgets_screen1()
#    widgets_screen2 = init_widgets_screen2()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="Telegram"),  # telegram
        Match(wm_class="Firefox-esr", title="Картинка в картинке"),  # picture in picture window
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
