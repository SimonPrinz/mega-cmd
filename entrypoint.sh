#!/usr/bin/env bash

email="${EMAIL}"
password="${PASSWORD}"
mfa="${MFA}"
directory="${DIRECTORY}"

if [ -z "${mfa}" ];
then
    mega-login "$email" "$password"
else
    mega-login "$email" "$password" --auth-code="$mfa"
fi

mega-webdav "$directory" --public --port=80

while true
do
    sleep 3600 # 1 hours
    mega-reload
done
