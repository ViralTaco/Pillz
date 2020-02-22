#!/bin/sh

# Constants:
BUILD_NAME='Pillz'
PRODUCT_NAME='pillz'

BUILD_PATH="./Build/Products/Release/$BUILD_NAME"
PRODUCT_PATH="/usr/local/bin/$PRODUCT_NAME"

WORKSPACE="$BUILD_NAME.xcworkspace"
SCHEME='pilllog'

# Make sure to have root
if [ $EUID != 0 ]; then 
    echo 'You need root to run this script.'
    sudo "$0" "$@"
    exit $?
fi

# Compile:
echo 'Compiling...'
if xcodebuild -workspace $WORKSPACE -scheme $SCHEME -quiet; then
    echo 'Done.'
else # xcodebuild failed.
    echo 'Could not compile. Try building using Xcode'
fi

# Remove current install if it exists:
if [ -f $PRODUCT_PATH ]; then
    echo 'Removing previous version...'
    rm $PRODUCT_PATH ||: # rm .. or true (don't print error)
    echo 'Done.'
fi # [ -f $PRODUCT_PATH ]
    
# Copy built product to the bin folder
echo "Copying $PRODUCT_NAME to $PRODUCT_PATH..."
if cp $BUILD_PATH $PRODUCT_PATH; then
    echo 'Done.'
    echo "Application installed. You can run it by typing $PRODUCT_NAME"
else # Couldn't copy file. 
    echo 'Failed.'
    echo 'Could not complete installation.'
fi

exit $?
