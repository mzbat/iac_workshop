#!/bin/bash

DEVICE=`lsblk | grep sd | cut -d" " -f1`
DEVICE_FS=`blkid -o value -s TYPE /dev/${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then
        mkfs.ext4 /dev/${DEVICE}
fi
if [ ! -d /data ] 
then  
  echo "Make /data directory"
  mkdir -p /data
fi
# fix this so it only adds one time
echo '/dev/${DEVICE} /data ext4 defaults 0 0' >> /etc/fstab
# this only works if fstab is correct.
mount /data
