#!/bin/bash
docker build .
APP=transmission
VERSION=$(wget -q https://github.com/transmission/transmission-releases -O - | grep "tar.xz" | cut -d '"' -f 4 | tail -n 1 | cut -d '/' -f 6 | sed 's/[a-z-]//g' | sed 's/\.\.//g')
GLIBC_NEEDED=$(find . -type f -executable -exec strings {} \; | grep ^GLIBC_2 | sed s/GLIBC_//g | sort --version-sort | uniq | tail -n 1)
VERSION=${VERSION}.glibc$GLIBC_NEEDED
ARCH=$(uname -m)
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
