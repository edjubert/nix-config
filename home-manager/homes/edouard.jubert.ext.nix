{ config, pkgs, inputs, lib, ... }:

{
  home.username = "edouard.jubert.ext";
  home.homeDirectory = "/home/edouard.jubert.ext";
  home.stateVersion = "23.05"; # Please read the comment before changing.
  home.sessionPath = [
    "$HOME/.local/bin"
  ];


  targets.genericLinux.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "trayIconsReloaded@selfmade.pl"
        "backslide@codeisland.org"
        "blur-my-shell@aunetx" 
        "mousefollowsfocus@matthes.biz"
        "pop-shell@system76.com"
        "rounded-window-corners@yilozt"
        "simulate-switching-workspaces-on-active-monitor@micheledaros.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
      ];
    };

    "org/gnome/shell/extensions/pop-shell" = {
      "activate-launcher" = ["<Super>d"];
      "active-hint" = true;
      "active-hint-border-radius"=20;
      "fullscreen-launcher" = true;
      "gap-inner" = "uint32 5";
      "gap-outer" = "uint32 5";
      "hint-color-rgba" = "rgb(255,122,0)";
      "log-level" = "uint32 0";
      "mouse-cursor-focus-location" = "uint32 4";
      "mouse-cursor-follows-active-window" = true;
      "show-title" = false;
      "smart-gaps" = false;
      "snap-to-grid" = false;
      "stacking-with-mouse" = false;
      "tile-by-default" = true;
    };
  };

  gtk = {
    enable = true;
    # cursorTheme = {
    #   name = "breeze";
    #   package = pkgs.gnome-breeze;
    #   size = 16;
    # };

    cursorTheme = {
      name = "Catppuccin";
      package = pkgs.catppuccin-cursors.mochaPink;
      size = 16;
    };
  };

  home.packages = with pkgs; [
    # Dev
    nodejs
    deno
    go
    rustup
    sassc
    hyprpicker

    # IDE
    jetbrains.datagrip
    jetbrains.idea-ultimate

    # Theme
    source-code-pro
    nerdfonts

    # Apps
    _1password
    _1password-gui
    slack
    whatsapp-for-linux

    # iPhone
    ifuse
    libimobiledevice

    # Git
    gh
    git
    lazygit

    # Video
    ffmpeg
    (mpv.override {
      scripts = [mpvScripts.mpris];
    })

    # Browsers
    chromium
    firefox

    # Gnome
    gnomeExtensions.backslide
    gnomeExtensions.blur-my-shell
    gnomeExtensions.mouse-follows-focus
    gnomeExtensions.pop-shell
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.switch-workspaces-on-active-monitor
    gnomeExtensions.appindicator
    gnomeExtensions.tray-icons-reloaded
    gnome.nautilus

    # Tools
    brightnessctl
    cliphist
    gammastep
    grim
    pamixer
    pulsemixer
    rofi
    slurp
    swappy
    swaylock-effects
    swww
    wl-clipboard
    wf-recorder
    wayshot
    flameshot
    k9s
    wlogout

    # Terminal related
    foot
    bat
    direnv
    fzf
    htop
    jq
    killall
    ripgrep
    any-nix-shell
  ];

  # fonts = {
  #   fontconfig = {
  #     enable = true;
  #     defaultFonts = {
  #       serif = [ "Ubuntu" ];
  #       sansSerif = [ "Ubuntu" ];
  #       monospace = [ "Iosevka NF" ];
  #     };
  #   };
  # };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.fish.enable = true;

  programs.git = {
    enable = true;
    userName = "edjubert";
    userEmail = "edouard.jubert@gmail.com";
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };

  programs.schizofox = {
    enable = true;

    theme = {
      background-darker = "181825";
      background = "1e1e2e";
      foreground = "cdd6f4";
      font = "Lexend";
      simplefox.enable = true;
      darkreader.enable = true;
      extraCss = ''
        body {
          color: red !important;
        }
      '';
    };

    search = {
      defaultSearchEngine = "Google";
      removeEngines = ["Brave" "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
      searxUrl = "https://searx.be";
      searxQuery = "https://searx.be/search?q={searchTerms}&categories=general";
      addEngines = [
        {
          Name = "Etherscan";
          Description = "Checking balances";
          Alias = "!eth";
          Method = "GET";
          URLTemplate = "https://etherscan.io/search?f=0&q={searchTerms}";
        }
      ];
    };

    security = {
      sanitizeOnShutdown = false;
      sandbox = true;
      userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
    };

    misc = {
      drmFix = true;
      disableWebgl = false;
    };
  };

  xdg.configFile."alacritty".source = ../config/alacritty;
  xdg.configFile."lazygit".source   = ../config/lazygit;
  xdg.configFile."gophrland".source = ../config/gophrland;
  xdg.configFile."fish".source      = ../config/fish;
  xdg.configFile."rofi".source      = ../config/rofi;
  xdg.configFile."swaync".source    = ../config/swaync;
  xdg.configFile."wlogout".source   = ../config/wlogout;
  xdg.configFile."waybar".source    = ../config/waybar;
  xdg.configFile."ideavim".source   = ../config/ideavim;
  xdg.configFile."mpv".source       = ../config/mpv;
  xdg.configFile."hypr".source      = ../config/hyprland;
  xdg.configFile."foot".source      = ../config/foot;
  # xdg.configFile."ags".source      = ../config/ags;

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "/home/edouard.jubert.ext/.nix-profile/bin/firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
