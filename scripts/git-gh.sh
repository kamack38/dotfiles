#!/bin/bash

gh auth login
gh config set -h github.com git_protocol https
gh completion -s fish >"$XDG_DATA_HOME/fish/vendor_completions.d/gh.fish"
