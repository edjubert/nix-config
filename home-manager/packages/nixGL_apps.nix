{ config, pkgs, lib, specialArgs, ... }:
let helpers = import ../modules/nixGL/nixGL.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };

in {
  home.packages = with pkgs; [
    (helpers.nixGLIntelWrap firefox)
    (helpers.nixGLIntelWrap chromium)

    (helpers.nixGLIntelWrap jetbrains-toolbox)

    (helpers.nixGLIntelWrap alacritty)

    (helpers.nixGLIntelWrap ffmpeg)
    (helpers.nixGLIntelWrap kooha)
    (helpers.nixGLIntelWrap (mpv.override {
      scripts = [mpvScripts.mpris];
    }))

    (helpers.nixGLIntelWrap wdisplays)
    (helpers.nixGLIntelWrap chiaki)
  ];
}


