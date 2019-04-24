#!/bin/sh

if [ -z "$1" ];
then
  echo Specify a virtual-machine name.
  exit 1
fi

NAME=$1
RAM=$2
VCPU=$3
SIZE=$4

sudo virt-install \
--name $NAME \
--ram $RAM \
--disk path=/var/lib/libvirt/images/$1.qcow2,size=$SIZE \
--vcpus $VCPU \
--virt-type kvm \
--os-type linux \
--os-variant linux \
--network bridge:br0,model=virtio \
--graphics none \
--console pty,target_type=serial \
--location 'http://cdn-fastly.deb.debian.org/debian/dists/testing/main/installer-amd64/' \
--initrd-inject=buster_preseed.cfg \
--extra-args='console=tty0 console=ttyS0,115200n8 auto=true hostname="${1}" domain="kvm-image-prepare.devopsdex.com"'
