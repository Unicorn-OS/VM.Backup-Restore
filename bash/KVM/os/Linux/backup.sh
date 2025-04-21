source my.var.sh
source setting.sh

bacDir=${bac_dir}/${vmName}/${snapshotLabel}

pre(){
  mkdir -p $bacDir/xml $backDir/nvram
}

inDir(){
  cd $bacDir
}

compressDiskImage(){
  inDir()
  if [ ! -f ${vmName}.compressed.qcow2 ]; then
    sudo qemu-img convert -p -O qcow2 -c /var/lib/libvirt/images/${vmName}.qcow2 ${vmName}.compressed.qcow2
  fi
}

# if (type == "VFIO"){
sudo rsync -av --progress --append-verify /var/lib/libvirt/qemu/nvram/${vmName}_VARS.fd nvram/  
#}

bacXml(){
  inDir()
  virsh dumpxml ${vmName} > xml/original.xml
}

checksum(){
  sudo cfv -Crr
}

pre()
compressDiskImage()
checksum()
cd -
