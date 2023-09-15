{ config, pkgs, inputs, ... }:

{
  home.username = "edjubert";
  home.homeDirectory = "/home/edjubert";
  home.stateVersion = "23.05"; # Please read the comment before changing.
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
    nodejs
    deno
    go
    rustup
    sassc
    gcc
    cmake

    # IDE
    jetbrains.datagrip
    jetbrains.idea-ultimate

    # Theme
    nerdfonts

    # Apps
    _1password
    _1password-gui
    slack
    steam
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
    gnomeExtensions.appindicator
    gnomeExtensions.tray-icons-reloaded

    # Tools
    brightnessctl
    cliphist
    gammastep
    grim
    networkmanagerapplet
    pamixer
    pulsemixer
    rofi
    slurp
    swappy
    swaylock-effects
    swww
    wdisplays
    wl-clipboard
    wlogout
    wf-recorder

    # Terminal
    alacritty
    foot
    foot
    bat
    direnv
    fzf
    htop
    jq
    killall
    ripgrep
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Peach-dark";

      package = pkgs.catppuccin-gtk.override {
        accents = [ "peach" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
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
  xdg.configFile."lazygit".source   = ../config/lazygit;
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
