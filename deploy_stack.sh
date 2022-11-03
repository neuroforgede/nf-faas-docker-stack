#!/bin/sh

export BASIC_AUTH="true"
export AUTH_URL="http://basic-auth-plugin:8080/validate"

if [ $BASIC_AUTH = "true" ];
then
  echo ""
  echo "Enabling basic authentication for gateway.."
  echo ""
else
  echo ""
  echo "Disabling basic authentication for gateway.."
  echo ""
fi

docker-sdp stack deploy func -c $composefile
