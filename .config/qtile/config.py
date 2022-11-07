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

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "kitty"
browser = "firefox"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "f", lazy.spawn(browser), desc="Launch the Internet browser"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

def init_group_names():
    return [
        ("WEB", {'layout': 'max'}),
        ("DEV", {'layout': 'max'}),
        ("WRT", {'layout': 'max'}),
        ("SYS", {'layout': 'max'}),
        ("EML", {'layout': 'max'})]

def init_groups():
    return [Group(name, **kwargs) for name, kwargs in group_names]

if __name__ in ["config", "__main__"]:
    group_names = init_group_names()
    groups = init_groups()

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

#for i in range(0, len(groups)):
#    keys.extend(
#        [
#            # mod1 + letter of group = switch to group
#            Key(
#                [mod],
#                (i + 1),
#                lazy.group[groups[i].name].toscreen(),
#                desc="Switch to group {}".format(groups[i].name),
#            ),
#            # mod1 + shift + letter of group = switch to & move focused window to group
#            Key(
#                [mod, "shift"],
#                i.name,
#                lazy.window.togroup(i.name, switch_group=True),
#                desc="Switch to & move focused window to group {}".format(i.name),
#            ),
#            # Or, use below if you prefer not to switch to that group.
#            # # mod1 + shift + letter of group = move focused window to group
#            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
#            #     desc="move focused window to group {}".format(i.name)),
#        ]
#    )

layouts = [
    layout.Columns(
        border_focus = "D65D0E",
        border_normal = "0D1011",
        border_width=2,
        margin = 2,
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(
        align = layout.MonadTall._left,
        border_focus = "D65D0E",
        border_normal = "0D1011",
        border_width=2,
        margin = 2,
        ratio = 0.6,
    ),
    layout.MonadWide(
        border_focus = "D65D0E",
        border_normal = "0D1011",
        border_width=2,
        margin = 2,
    ),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="hermit",
    fontsize=14,
    padding=3,
    foreground = "EBDBB2",
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    background = "458588",
                    foreground = "1D2021",
                ),
                widget.CurrentLayout(
                    background = "458588",
                    foreground = "1D2021",
                ),
                widget.Sep(
                    foreground = "D65D0E",
                    linewidth = 2,
                    size_percent = 70,
                ),
                widget.GroupBox(
                    active = "458588",
                    inactive = "928374",
                    highlight_color = ["31302F"],
                    highlight_method = "line",
                    this_screen_border = "D65D0E",
                    this_current_screen_border = "D65D0E",
                    urgent_alert_method = "block",
                    urgent_border = "CC241D",
                    urgent_text = "EBDBB2",
                ),
                widget.Sep(
                    foreground = "D65D0E",
                    linewidth = 2,
                    size_percent = 70,
                ),
                widget.WindowName(),
                widget.Sep(
                    background = "1D2021",
                    foreground = "D65D0E",
                    linewidth = 2,
                    #padding = 0,
                    size_percent = 70,
                ),
                widget.Prompt(),
                widget.Sep(
                    background = "B16286",
                    foreground = "1D2021",
                    linewidth = 4,
                    padding = 0,
                    size_percent = 70,
                ),
                widget.Net(
                    background = "B16286",
                    foreground = "1D2021",
                    format = "{up} \u2191/\u2193 {down} | \u21C5 {total}",
                    interface = "wlp1s0",
                ),
                widget.Sep(
                    background = "D79921",
                    foreground = "1D2021",
                    linewidth = 4,
                    padding = 0,
                    size_percent = 70,
                ),
                widget.Battery(
                    background = "D79921",
                    charge_char = "+",
                    discharge_char = "-",
                    empty_char = "X",
                    foreground = "1D2021",
                    low_background = "CC241D",
                    low_foreground = "EBDBB2",
                    low_percentage = 0.2,
                    update_interval = 1,
                ),
                widget.Sep(
                    background = "689D6A",
                    foreground = "1D2021",
                    linewidth = 4,
                    padding = 0,
                    size_percent = 70,
                ),
               # # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
               # # widget.StatusNotifier(),
                widget.Clock(
                    background = "689D6A",
                    #font = "hermit bold",
                    foreground = "1D2021",
                    format="%Y-%m-%d %a %H:%M"
                ),
                widget.Sep(
                    background = "CC241D",
                    foreground = "1D2021",
                    linewidth = 4,
                    padding = 0,
                    size_percent = 70,
                ),
                widget.QuickExit(
                    background = "CC241D",
                ),
            ],
            35,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            background = "1D2021",

        ),
        wallpaper = "/home/nate/Pictures/wallpapers/gray_image3",
        wallpaper_mode = "fill",
    ),
]

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

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"