#!/usr/bin/bash
source my.var.sh
source setting.sh

bacDir=${backup_dir}/${vmName}/${snapshotLabel}
snapImg=${vmName}{$snapshotLabel}.compressed.qcow2

pre(){
  mkdir -p $bacDir/xml $bacDir/nvram
}

inDir(){
  cd $bacDir
}

compressDiskImage(){
  if [ ! -f ${bacDir}/${snapImg} ]; then
    sudo qemu-img convert -p -O qcow2 -c /var/lib/libvirt/images/${vmName}.qcow2 ${bacDir}/${snapImg}
    echo "Backed up disk image"
  fi
}

bacNvram(){
# if (type == "VFIO"){
  sudo rsync -av --progress --append-verify /var/lib/libvirt/qemu/nvram/${vmName}_VARS.fd ${bacDir}/nvram/
#}
}

bacXml(){
  # Some distros require sudo, others don't: Make this Dynamic!
  sudo virsh dumpxml ${vmName} > ${bacDir}/xml/original.xml
}

ownership(){
  sudo chown -R $USER:$USER ${bacDir}
}

checksum(){
  inDir
  cfv -Crrt md5
}

pre
compressDiskImage
bacNvram
bacXml
ownership
checksum
cd -
