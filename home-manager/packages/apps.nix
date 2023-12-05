{ config, pkgs, lib, specialArgs, ... }:
let helpers = import ../modules/nixGL/nixGL.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };

in {
  home.packages = with pkgs; [
    _1password
    _1password-gui
    slack
    whatsapp-for-linux
    signal-desktop
    (helpers.nixGLIntelWrap wdisplays)
    (helpers.nixGLIntelWrap chiaki)
  ];
}

