{
  description = "Home Manager configuration of edjubert";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
   gophrland = {
      url = "github:edjubert/gophrland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprsome = {
        url = "github:sopa0/hyprsome";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, gophrland, ags, hyprsome, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."edouard.jubert.ext" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./homes/edouard.jubert.ext.nix

          {
            home.packages = [
              ags.packages.${system}.default
              gophrland.packages.${system}.default
              hyprsome.packages.${system}.default
            ];
          }
        ];
      };

      homeConfigurations."edjubert" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./homes/edjubert.nix
          {
            home.packages = [
              ags.packages.${system}.default
              gophrland.packages.${system}.default
              hyprsome.packages.${system}.default
            ];
          }
        ];
      };
    };
}
