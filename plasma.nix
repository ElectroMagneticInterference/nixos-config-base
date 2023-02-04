{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5 = {
      enable = true;
      excludePackages = with pkgs.libsForQt5; [
        elisa
        gwenview
        okular
        oxygen
        khelpcenter
        konsole
        plasma-browser-integration
	kate
      ];
    };
    layout = "us";
    xkbVariant = "";
  };

  environment.systemPackages = [ pkgs.kwallet-pam ];
  users.users.eimmer.packages = [ pkgs.kwallet-pam ];

  security.pam.services.eimmer.enableKwallet = true;
}
