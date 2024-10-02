#!/usr/bin/env bash

output=$(mega-webdav "${DIRECTORY:-/}" --public --port=80) # change port for caddy
exitCode=$?
if [ $exitCode != "0" ];
then
    # stop everything
    /run/s6/basedir/bin/halt
    exit $exitCode
fi

path=$(echo $output | sed -n 's|.*http://.*/\([^/]*\)/.*|\1|p')
echo "prepared path for caddy: ${path}"

# tail log file as "long running" task
tail -f /home/mega/.megaCmd/megacmdserver.log*
