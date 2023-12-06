{ config, pkgs, lib, specialArgs, ... }:
let helpers = import ../modules/nixGL/nixGL.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };

in {
  home.packages = [
    (helpers.nixGLIntelWrap pkgs.firefox)
    (helpers.nixGLIntelWrap pkgs.chromium)
  ];
}
