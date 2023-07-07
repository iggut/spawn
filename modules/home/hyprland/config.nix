{
  osConfig,
  config,
  ...
}: {
  # extraConfig =
  #      (import ./moniters.nix {
  #        inherit lib;
  #        inherit (config) monitors;
  #      }) +
  wayland.windowManager.hyprland.extraConfig =
    builtins.readFile ../../../hosts/${osConfig.networking.hostName}/hyprland.txt
    + ''
      # startup programs alongside hyprland

      exec-once = hyprpaper
      exec-once = mako
      exec-once = eww daemon && eww open bar &
      #exec-once = sfwbar &

      ########################################################
        ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ ███████╗
      ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ ██╔════╝
      ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗███████╗
      ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║╚════██║
      ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝███████║
        ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝
      ########################################################

      input {
        kb_layout = us
        kb_options = caps:escape_shifted_capslock
        accel_profile = flat
        follow_mouse = 1
        touchpad {
          natural_scroll = true
          clickfinger_behavior = true
          tap-to-click = true
        }
      }

      general {
        gaps_in=15
        gaps_out=20
        border_size=1.7
        col.active_border = rgb(89b4fa) rgb(cba6f7) 270deg
        col.inactive_border = 0x66000000

        col.group_border = rgb(313244)
        col.group_border_active = rgb(f5c2e7)
      }

      misc {
        mouse_move_enables_dpms = true
        key_press_enables_dpms = true
        enable_swallow = true
        swallow_regex=(kitty|Nautilus)
        vfr=on
      }

      decoration {
        active_opacity=0.96
        inactive_opacity=0.85
        fullscreen_opacity=1.0
        rounding = 10
        multisample_edges = true
        blur_new_optimizations = true
        blur = true
        blur_size = 3
        blur_passes = 3

        drop_shadow = true
        shadow_ignore_window = true
        shadow_offset = 0 5
        shadow_range = 50
        shadow_render_power = 3
        col.shadow = rgba(00000099)
      }

      animations {
        enabled=true

        bezier=easein,0.11, 0, 0.5, 0
        bezier=easeout,0.5, 1, 0.89, 1
        bezier=easeinout,0.45, 0, 0.55, 1

        animation=windowsIn,1,3,easeout,slide
        animation=windowsOut,1,3,easein,slide
        animation=windowsMove,1,3,easeout

        animation=fadeIn,1,3,easeout
        animation=fadeOut,1,3,easein
        animation=fadeSwitch,1,3,easeout
        animation=fadeShadow,1,3,easeout
        animation=fadeDim,1,3,easeout
        animation=border,1,3,easeout

        animation=workspaces,1,2,easeout,slide
      }

      dwindle {
        pseudotile = false
        preserve_split = true
        no_gaps_when_only = false
      }

      gestures {
        workspace_swipe = yes
        workspace_swipe_forever = true
      }

      ########################################################################################################
      ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗███████╗    ██████╗ ██╗   ██╗██╗     ███████╗███████╗
      ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║██╔════╝    ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
      ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║███████╗    ██████╔╝██║   ██║██║     █████╗  ███████╗
      ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║╚════██║    ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║
      ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝███████║    ██║  ██║╚██████╔╝███████╗███████╗███████║
        ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝
      ########################################################################################################

      # only allow shadows for floating windows
      windowrulev2 = noshadow, floating:0

      # make Firefox PiP window floating and sticky
      windowrulev2 = float, title:^(Picture-in-Picture)$
      windowrulev2 = pin, title:^(Picture-in-Picture)$

      # throw sharing indicators away
      windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
      windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$

      # start Discord/WebCord in ws2
      windowrulev2 = workspace 2, title:^(.*(Disc|WebC)ord.*)$

      # idle inhibit while watching videos
      windowrulev2 = idleinhibit focus, class:^(mpv|.+exe)$
      windowrulev2 = idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$
      windowrulev2 = idleinhibit fullscreen, class:^(firefox)$
      windowrulev2 = idleinhibit focus, class:(jellyfin)
      windowrulev2 = idleinhibit fullscreen, class:(jellyfin)

      windowrulev2 = dimaround, class:^(gcr-prompter)$

      # fix xwayland apps
      windowrulev2 = rounding 0, xwayland:1, floating:1
      windowrulev2 = center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$
      windowrulev2 = size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$

      layerrule = blur, ^(gtk-layer-shell|anyrun)$
      layerrule = ignorezero, ^(gtk-layer-shell|anyrun)$

      ########################################################################################
      ██╗  ██╗███████╗██╗   ██╗    ██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
      ██║ ██╔╝██╔════╝╚██╗ ██╔╝    ██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
      █████╔╝ █████╗   ╚████╔╝     ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗███████╗
      ██╔═██╗ ██╔══╝    ╚██╔╝      ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║╚════██║
      ██║  ██╗███████╗   ██║       ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝███████║
      ╚═╝  ╚═╝╚══════╝   ╚═╝       ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
      ########################################################################################

      $files = thunar
      $browser = firefox
      $term = kitty
      $editor = code
      # Set mod key to Super
      $mainMod = SUPER

      #Desktop usage
      bind = $mainMod, R, exec, rofi -show drun
      bind = $mainMod, V, exec, clipman pick -t rofi
      bind = , Print, exec, grim - | wl-copy
      bind = SHIFT, insert, exec, grim - | swappy -f -
      bind = $mainMod, insert, exec, grim -g "$(slurp)" - | wl-copy
      bind = $mainMod SHIFT, insert, exec, grim -g "$(slurp)" - | swappy -f -
      bind = $mainMod, L, exec, wlogout
      bind = $mainMod, N, exec, swaync-client -t -sw
      bind = $mainMod SHIFT, N, exec, swaync-client -d -sw

      bindr = SUPER, SUPER_L, exec, nwg-drawer

      bind = $mainMod, D, exec, thunar
      bind = $mainMod SHIFT, Q, killactive,
      bind = $mainMod SHIFT, Return, exec, $files
      bind = $mainMod SHIFT, Space, togglefloating,
      bind = $mainMod, E, exec, code
      bind = $mainMod, F, fullscreen
      bind = $mainMod, Q, killactive,
      bind = $mainMod, Return, exec, $term
      bind = $mainMod, T, exec, $term
      bind = $mainMod, V, exec, pavucontrol
      bind = $mainMod, Space, togglefloating,

      # Change Workspace Mode
      bind = SUPER_ALT, Space, workspaceopt, allfloat
      bind = $mainMod, P, pseudo, # dwindle


      # Mainmod + Function keys
      bind = $mainMod, F1, exec, $browser
      bind = $mainMod, F2, exec, $editor
      bind = $mainMod, F3, exec, inkscape
      bind = $mainMod, F4, exec, gimp
      bind = $mainMod, F5, exec, meld
      bind = $mainMod, F6, exec, vlc
      bind = $mainMod, F7, exec, virtualbox
      bind = $mainMod, F8, exec, $files
      bind = $mainMod, F9, exec, evolution
      bind = $mainMod, F10, exec, spotify
      bind = $mainMod, F11, exec, rofi -show drun
      bind = $mainMod, F12, exec, rofi -show drun

      # Special Keys
      bind = , xf86audioraisevolume, exec, $volume --uo
      bind = , xf86audiolowervolume, exec, $volume --down
      bind = , xf86audiomute, exec, $volume --toggle
      bind = , xf86audioplay, exec, playerctl play-pause
      bind = , xf86audionext, exec, playerctl next
      bind = , xf86audioprev, exec, playerctl previous
      bind = , xf86audiostop, exec, playerctl stop
      bind = , xf86monbrightnessup, exec, $brightness --inc
      bind = , xf86monbrightnessdown, exec, $brightness --dec

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window and follow to workspace
      bind = $mainMod CTRL, 1, movetoworkspace, 1
      bind = $mainMod CTRL, 2, movetoworkspace, 2
      bind = $mainMod CTRL, 3, movetoworkspace, 3
      bind = $mainMod CTRL, 4, movetoworkspace, 4
      bind = $mainMod CTRL, 5, movetoworkspace, 5
      bind = $mainMod CTRL, 6, movetoworkspace, 6
      bind = $mainMod CTRL, 7, movetoworkspace, 7
      bind = $mainMod CTRL, 8, movetoworkspace, 8
      bind = $mainMod CTRL, 9, movetoworkspace, 9
      bind = $mainMod CTRL, 0, movetoworkspace, 10
      bind = $mainMod CTRL, bracketleft, movetoworkspace, -1
      bind = $mainMod CTRL, bracketright, movetoworkspace, +1

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      bind = $mainMod SHIFT, bracketleft, movetoworkspacesilent, -1
      bind = $mainMod SHIFT, bracketright, movetoworkspacesilent, +1

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      bind = $mainMod, period, workspace, e+1
      bind = $mainMod, comma, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = , mouse:276, movewindow
      bindm = , mouse:275, resizewindow
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Group windows
      bind = $mainMod, G, togglegroup
      bind = $mainMod, tab, changegroupactive, f

      # Switch windows

      bind = ALT, Tab, exec, killall -SIGUSR1 .sfwbar-wrapped

      # window resize
      binde = $mainMod ALT, L, resizeactive, 80 0
      binde = $mainMod ALT, H, resizeactive, -80 0
      bind = $mainMod, S, submap, resize

      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      binde = , l, resizeactive, 10 0
      binde = , h, resizeactive, -10 0
      binde = , k, resizeactive, 0 -10
      binde = , j, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset

      # screenshot
      # stop animations while screenshotting; makes black border go away
      $screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"

      bind = , Print, exec, $screenshotarea
      bind = $mainMod SHIFT, R, exec, $screenshotarea

      blurls=waybar
      blurls=gtk-layer-shell

    '';
}
