#!/bin/bash

gh auth login
gh config set -h github.com git_protocol https

# Add gh fish completion
gh completion -s fish >$HOME/.config/fish/completions/gh.fish
