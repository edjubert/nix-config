{ config, pkgs, inputs, lib, ... }:

{
  home = {
    username = "edouard.jubert.ext";
    homeDirectory = "/home/edouard.jubert.ext";
    stateVersion = "23.11"; # Please read the comment before changing.
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  targets.genericLinux.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (pkg: true);
    };
  };


  gtk = {
    enable = false;
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

  home.packages = [];

  imports = [
    ../packages/apps.nix
    ../packages/browser.nix
    ../packages/dev.nix
    ../packages/git.nix
    ../packages/gnomeExtensions.nix
    ../packages/iphone.nix
    ../packages/terminal.nix
    ../packages/theme.nix
    ../packages/tools.nix
    ../packages/video.nix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.fish.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      lla = "ls -la";
      lg = "lazygit";
      run-tests = "cd $HOME/workspace/go; /usr/bin/bash $HOME/workspace/go/build/run-tests; notify-send \"LBC tests finished\"";
    };

    initExtra = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
      theme = "half-life";
    };
  };

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
    enable = false;

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
      removeEngines = ["Bing" "Brave" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
      searxUrl = "https://www.google.com";
      searxQuery = "https://www.google.com/search?q={searchTerms}";
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

    extensions.extraExtensions = {
      "vimium-c@gdh1995.cn".install_url = "https://addons.mozilla.org/firefox/downloads/file/4098265/vimium-c-1.99.99.xpi";
      "sponsorBlocker@ajay.app".install_url = "https://addons.mozilla.org/firefox/downloads/file/41104713/sponsorblock-5.4.5.xpi";
      "{d634138d-c276-4fc8-924b-40a0ea21d284}".install_url = "https://addons.mozilla.org/firefox/downloads/file/4168788/latest.xpi";
      "firefox-alpenglow@mozilla.org".install_url = "resource://builtin-themes/alpenglow/";
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
  xdg.configFile."zellij".source      = ../config/zellij;

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "/home/edouard.jubert.ext/.nix-profile/bin/firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
