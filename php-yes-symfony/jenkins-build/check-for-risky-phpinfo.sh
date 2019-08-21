#!/bin/sh

dir=$1
risky_files=$(grep -r 'phpinfo()' "$dir")
md5_generated=$(echo "$risky_files" | md5sum | tr -d ' -')
md5_trusted=$2

echo "Generated the following MD5: $md5_generated"
echo

if [ ! -z "$risky_files" ] ; then
    if [ "$md5_generated" = "$md5_trusted" ] ; then
        exit 0
    fi
    printf "Risky files found:\n\n"
    echo "$risky_files"
    exit 1
fi
exit 0
