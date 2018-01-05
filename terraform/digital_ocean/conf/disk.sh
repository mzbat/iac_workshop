#!/bin/bash


DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then
        mkfs.ext4 ${DEVICE}
fi
mkdir -p /data
echo '${DEVICE} /data ext4 defaults 0 0' >> /etc/fstab
mount /data
