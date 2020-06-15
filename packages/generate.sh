#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git

# Generate all BBB packages and update their dependencies

set -euo pipefail
cd "$(dirname "${0}")"
. ./utils.sh

msg() {
	echo -e '-> \e[31m'"${1}"'\e[0m'
}

# Prepare sources and checkouts
msg "Generating sources"
./sources/generate.sh
msg "Checking out sources"
./checkouts/checkout-from-nix.sh
./checkouts/fetch-static.sh

# Scala libraries
if oneIsChanged sources/bigbluebutton/* bbb-common-message/*; then
	msg "Building bbb-common-message"
	bbb-common-message/generate.sh
fi
if oneIsChanged sources/bigbluebutton/* bbb-fsesl-client/*.nix; then
	msg "Building bbb-fsesl-client"
	bbb-fsesl-client/generate.sh
fi
if oneIsChanged sources/bigbluebutton/* bbb-common-message/*.nix bbb-common-web/*.nix; then
	msg "Building bbb-common-web"
	bbb-common-web/generate.sh
fi
