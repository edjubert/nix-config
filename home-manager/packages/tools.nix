{ config, pkgs, lib, specialArgs, ... }:
let helpers = import ../modules/nixGL/nixGL.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };

in {
  home.packages = with pkgs; [
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
    wayshot
    flameshot
    k9s
    wlogout
  ];
}


