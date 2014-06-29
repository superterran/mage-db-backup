#!/bin/bash
MAGEROOT="$1/app/etc/local.xml"; 

echo $MAGEROOT;
# Gettign the credentials and sanitizing them
host="$(echo "cat /config/global/resources/default_setup/connection/host/text()" | xmllint --nocdata --shell $MAGEROOT | sed '1d;$d')"
username="$(echo "cat /config/global/resources/default_setup/connection/username/text()" | xmllint --nocdata --shell $MAGEROOT | sed '1d;$d')"
password="$(echo "cat /config/global/resources/default_setup/connection/password/text()" | xmllint --nocdata --shell $MAGEROOT | sed '1d;$d')"
dbname="$(echo "cat /config/global/resources/default_setup/connection/dbname/text()" | xmllint --nocdata --shell $MAGEROOT | sed '1d;$d')"
host=${host//-/}
username=${username//-/}
password=${password//-/}
dbname=${dbname//-/}
host=${host// /}
username=${username// /}
password=${password// /}
dbname=${dbname// /}

host=${host//$'\n'/}
username=${username//$'\n'/}
password=${password//$'\n'/}
dbname=${dbname//$'\n'/}


mysqldump  --quick --routines --single-transaction --skip-lock-tables -u$username -p$password $dbname 
  
#printf '%s\n' "host: $host" "username: $username" "password: $password" "dbname: $dbname"

