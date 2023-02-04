{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.maestral ];

  systemd.user.path = { 
    "dropbox-sync.path" = {
      enable = true;
      description = "Monitors a /root/dropbox to activate dropbox-sync.service";
      pathConfig = {
        PathChanged = "/root/dropbox"
	Unit = "dropbox-sync.service";
      };
    };
    "dropbox-sync.service = {
      enable = true;
      description = "Activated on dropbox-sync.path to zip, encrypt, and sync files to dropbox";
      script = ''
        
      '';
    };
  };


  # keep dropbox config updated
  system.activationScripts = {
    nixos_config_dropbox_sync.text = "echo 'syncing config to dropbox...' && sync -d /etc/nixos/ /root/dropbox/nixos-conf/";
  };
}
