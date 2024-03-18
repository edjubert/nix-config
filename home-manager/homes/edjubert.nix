{ config, pkgs, inputs, ... }:

{
  home.username = "edjubert";
  home.homeDirectory = "/home/edjubert";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "trayIconsReloaded@selfmade.pl"
      ];
    };
  };

  home.packages = with pkgs; [
    # Dev
    wayland-protocols
    pkg-config
    x265
    libde265
    libjpeg
    libtool
    libheif
    cmake
    gthumb
    # jetbrains.goland

    # Apps
    kicad
    nwg-look
    chiaki

    # Tools
    networkmanagerapplet
    wdisplays
    imagemagick

    # Terminal
    alacritty
  ];

  imports = [
    ../packages/apps.nix
    ../packages/browser.nix
    ../packages/dev.nix
    ../packages/git.nix
    ../packages/gnomeExtensions.nix
    ../packages/ide.nix
    ../packages/iphone.nix
    ../packages/terminal.nix
    ../packages/theme.nix
    ../packages/tools.nix
    ../packages/video.nix
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "peach" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.fish.enable = true;

  fonts.fontconfig.enable = true;

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

  xdg.configFile."alacritty".source = ../config/alacritty;
  xdg.configFile."foot".source      = ../config/foot;
  xdg.configFile."gophrland".source = ../config/gophrland;
  xdg.configFile."fish".source      = ../config/fish;
  xdg.configFile."rofi".source      = ../config/rofi;
  xdg.configFile."swaync".source    = ../config/swaync;
  xdg.configFile."wlogout".source   = ../config/wlogout;
  xdg.configFile."waybar".source    = ../config/waybar;
  xdg.configFile."ideavim".source   = ../config/ideavim;
  xdg.configFile."mpv".source       = ../config/mpv;
  xdg.configFile."hypr".source       = ../config/hyprland;

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
