{
  inputs = {
    tuxedo-nixos = {
      url = "github:blitz/tuxedo-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, tuxedo-nixos }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix tuxedo-nixos.nixosModules.default { hardware.tuxedo-control-center.enable = true; } ];
    };
  };
}
