{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-bulbasaur.nix
    ];

  networking.hostName = "bulbasaur"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.openiscsi = {
  enable = true;
  name = "${config.networking.hostName}-bulbasaur";
  };

}
