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
    pywal
    # signal-desktop # it still returns to update the signal version, have to create a flake
    (helpers.nixGLIntelWrap wdisplays)
    (helpers.nixGLIntelWrap chiaki)
  ];
}

