#!/bin/env bash

flatpak run --command=bash com.usebottles.bottles <<EOT
gsettings set com.usebottles.bottles dark-theme true
EOT
