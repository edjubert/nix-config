{ lib, stdenv, fetchurl, unzip, p7zip }:
stdenv.mkDerivation rec {
  pname = "mac-ventura-kde";
  version = "0.1";

  mac-ventura-kde = fetchGit {
    url = "https://github.com/vinceliuice/MacVentura-kde";
    rev = "dd1adb393d1aa3cb10ee5dbfeb66209be6a9fa1c";
  };

  nativeBuildInputs = [];
  sourceRoot = ".";

  installPhase = ''
    sh install.sh --round
  '';

  meta = {
    description = "MacVentura-kde";
    homepage = "https://github.com/edjubert/nix-config/blob/master/home-manager/modules/mac-ventura-kde"
  };
}

