self: super:
let
  name = "jetbrains-toolbox";
  src = ./jetbrains-toolbox;
  libPath = super.lib.makeLibraryPath [
    super.stdenv.cc.cc.lib
    super.glibc
    super.xorg.xcbutilkeysyms
    super.gcc
    super.zlib
    super.libsecret
    super.xorg.libXext
  ];
  extractApp = { name, src }: super.pkgs.runCommand "${name}-extracted" {
    buildInputs = [
      super.appimageTools.appimage-exec
      super.patchelf
      super.gcc
      super.libcef
    ];
  } ''
    appimage-exec.sh -x $out ${src}
    patchelf \
      --set-rpath "${libPath}:$out/jre/lib:/usr/lib64" \
      --set-interpreter ${super.glibc}/lib64/ld-linux-x86-64.so.2 \
      $out/jetbrains-toolbox
    patchelf --set-interpreter ${super.glibc}/lib64/ld-linux-x86-64.so.2 $out/glibcversion
  '';
  appimageContents = extractApp { inherit name src; };
in
{
  jetbrains-toolbox = super.appimageTools.wrapAppImage {
    inherit name;
    src = appimageContents;
    extraPkgs = pkgs: with pkgs; [
      pkgs.libsecret
      super.stdenv.cc.cc.lib
      super.glibc
      super.xorg.xcbutilkeysyms
      super.xorg.libXext
      super.gcc
      super.zlib
      super.libcef
    ];
    extraInstallCommands = ''
      mkdir -p $out/share/applications
      install -m 444 -D ${appimageContents}/jetbrains-toolbox.desktop -p $out/share/applications
      substituteInPlace $out/share/applications/jetbrains-toolbox.desktop \
        --replace 'Exec=AppRun' 'Exec=${name}'
    '';
  };
}

