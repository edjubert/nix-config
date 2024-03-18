{ config, pkgs, lib, specialArgs, ... }:
let helpers = import ../modules/nixGL/nixGL.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };

in {
  home.packages = with pkgs; [
    gnomeExtensions.backslide
    gnomeExtensions.blur-my-shell
    gnomeExtensions.mouse-follows-focus
    gnomeExtensions.pop-shell
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.switch-workspaces-on-active-monitor
    gnomeExtensions.appindicator
    gnomeExtensions.tray-icons-reloaded
    gnome.nautilus
    gnome.sushi
    gnome.eog
    gnome-photos
  ];
}

