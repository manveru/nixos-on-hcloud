#!/bin/sh

if [ -z "$(which nix)" ]; then
	echo "Nix is not installed.. installing"
  apt-get install -y curl
  mkdir -p /etc/nix
  echo "build-users-group =" > /etc/nix/nix.conf
	curl https://nixos.org/nix/install | sh
	. $HOME/.nix-profile/etc/profile.d/nix.sh
fi

cd /nixos-kexec

BUNDLE=$(nix-build --no-out-link -j4 release.nix -A kexec_bundle)

sh $BUNDLE
