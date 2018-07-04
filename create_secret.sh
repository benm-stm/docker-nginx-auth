#!/bin/sh

i=0;
mkdir -p /etc/nginx/

while IFS='' read -r line #|| [[ -n "$line" ]]
do
    pass_sec_pattern=`cat /dev/urandom | tr -dc 'a-zA-Z0-9@!=#' | fold -w 20 | head -n 1`
    echo "$line : ${pass_sec_pattern}" >> generated_passwords

    if [ $i -eq 0 ]
    then
        htpasswd -b -c /etc/nginx/.htpasswd $line "${pass_sec_pattern}"
        i=$(( $i + 1 ))
    else
        htpasswd -b /etc/nginx/.htpasswd $line "${pass_sec_pattern}"
    fi
done < "$1"
