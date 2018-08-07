# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b2b089ec-3aee-4a5f-b796-6653b975ea5a";
      fsType = "ext4";
    };

  fileSystems."/boot/" =
    { device = "/dev/disk/by-uuid/3A67-A109";
      fsType = "vfat";
    };

  swapDevices =[ ];

  nix.maxJobs = 4;
}
