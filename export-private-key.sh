#!/bin/sh


if [[ ($# -ne 3) && ($# -ne 4) ]] ; then
    echo 'Invalid number of parameters ' $#
    echo '\nUsage:'
    echo 'export-private-key <path.to.truststore> <truststore.password> <private.key.alias> <private.key.password>'
    echo '\n<private.key.password> is optional, if missing is assumed it'\''s same as truststore'\''s'
    exit 1
fi

prgName=$0
truststore=$1
truststorepass=$2
privkeyalias=$3

echo "prgName=$0"
echo "truststore=$1"
echo "truststorepass=$2"
echo "privkeyalias=$3"

if [[ ($# -eq 4) ]] ; then
    privkeypass="-srckeypass '$4'"
    p12pass="-password \"$4\""
else
    privkeypass=''
    p12pass=''
fi

echo "privkeypass = $privkeypass"
echo "p12pass = $p12pass"

echo "keytool -v -importkeystore -srckeystore $truststore -srcstorepass "$truststorepass" -srcalias $privkeyalias $privkeypass -destkeystore $privkeyalias-private-key.p12 -deststoretype PKCS12 -deststorepass 123456 -destkeypass 123456"
keytool -v -importkeystore -srckeystore $truststore -srcstorepass "$truststorepass" -srcalias $privkeyalias $privkeypass -destkeystore $privkeyalias-private-key.p12 -deststoretype PKCS12 -deststorepass 123456 -destkeypass 123456

echo "openssl pkcs12 -in $privkeyalias-private-key.p12 -passin pass:123456 -nocerts -nodes > $privkeyalias-private-key.txt"
openssl pkcs12 -in $privkeyalias-private-key.p12 -passin pass:123456 -nocerts -nodes > $privkeyalias-private-key.txt