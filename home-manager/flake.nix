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
    nixGL = {
        url = "github:guibou/nixGL";
    };

    schizofox = {
      url = "github:schizofox/schizofox";
      # url = "path:/home/sioodmy/dev/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    hyprlang = {
      url = "github:hyprwm/hyprlang";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, hyprlang, hypridle, hyprlock, gophrland, ags, hyprsome, nixGL, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
          system = system;
          overlays = [ nixGL.overlay ];
        };
      # pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."edouard.jubert.ext" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./homes/edouard.jubert.ext.nix

          inputs.schizofox.homeManagerModule
          {
            home.packages = [
              ags.packages.${system}.default
              gophrland.packages.${system}.default
              hyprsome.packages.${system}.default
              hyprlang.packages.${system}.default
              #hyprlock.packages.${system}.default
              #hypridle.packages.${system}.default
            ];
          }
        ];
      };

      homeConfigurations."edjubert" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./homes/edjubert.nix

          inputs.schizofox.homeManagerModule
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
