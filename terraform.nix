{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.terraform;
in {
  options = {
    terraform = {
      name = mkOption {
        type = types.string;
      };

      ip = mkOption {
        type = types.string;
      };
    };
  };
}
