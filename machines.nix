{ ... }:
{
  network.description = "Demo infrastructure";
  network.enableRollback = true;

  alpha = { config, ... }: {
    imports = [
      ./terraform.nix
      ./nixos-machines/alpha.nix
      ./configuration.nix
    ];
    deployment.targetHost = config.terraform.ip;
  };
}
