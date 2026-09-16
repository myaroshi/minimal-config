{ pkgs, ... }:

{
  system.stateVersion = "26.05";

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Networking
  networking.networkmanager.enable = true;

  # X11
  services.xserver.enable = true;

  # Window manager
  services.xserver.windowManager.icewm.enable = true;

  # Login screen
  services.xserver.displayManager.lightdm.enable = true;

  # Make IceWM the default session
  services.displayManager.defaultSession = "icewm";

  # Keyboard
  services.xserver.xkb.layout = "us";

  # Graphics
  hardware.graphics.enable = true;

  # User
  users.users.frace = {
    isNormalUser = true;
    description = "frace";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # Very small set of useful applications
  environment.systemPackages = with pkgs; [
    alacritty
    pcmanfm
  ];

  # Bootloader
  #
  # UEFI:
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # BIOS/Legacy:
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
}
