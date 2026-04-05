{ pkgs, ... }:

{
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://192.168.1.247:6443";
    tokenFile = "/var/lib/rancher/k3s/server/node-token";
  };
}

