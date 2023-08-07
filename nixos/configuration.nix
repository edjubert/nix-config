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
    systemd-boot.enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  systemd.user.services = {
    polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
	ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	Restart = "on-failure";
	RestartSec = 1;
	TimeoutStopsec = 10;
      };
    };
    xdg-desktop-portal-gtk = {
      description = "xdg-desktop-portal-gtk";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/etc/systemd/user/xdg-desktop-portal-gtk";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    xdg-desktop-portal-hyprland = {
      description = "xdg-desktop-portal-hyprland";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      # after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/etc/systemd/user/xdg-desktop-portal-hyprland";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

  };

  boot.kernelParams = [
    "quiet"
    "tuxedo_keyboard.mode=0"
    "tuxedo_keyboard.brightness=25"
    "tuxedo_keyboard.color_left=0x0000ff"
  ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    keyMap = "colemak";
    useXkbConfig = false; # use xkbOptions in tty.
  };

  # xdg.portal.enable = true;

  programs.fish.enable = true;
  programs.light.enable = true;

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
    "nodejs-14.21.3"
    "electron-13.6.9"
  ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    enable = true;
    layout = "us";
    xkbOptions = "colemak,caps:escape";
    videoDrivers = ["nvidia"];
  };

  hardware = {
    # tuxedo-keyboard.enable = true;

    nvidia.modesetting.enable = true;
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
    description = "edjubert";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
    shell = pkgs.fish;
  };

  users.users.namoureuse = {
    isNormalUser = true;
    description = "Namoureuse";
  };

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    neovim
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

  system.autoUpgrade.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?
}

