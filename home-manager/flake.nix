{
  description = "Home Manager configuration of edjubert";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gophrland = {
      url = "github:edjubert/gophrland?rev=019993148e1837862d3e5f89c80c3d660cf4db88";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, gophrland, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."edjubert" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          hyprland.homeManagerModules.default
          {
            wayland.windowManager.hyprland = {
              enable = true;
              nvidiaPatches = true;
              xwayland.enable = true;
            };
          }
          {
            home.packages = [
              gophrland.packages.${system}.default
            ];
          }
        ];
      };
    };
}
