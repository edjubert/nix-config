{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs :
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [
            (import ./overlay/jetbrains-toolbox/overlay.nix)
          ];
        })
      ];
    };
  };
}
