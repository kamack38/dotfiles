#!/bin/bash

token=$(cat "${HOME}/.keys/github-noti.token")
count=$(curl -u "username:${token}" https://api.github.com/notifications | jq '. | length')

if [[ "$count" != "0" ]]; then
	echo '{"text":'$count',"tooltip":"$tooltip","class":"$class"}'
fi
