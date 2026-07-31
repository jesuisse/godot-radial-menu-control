#!/bin/bash
############################################################################################
# Prepares addon for distribution
############################################################################################

VERSION=$(cat VERSION)
SOURCEREPO=/godot-radial-menu-control
DIST=dist
NAME=radial-menu-control
CURDIR=$(pwd)

# Some safety checks
if [ ! -f VERSION ]; then
    echo "No VERSION file. Script expects to run in the project source directory."
    exit 1
fi

if [ ! -d addons/RadialMenu ]; then
    echo "No addons/RadialMenu folder. Script expects to run in the project source directory."
    exit 1
fi

if [ -f $DIST/$NAME-$VERSION.zip ]; then
    echo "zip file for $VERSION exists already. Have you forgotten to change the version?"
    echo "aborting. delete zip file and repeat to proceed anyway."
    exit 2
fi

if [ -d $DIST ]; then
    # Clean distribution directory
    if [ -d $DIST/addons ]; then
        rm -r -f $DIST/addons
    fi
else
    mkdir $DIST
fi

cp -r addons $DIST
cp README.md $DIST/addons/RadialMenu
cd $DIST
zip -r $NAME-$VERSION.zip addons
cd $CURDIR
rm -r -f $DIST/addons





