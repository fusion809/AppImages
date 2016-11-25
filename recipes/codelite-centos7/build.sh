#!/bin/bash

# Set up the AppDir
docker build .

ls /AppDir

# Build the AppImage
APP=codelite
ARCH=$(uname -m)
CODELITE_VERSION=$(curl -sL https://github.com/eranif/codelite/releases | grep ".tar.gz" | head -n 1 | cut -d '"' -f 2 | cut -d '/' -f 5 | sed 's|.tar.gz||g')
GLIBC_NEEDED=$(find . -type f -executable -exec strings {} \; | grep ^GLIBC_2 | sed s/GLIBC_//g | sort --version-sort | uniq | tail -n 1)
VERSION=${CODELITE_VERSION}.glibc${GLIBC_NEEDED}
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
