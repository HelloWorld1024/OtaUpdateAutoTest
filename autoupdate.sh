#!/system/bin/sh
echo "Starting to update ..."
BASE_VERSION="181023"
VERSION=$(getprop "ro.timotech.ota.version")
BASE_NEW="/sdcard/base_new.zip"
NEW_BASE="/sdcard/new_base.zip"
UPDATE=""
PACKAGE_NAME=""
if [ ! -f "$BASE_NEW" ];then
 echo "no base to new package..."
 exit 0
fi

if [ ! -f "$NEW_BASE" ];then
  echo "no new to base package"
  exit 0
fi

echo "copy ota pacakge form /sdcard/  to /cache/"
#cp /sdcard/update.zip  /cache/
if [  "$VERSION" = "$BASE_VERSION" ];then
    echo "current is base version"
    UPDATE="/sdcard/base_new.zip"
    PACKAGE_NAME="base_new.zip"
else 
    echo "current is new version"
    UPDATE="/sdcard/new_base.zip"
    PACKAGE_NAME="new_base.zip"
fi

echo "update pacakge path:$UPDATE"
cp $UPDATE /cache/

echo "base version=$BASE_VERSION"
echo "package name=$PACKAGE_NAME"
echo "--update_package=/cache/$PACKAGE_NAME">/cache/recovery/command
echo "version = $VERSION"
cat /cache/recovery/command
############count update times################
COUNT_TXT="/sdcard/count.txt"
RECORD_TXT="/sdcard/record.txt"
echo "update" >>$COUNT_TXT
echo $(grep -o "update" $COUNT_TXT|wc -l)>$RECORD_TXT


##############################################
reboot recovery
