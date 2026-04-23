#!/bin/bash

SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_ASKPASS

ssh-add $HOME/.ssh/id_ed25519
