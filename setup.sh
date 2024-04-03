#!/usr/bin/env bash

# For non-NixOS systems
if [ -z $(command -v nix) ] || [ -z $(command -v nix-shell) ]; then
  echo "Nix not detected. Installing.."
  if [ $(uname -s) = "Darwin" ]; then
    sh <(curl -L https://nixos.org/nix/install)
  else
    sh <(curl -L https://nixos.org/nix/install) --daemon
  fi
fi

if [ ! -f $HOME/.config/nix/nix.conf ]; then
  echo "Creating nix config so nix command and flakes work.."
  echo "experimental-features = flakes nix-command" >$HOME/.config/nix/nix.conf
fi

if [ $(uname -s) = "Darwin" ]; then
  nix run nix-darwin -- switch --flake .
elif [ $(uname -s) = "Linux" ]; then
  if [ -f /etc/NIXOS ]; then
    sudo nixos-rebuild switch --flake .
  else
    # Probably won't have this situation as I'd rather use
    # NixOS on WSL2, but just in case
    nix run home-manager -- switch --flake .
  fi
else
  echo "Unknown system. Cannot setup appropriately."
  exit 1
fi

if [ $? = 0 ]; then
  echo "Setup mostly completed. Running 'rebuild' to finish post-build tasks.."
  rebuild
fi
