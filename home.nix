{ pkgs, ... }:
let
  vscode = pkgs.vscode;
  pulseaudio = pkgs.pulseaudioFull;
in {
  config = {
    home.packages = with pkgs; [
      coin
      hello
      nixfmt
      bitwarden
      insomnia
      spotify
      pavucontrol
      fortune
      cowsay
      gdb
      mplayer
      imagemagick
      nodejs
      entr
      socat
      file
      proot
      qemu
      awscli
      darkhttpd
      xclip
      jq
      nmap
      graphviz
      xfce.thunar
      volumeicon
      keepassxc
      jdk
      libreoffice
      speedcrunch
      ffmpegthumbnailer
      networkmanagerapplet
      gksu
      rxvt_unicode-with-plugins
      xsel
      lxappearance
      gitAndTools.hub
      gitAndTools.gh
      travis
      git-cola
      gnome3.file-roller
      clang
      slack
      zoom-us
      watchman
      dmenu
      i3status
      chromium
      mono
      inconsolata
      liberation_ttf
      terminus_font
      ttf_bitstream_vera
      powerline-fonts
      gnupg
      vlc
      webtorrent_desktop
      patchelf
      docker_compose
      httpie
      gimp
      feh
      screen
      nix-review
      vscode
      leafpad
      dejavu_fonts
      mypaint
      tiled
      maven
      terminator
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/sound" = {
          event-sounds = false;
          input-feedback-sounds = false;
        };
      };
    };

    programs.termite = {
      enable = false;
      font = "\n    ";
      colorsExtra = ''
        # Base16 Solarized Dark
        # Author: Ethan Schoonover (modified by aramisgithub)

        foreground          = #93a1a1
        foreground_bold     = #eee8d5
        cursor              = #eee8d5
        cursor_foreground   = #002b36
        background          = #002B36

        # 16 color space

        # Black, Gray, Silver, White
        color0  = #002b36
        color8  = #657b83
        color7  = #93a1a1
        color15 = #fdf6e3

        # Red
        color1  = #dc322f
        color9  = #dc322f

        # Green
        color2  = #859900
        color10 = #859900

        # Yellow
        color3  = #b58900
        color11 = #b58900

        # Blue
        color4  = #268bd2
        color12 = #268bd2

        # Purple
        color5  = #6c71c4
        color13 = #6c71c4

        # Teal
        color6  = #2aa198
        color14 = #2aa198

        # Extra colors
        color16 = #cb4b16
        color17 = #d33682
        color18 = #073642
        color19 = #586e75
        color20 = #839496
        color21 = #eee8d5
      '';
    };
    home.file.".i3status.conf".text = ''
      general {
              colors = true
              interval = 5
      }

      #order += "ipv6"
      order += "disk /"
      #order += "run_watch DHCP"
      #order += "run_watch VPN"
      order += "wireless wlp3s0"
      order += "ethernet enp0s25"
      order += "battery 0"
      #order += "load"
      order += "tztime local"

      wireless wlan0 {
              format_up = "W: (%quality at %essid) %ip"
              format_down = "W: down"
      }

      battery 0 {
              format = "%status %percentage %remaining"
      }

      tztime local {
              format = "%Y-%m-%d %H:%M:%S"
      }
    '';
    programs.kitty = {
      enable = true;
      settings = {
        background = "#002B36";
        font_size = "11.0";
        input_delay = "0";
        enable_audio_bell = "no";
      };
    };

    home.file.".config/terminator/config".text = ''
      [global_config]
        inactive_color_offset = 1.0
      [keybindings]
        go_next = ""
        new_window = <Primary><Shift>n
      [profiles]
        [[default]]
          background_color = "#002b36"
          cursor_color = "#aaaaaa"
          font = DejaVu Sans Mono for Powerline 11
          foreground_color = "#839496"
          show_titlebar = False
          scrollback_lines = 5000
          palette = "#073642:#dc322f:#859900:#b58900:#268bd2:#d33682:#2aa198:#eee8d5:#002b36:#cb4b16:#586e75:#657b83:#839496:#6c71c4:#93a1a1:#fdf6e3"
    '';

    xresources.properties = { "Xft.dpi" = 192; };
    fonts.fontconfig.enable = true;
    gtk = {
      enable = true;
      font = {
        name = "Noto Sans 10";
        package = pkgs.noto-fonts;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome3.adwaita-icon-theme;
      };
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome3.gnome_themes_standard;
      };
      gtk2.extraConfig = ''
        gtk-error-bell = 0
      '';

      gtk3.extraConfig = { gtk-error-bell = 0; };
    };
    programs.ssh = {
      enable = true;

      matchBlocks = {
        "beheer1.ioservice.net beheer1.stpst.nl beheer2.ioservice.net beheer2.stpst.nl" =
          {
            user = "bob.vanderlinden";
            forwardAgent = false;
            identityFile = "~/.ssh/nedap_rsa";
          };

        "nl12* nl14* nl22* nl24* vm* nvs* nas* *.healthcare.nedap.local *.consul" =
          {
            user = "bob.vanderlinden";
            forwardAgent = false;
            identityFile = "~/.ssh/nedap_rsa";
            extraOptions."VerifyHostKeyDNS" = "no";
            extraOptions."ProxyJump" = "beheer1.ioservice.net";
          };

        "127.0.0.1" = {
          user = "bob.vanderlinden";
          forwardAgent = false;
          identityFile = "~/.ssh/nedap_rsa";
          extraOptions."VerifyHostKeyDNS" = "no";
        };

        # "github.com" = {
        #   user = "git";
        #   identityFile = "~/.ssh/github_ed25519";
        # };
      };

      forwardAgent = false;
      serverAliveInterval = 180;

      # extraConfig = ''
      #   SendEnv LANG LC_*
      #   IdentitiesOnly yes
      #   Port 22
      #   Protocol 2
      #   UseRoaming no
      #   PubkeyAuthentication yes
      #   PasswordAuthentication no
      #   ChallengeResponseAuthentication no
      #   ForwardX11 no
      #   ForwardX11Trusted no
      #   HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa
      #   Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
      #   MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
      #   KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
      #   VerifyHostKeyDNS yes
      # '';
    };
    programs.fzf.enable = true;
    programs.vim.enable = true;
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      history.extended = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "archlinux"
          "git-extras"
          "git"
          "gitfast"
          "github"
          "ssh-agent"
          "gpg-agent"
        ];
        #theme = "frozencow";
        theme = "agnoster";
      };
      loginExtra = ''
        setopt extendedglob
        xset b off
        xset b 0 0 0
        source $HOME/.aliases
        bindkey '^R' history-incremental-pattern-search-backward
        bindkey '^F' history-incremental-pattern-search-forward
        eval "$(rbenv init -)"
      '';
    };
    qt = {
      enable = true;
      platformTheme = "gnome";
    };

    services.gnome-keyring.enable = true;
    services.gpg-agent.enable = true;
    services.keybase.enable = true;
    services.network-manager-applet.enable = true;
    services.blueman-applet.enable = true;
    services.flameshot.enable = true;
    services.redshift = {
      enable = true;
      latitude = "51.985104";
      longitude = "5.898730";
      temperature.day = 5500;
      temperature.night = 3700;
      tray = true;
    };

    systemd.user.services.lxqt-policykit-agent = {
      Unit = {
        Description = "LXQT PolicyKit Agent";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
      };
    };

    systemd.user.services.volumeicon = {
      Unit = {
        Description = "Volume Icon";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = { ExecStart = "${pkgs.volumeicon}/bin/volumeicon"; };
    };

    systemd.user.services.bitwarden = {
      Unit = {
        Description = "Bitwarden";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = { ExecStart = "${pkgs.bitwarden}/bin/bitwarden"; };
    };

    xdg.enable = true;
    # news.display = "silent";
    xsession = {
      enable = true;
      pointerCursor = {
        name = "Vanilla-DMZ";
        package = pkgs.vanilla-dmz;
        size = 128;
      };
      windowManager.i3 = rec {
        enable = true;
        config = {
          modifier = "Mod4";
          bars = [{ statusCommand = "${pkgs.i3status}/bin/i3status"; }];
          keybindings = let mod = config.modifier;
          in {
            "${mod}+t" = "exec terminator";
            "${mod}+w" = "exec chromium";
            "${mod}+e" = "exec thunar";
            "${mod}+q" = "exec dmenu_run";
            "${mod}+Print" = "exec flameshot gui";
            "${mod}+c" = "kill";

            "${mod}+Shift+grave" = "move scratchpad";
            "${mod}+grave" = "scratchpad show";
            "${mod}+j" = "focus left";
            "${mod}+k" = "focus down";
            "${mod}+l" = "focus up";
            "${mod}+semicolon" = "focus right";
            "${mod}+Left" = "focus left";
            "${mod}+Down" = "focus down";
            "${mod}+Up" = "focus up";
            "${mod}+Right" = "focus right";
            "${mod}+Shift+j" = "move left";
            "${mod}+Shift+k" = "move down";
            "${mod}+Shift+l" = "move up";
            "${mod}+Shift+semicolon" = "move right";
            "${mod}+Shift+Left" = "move left";
            "${mod}+Shift+Down" = "move down";
            "${mod}+Shift+Up" = "move up";
            "${mod}+Shift+Right" = "move right";
            "${mod}+h" = "split h";
            "${mod}+v" = "split v";
            "${mod}+f" = "fullscreen";
            "${mod}+Shift+s" = "layout stacking";
            "${mod}+Shift+t" = "layout tabbed";
            "${mod}+Shift+f" = "floating toggle";
            "${mod}+space" = "focus mode_toggle";
            "${mod}+1" = "workspace 1";
            "${mod}+2" = "workspace 2";
            "${mod}+3" = "workspace 3";
            "${mod}+4" = "workspace 4";
            "${mod}+5" = "workspace 5";
            "${mod}+6" = "workspace 6";
            "${mod}+7" = "workspace 7";
            "${mod}+8" = "workspace 8";
            "${mod}+9" = "workspace 9";
            "${mod}+0" = "workspace 10";
            "${mod}+Shift+1" = "move container to workspace 1";
            "${mod}+Shift+2" = "move container to workspace 2";
            "${mod}+Shift+3" = "move container to workspace 3";
            "${mod}+Shift+4" = "move container to workspace 4";
            "${mod}+Shift+5" = "move container to workspace 5";
            "${mod}+Shift+6" = "move container to workspace 6";
            "${mod}+Shift+7" = "move container to workspace 7";
            "${mod}+Shift+8" = "move container to workspace 8";
            "${mod}+Shift+9" = "move container to workspace 9";
            "${mod}+Shift+0" = "move container to workspace 10";
            "${mod}+Shift+r" = "restart";
            "${mod}+Shift+e" = ''
              exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"'';

            "XF86AudioRaiseVolume" =
              "exec ${pulseaudio}/bin/pactl set-sink-volume 0 +5%";
            "XF86AudioLowerVolume" =
              "exec ${pulseaudio}/bin/pactl set-sink-volume 0 -5%";
            "XF86AudioMute" =
              "exec ${pulseaudio}/bin/pactl set-sink-mute 0 toggle";

            "XF86MonBrightnessUp" =
              "exec ${pkgs.xorg.xbacklight}/bin/xbacklight -inc 5";
            "XF86MonBrightnessDown" =
              "exec ${pkgs.xorg.xbacklight}/bin/xbacklight -dec 5";

            "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
            "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
            "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
            "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          };

          startup = [{
            command = "${pkgs.dex}/bin/dex -a";
            notification = false;
          }];
        };
        extraConfig = ''
          default_orientation horizontal
          workspace_layout tabbed

          workspace "10" output DVI-I-0
          assign [class="Pidgin"] "10"
          assign [class="Spotify"] = "10"

          for_window [window_role="scratchpad"] move scratchpad
          for_window [class="scratchpad"] move scratchpad
          for_window [class="keepassxc"] move scratchpad
          for_window [class="Bitwarden"] move scratchpad
          for_window [title="notes - Zim"] move scratchpad
          for_window [class="floating"] floating enable
        '';
      };
    };

    programs.git = {
      enable = true;
      userName = "Bob van der Linden";
      userEmail = "bobvanderlinden@gmail.com";
      signing.signByDefault = true;
      signing.key = "EEBE8E3EC4A31364";
      aliases = {
        unstage = "reset HEAD --";
        pr = "pull --rebase";
        addp = "add --patch";
        comp = "commit --patch";
        co = "checkout";
        ci = "commit";
        c = "commit";
        b = "branch";
        p = "push";
        d = "diff";
        a = "add";
        s = "status";
        f = "fetch";
        br = "branch";
        pa = "add --patch";
        pc = "commit --patch";
        rf = "reflog";
        l =
          "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
        pp =
          "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
        recent-branches = "branch --sort=-committerdate";
      };
      ignores = [ ".direnv" "flake.nix" "flake.lock" ".envrc" ];
      extraConfig = {
        core.editor = "${vscode}/bin/code --wait";
        merge.conflictstyle = "diff3";
        push.default = "current";
        pull.rebase = false;
        init.defaultBranch = "master";
      };
    };
    home.sessionVariables = { BROWSER = "${pkgs.chromium}/bin/chromium"; };
    programs.autorandr.enable = true;
    programs.direnv.enable = true;
    programs.direnv.enableNixDirenvIntegration = true;
    programs.htop.enable = true;
    programs.home-manager.enable = true;
  };
}
