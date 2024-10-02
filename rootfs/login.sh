#!/usr/bin/env bash

if [ -z "${MFA}" ];
then
    mega-login "${EMAIL}" "${PASSWORD}"
else
    mega-login "${EMAIL}" "${PASSWORD}" --auth-code="${MFA}"
fi
exitCode=$?

if [ $exitCode = "0" ];
# success, everything is great
then
    # do nothing
    sleep 0
elif [ $exitCode = "54" ];
# exit code 54 is returned when the session already exists
then
    mega-reload
    exitCode=$?
    if [ $exitCode != "0" ];
    then
        # stop everything
        /run/s6/basedir/bin/halt
        exit $exitCode
    fi
else
    # stop everything
    /run/s6/basedir/bin/halt
    exit $exitCode
fi
