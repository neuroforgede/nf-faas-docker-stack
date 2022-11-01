#!/bin/sh

if ! [ -x "$(command -v docker)" ]; then
  echo 'Unable to find docker command, please install Docker (https://www.docker.com/) and retry' >&2
  exit 1
fi

export BASIC_AUTH="true"
export AUTH_URL="http://basic-auth-plugin:8080/validate"

sha_cmd="shasum -a 256"
if ! command -v shasum >/dev/null; then
  sha_cmd="sha256sum"
fi

while [ ! $# -eq 0 ]
do
	case "$1" in
		--no-auth | -n)
			export BASIC_AUTH="false"
      export AUTH_URL=""
			;;
    --help | -h)
			printf "Usage: \n [default]\tdeploy the OpenFaaS core services\n --no-auth [-n]\tdisable basic authentication.\n --help\tdisplays this screen"
      exit
			;;
	esac
	shift
done

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

arch=$(uname -m)
case "$arch" in

*) echo "Deploying OpenFaaS core services"
   composefile="docker-compose.yml"
   ;;
esac

docker-sdp stack deploy func -c $composefile
