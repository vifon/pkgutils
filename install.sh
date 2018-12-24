#!/bin/bash

set -o errexit -o nounset -o pipefail

PREFIX="${PREFIX:-$HOME/local}"

git remote add upstream git://crux.nu/tools/pkgutils.git || true
git fetch upstream
VERSION=$(git describe --tags | sed -e "s/^pkgutils-//")

git clean -xfd

make PREFIX="$PREFIX" install

fakeroot pkgmk -d
./pre-install
pkgadd -f "pkgutils#$VERSION.pkg.tar.gz"
