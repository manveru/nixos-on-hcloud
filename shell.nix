with import ./nixpkgs.nix;

let
  # If terraform tells you to install plugins, just add them here and restart
  # your nix-shell.
  terraform-with-plugins = terraform.withPlugins (plugins: [
    plugins.hcloud
    terraform-provider-nixos
  ]);
in mkShell {
  buildInputs = [
    terraform-with-plugins
  ];
}
