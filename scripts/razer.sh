#!/bin/bash

HELPER="paru"

echo "Installing razer drivers & RGB software..."
$HELPER -S --noconfirm --needed --quiet polychromatic-git \
    openrazer-meta-git

