{
  description = "Home Manager configuration of edjubert";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."edjubert@nixos" = home-manager.lib.homeManagerConfiguration {
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
	];

      };

      nixpkgs.config.allowUnfree = true;
    };
}
