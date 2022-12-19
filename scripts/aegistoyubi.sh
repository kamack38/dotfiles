#!/bin/bash

jq -r '.db.entries[] | [.name, .issuer, .info.algo, .info.secret]| @tsv' <"$1" |
	while IFS=$'\t' read -r name issuer algo secret; do
		ykman oath accounts add -i "$issuer" -a "$algo" "$name" "$secret"
		# echo "ykman oath accounts add -a \"$algo\" \"$name\" \"$secret\""
	done
