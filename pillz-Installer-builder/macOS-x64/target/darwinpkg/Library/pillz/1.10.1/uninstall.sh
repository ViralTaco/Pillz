#!/bin/bash

#Generate application uninstallers for macOS.

#Parameters
DATE=`date +%Y-%m-%d`
TIME=`date +%H:%M:%S`
LOG_PREFIX="[$DATE $TIME]"

#Functions
log_info() { 
    echo "${LOG_PREFIX}[INFO]" $1 
}
log_warn() { 
    echo "${LOG_PREFIX}[WARN]" $1 
}
log_error() { 
    echo "${LOG_PREFIX}[ERROR]" $1 
}

#Check running user
(( $EUID != 0 )) && \
    echo "You need root to run this script." && \
    exit $(sudo "$0" "$@")


echo "Welcome to Application Uninstaller"
echo "The following packages will be REMOVED:"
echo "  pillz-1.10.1"

read -p "Continue [y/n]?"
[[ $REPLY = [yY] ]] || { echo "Cancelled."; exit 1; }


#Need to replace these with install preparation script
VERSION=1.10.1
PRODUCT=pillz

echo "Uninstalling..."
# remove link to shorcut file
find "/usr/local/bin/" -name "pillz-1.10.1" | xargs rm
if (( "$?" == 0 )); then
    echo "[1/3] [DONE] Successfully deleted shortcut links"
else
    echo "[1/3] [ERROR] Could not delete shortcut links" >&2
fi

#forget from pkgutil
pkgutil --forget "org.$PRODUCT.$VERSION" &>/dev/null
if (( "$?" == 0 )); then
    echo "[2/3] [DONE] Successfully deleted application informations"
else
    echo "[2/3] [ERROR] Could not delete application informations" >&2
fi

#remove application source distribution
[[ -e "/Library/${PRODUCT}/${VERSION}" ]] && rm -r "/Library/${PRODUCT}/${VERSION}"
if (( "$?" == 0 )); then
    echo "[3/3] [DONE] Successfully deleted application"
else
    echo "[3/3] [ERROR] Could not delete application" >&2
fi

echo "Success."
exit 0
