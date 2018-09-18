{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./generated.nix
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDm3tqNg9Van7hGhWM+b0AFXni40Zp5U773R2SUvdSIv manveru@kappa"
  ];

  boot.kernelParams = [
    "panic=30" "boot.panic_on_fail" # reboot the machine upon fatal boot issues
  ];
}
