#!/usr/bin/env bash

while true
do
    # default sleep interval for reload is 1 day
    sleep "${RELOAD_INTERVAL:-86400}"
    mega-reload
    exitCode=$?
    if [ $exitCode != "0" ];
    then
        # stop everything
        /run/s6/basedir/bin/halt
        exit $exitCode
    fi
done
