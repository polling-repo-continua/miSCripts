#!/bin/bash

echo 'ip,domain,hostname,signing,smbv1,os'
# remove the colors and null bytes
sed "s/\x1b[^m]*m//g" | tr -d '\0' | \
grep '^SMB[[:blank:]]*[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}[[:blank:]]*[0-9]*[[:blank:]]*[^[:blank:]]*[[:blank:]]*\[\*\] .* (name:[^)]*) (domain:[^)]*) (signing:[^)]*) (SMBv1:[^)]*)$' | \
sort -Vu | \
sed 's_^SMB[[:blank:]]*\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)[[:blank:]]*[0-9]*[[:blank:]]*\([^[:blank:]]*\)[[:blank:]]*\[\*\] \(.*\) (name:\([^)]*\)) (domain:\([^)]*\)) (signing:\([^)]*\)) (SMBv1:\([^)]*\))$_\1,\U\5\E,\4,\6,\7,\3_' | \
uniq

