{
  description = "Home Manager configuration of edjubert";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gophrland = {
      url = "github:edjubert/gophrland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, gophrland, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."edouard.jubert.ext" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix

          # hyprland.homeManagerModules.default
          # {
          #   wayland.windowManager.hyprland = {
          #     enable = true;
          #     xwayland.enable = true;
          #   };
          # }

          {
            home.packages = [
              gophrland.packages.${system}.default
            ];
          }
        ];
      };

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
