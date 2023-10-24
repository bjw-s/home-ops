{ config, pkgs, lib, ... }:

{
  imports = [
      # Host-specific hardware
      ./hardware-configuration.nix

      # Common imports
      ../common/nixos
      ../common/nixos/users/bjw-s
      ../common/optional/fish.nix
      ../common/optional/k3s-server.nix
      ../common/optional/nfs-server.nix
      ../common/optional/qemu.nix
      ../common/optional/samba-server.nix
      ../common/optional/zfs.nix
  ];

  networking = {
    hostName = "nas-vm";
    hostId = "8023d2b9";
    networkmanager.enable = true;
  };

  # Group config
  users.groups = {
    backup-rw = {
      gid = 65541;
      members = ["bjw-s"];
    };
    docs-rw = {
      gid = 65543;
      members = ["bjw-s"];
    };
    media-ro = {
      gid = 65540;
      members = ["manyie"];
    };
    media-rw = {
      gid = 65539;
      members = ["bjw-s"];
    };
  };

  # ZFS config
  boot.zfs = {
    devNodes = "/dev/disk/by-path";
    extraPools = [
      "tank"
    ];
  };

  # Samba config
  services.samba.shares = {
    Media = {
      path = "/tank/Media";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
    };
  };

  # may fix issues with network service failing during a nixos-rebuild
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
