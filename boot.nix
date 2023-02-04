{ config, ... }:

{
  boot.loader = {
    timeout = 5;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      device = "nodev";
      version = 2;
      enableCryptodisk = true;
      default = "saved";
      efiSupport = true;
    };
  };
}
