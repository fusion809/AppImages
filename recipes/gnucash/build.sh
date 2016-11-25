#!/bin/bash

# Set up the AppDir
docker build .

ls AppDir

# Build the AppImage
APP=gnucash
ARCH=$(uname -m)
GNUCASH_VERSION=$(wget -q https://sourceforge.net/projects/gnucash/files/gnucash%20%28stable%29/ -O - | grep gnucash | grep "[0-9]" | grep "\.[0-9]" | head -n 1 | cut -d '"' -f 4 | cut -d ':' -f 1 | cut -d '/' -f 4 | sed 's/gnucash\-//g' | sed 's/\.tar\.bz2//g')
GLIBC_NEEDED=$(find . -type f -executable -exec strings {} \; | grep ^GLIBC_2 | sed s/GLIBC_//g | sort --version-sort | uniq | tail -n 1)
VERSION=${GNUCASH_VERSION}.glibc${GLIBC_NEEDED}
echo "VERSION is $VERSION"

if [[ "$ARCH" = "x86_64" ]] ; then
	APPIMAGE=$APP"-"$VERSION"-x86_64.AppImage"
fi
if [[ "$ARCH" = "i686" ]] ; then
	APPIMAGE=$APP"-"$VERSION"-i386.AppImage"
fi

mkdir -p out

rm -f out/*.AppImage || true

curl -sL "https://github.com/probonopd/AppImageKit/releases/download/6/AppImageAssistant_6-x86_64.AppImage" > AppImageAssistant
chmod a+x AppImageAssistant
./AppImageAssistant ./AppDir/ out/$APP"-"$VERSION"-"$ARCH".AppImage"
