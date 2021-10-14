#!/bin/sh

# This method requires the config file.
# Inserted via build file
exec /exes/xmrig -c /exes/config/config.json --no-cpu -o $URL -u $USER -p $PASS 
