#!/bin/bash

jq -r '.db.entries[] | [.name, .issuer, .info.algo, .info.digits, .info.period, .info.secret]| @tsv' "$1" |
	while IFS=$'\t' read -r name issuer algo digits period secret; do
		ykman oath accounts add \
			--issuer "$issuer" \
			--algorithm "$algo" \
			--digits "$digits" \
			--period "$period" \
			"$name" \
			"$secret"
	done
