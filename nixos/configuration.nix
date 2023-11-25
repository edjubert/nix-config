# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    timeout = 1;
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  xdg.portal = {
    enable = true;
  };

  users.extraGroups.vboxusers.members = [ "edjubert" ];
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  boot.kernelParams = [
    "quiet"
    "tuxedo_keyboard.mode=1"
    "tuxedo_keyboard.brightness=25"
    "tuxedo_keyboard.color_left=0x0000ff"
    "tuxedo_keyboard.color_right=0x00ffff"
    "tuxedo_keyboard.color_center=0xffffff"
    "module_blacklist=i915"
  ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    keyMap = "colemak";
    useXkbConfig = false; # use xkbOptions in tty.
  };

  programs.fish.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.hyprland.nvidiaPatches = true;

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
    "nodejs-14.21.3"
    "electron-13.6.9"
  ];

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.xserver = {
    displayManager.gdm = {
      enable = true;
      wayland= true;
    };
    desktopManager.gnome.enable = true;

    enable = true;
    layout = "us";
    xkbOptions = "colemak,caps:escape";
    videoDrivers = ["nvidia"];
  };

  hardware = {
    tuxedo-keyboard.enable = true;

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaPersistenced = true;
    };

    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        vaapiVdpau
	      libvdpau-va-gl
	      nvidia-vaapi-driver
      ];
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.edjubert = {
    isNormalUser = true;
    description = "Edouard";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
    shell = pkgs.fish;
  };

  users.users.namoureuse = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    description = "Namoureuse";
  };

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MUTTER_ALLOW_HYBRID_GPUS = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    EGL_PLATFORM = "wayland";
    GST_VAAPI_ALL_DRIVERS = "1";
  };

  environment.systemPackages = with pkgs; [
    catppuccin-gtk
    gnome.adwaita-icon-theme
    libcamera
    whitesur-icon-theme
    neovim
    nvidia-vaapi-driver
    egl-wayland
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gedit
    epiphany
    geary
    totem
    tali
    iagno
    hitori
    atomix
  ]);

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.userActivationScripts = {
    # startXdgDesktopPortal.text = ''
    #   #!/bin/sh
    #   source ${config.system.build.setEnvironment}

    #   systemctl --user mask xdg-desktop-portal-hyprland
    #   systemctl --user stop xdg-desktop-portal-hyprland

    #   systemctl --user unmask xdg-desktop-portal-gnome
    #   systemctl --user start xdg-desktop-portal-gnome

    #   systemctl --user restart xdg-desktop-portal
    # '';

    linktosharedfolder.text = ''
      if [[ ! -h "$HOME/.config/nvim" ]];
      then
        ln -s "$HOME/.config/home-manager/config/nvim/" "$HOME/.config/nvim"
      fi

      if [[ ! -h "$HOME/.config/ags" ]];
      then
        ln -s "$HOME/.config/home-manager/config/ags/" "$HOME/.config/ags"
      fi

      if [[ ! -h "$HOME/.config/lazygit" ]];
      then
        ln -s "$HOME/.config/home-manager/config/lazygit/" "$HOME/.config/lazygit"
      fi

      if [[ ! -h "$HOME/.config/swww" ]];
      then
        ln -s "$HOME/.config/home-manager/config/swww/" "$HOME/.config/swww"
      fi
    '';
  };

  system.autoUpgrade.enable = true;

  system.stateVersion = "unstable"; # Did you read the comment?
}

