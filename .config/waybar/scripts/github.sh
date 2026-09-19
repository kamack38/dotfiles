#!/bin/bash

token=$(cat "${HOME}/.keys/github-noti.token")
response=$(curl -u "username:${token}" https://api.github.com/notifications)
count=$(echo "$response" | jq '. | length')
tooltip=$(echo "$response" | jq '.[] | ("- " + .subject.title + " (" + .repository.full_name + ")")')

if [[ "$count" != "0" ]]; then
	echo '{"text":'$count',"tooltip":'$tooltip',"class":"$class"}'
fi
