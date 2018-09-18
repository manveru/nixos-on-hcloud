variable hcloud_token {
  type = "string"
}

provider "hcloud" {
  token = "${var.hcloud_token}"
}

resource "hcloud_ssh_key" "manveru" {
  name = "manveru@kappa"
  public_key = "${file("~/.ssh/id_ed25519.pub")}"
}

resource "hcloud_server" "alpha" {
  name = "alpha"
  server_type = "cx11"
  location = "nbg1"
  image = "debian-9"
  ssh_keys = ["${hcloud_ssh_key.manveru.name}"]

  provisioner "file" {
    content = "${hcloud_ssh_key.manveru.public_key}"
    destination = "/ssh_pubkey"
  }

  provisioner "file" {
    source = "nixos-kexec"
    destination = "/nixos-kexec"
  }

  provisioner "remote-exec" {
    script = "nixos-kexec/install.sh"
  }
}

resource "nixos_node" "alpha" {
  node_name = "alpha"
  ip = "${hcloud_server.alpha.ipv4_address}"
  nix = <<NIX
    networking.hostName = "${hcloud_server.alpha.name}";
  NIX
}

output "alpha-ip" {
  value = "${hcloud_server.alpha.ipv4_address}"
}
