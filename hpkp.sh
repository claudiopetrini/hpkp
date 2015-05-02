#!/bin/sh
# Credits https://noncombatant.org/2015/05/01/about-http-public-key-pinning/

type="x509"
case "$1" in
  x509)
    type="x509"
    ;;
  req)
    type="req"
    ;;
  *)
    echo "Usage: $0 x509 certificate-pathname"
    echo "       $0 req certificate-signing-request-pathname"
    exit 1
esac

openssl $type -noout -in "$2" -pubkey | \
  openssl asn1parse -noout -inform pem -out public.key
openssl dgst -sha256 -binary public.key | openssl enc -base64