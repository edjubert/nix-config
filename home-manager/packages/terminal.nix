{ config, pkgs, lib, specialArgs, ... }:
let helpers = import ../modules/nixGL/nixGL.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };

in {
  home.packages = with pkgs; [
    (helpers.nixGLIntelWrap alacritty)
    bat
    direnv
    fzf
    htop
    jq
    killall
    ripgrep
    zellij
    any-nix-shell
  ];
}


