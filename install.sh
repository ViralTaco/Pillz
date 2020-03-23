#!/bin/bash

function does_app_exist() {
    hash $@ >/dev/null 2>&1
}

function puts() {
    for line in "$@"; do
        printf "$line\n"
    done
}

# Constants:
BUILD_NAME='Pillz'
PRODUCT_NAME='pillz'

BUILD_PATH="./Build/Products/Release/$BUILD_NAME"
PRODUCT_PATH="/usr/local/bin/$PRODUCT_NAME"

WORKSPACE="$BUILD_NAME.xcworkspace"
SCHEME='pilllog'

# Make sure to have root
if (( $EUID != 0 )); then 
    puts "You need root to run this script."
    sudo "$0"
    exit $?
fi

if ! does_app_exist xcodebuild; then
    puts "Error: Couldn't find xcodebuild." 
    puts "You need Xcode installed to run this script."
    puts "You can download Xcode here: https://apps.apple.com/us/app/xcode/id497799835"
    exit $?
fi

puts "Compiling..."
if [[ -f $PRODUCT_PATH ]]; then
    puts "Already compiled. Skipping..."
elif xcodebuild -workspace $WORKSPACE -scheme $SCHEME -quiet; then
    puts "Done."
else # xcodebuild failed.
    puts "Could not compile. Try building using Xcode"
    exit $?
fi

# Remove current install if it exists:
if [[ -f $PRODUCT_PATH ]]; then
    puts "Removing previous version..."
    rm $PRODUCT_PATH ||: # rm .. or true (don't print error)
    puts "Done."
fi # [[ -f $PRODUCT_PATH ]]
    
# Copy built product to the bin folder
puts "Copying $PRODUCT_NAME to $PRODUCT_PATH..."
if cp $BUILD_PATH $PRODUCT_PATH; then
    puts "Done." "Application installed. You can run it by typing $PRODUCT_NAME" 
else # Couldn't copy file. 
    puts "Failed." "Could not copy $PRODUCT_NAME to $PRDODUCT_PATH."
fi

exit $?
