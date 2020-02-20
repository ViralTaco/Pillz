#!/bin/sh

# Make sure this file has chmod +x before running.
if [ $USER != 'root' ]; then 
  echo 'Insufficient priviledges to run the install script.'
else

  xcodebuold -project ./Pillz.xcodeproj -scheme pilllog
  rm /usr/local/bin/pillz
  cp ./Build/Products/Release/Pillz /usr/local/bin/pillz
  
  if [ $? -eq 0 ]; then
    echo 'Application installed. You can run it by typing pillz'
  else
    echo 'Could not complete installation. Makes sure to run as root.'
  fi
  
  exit $?
fi
