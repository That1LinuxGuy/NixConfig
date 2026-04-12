{ config, pkgs, ... }:

{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  services.tailscale.enable = true;
  services.fail2ban.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    53   # DNS resultion
    80   # HTTP 
    443  # HTTPS
    6443 # k3s: required so pods can reach API server
    2379 # k3s, etcd clients: required for High Availability etcd
    2380 # k3s, etcd clients: required for High Availability etcd
  ];

  networking.firewall.allowedUDPPorts = [
    8472 # k3s, flannel: required if using multi-node for inter-node networking
    53   # DNS resolution
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
