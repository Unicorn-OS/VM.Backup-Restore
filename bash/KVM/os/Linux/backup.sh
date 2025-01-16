source my.var
source setting.sh

mkdir -p $bac_dir

cd $bac_dir/${name}

mkdir -p xml nvram

compress_disk_image(){
  
#DEL:  sudo mv /var/lib/libvirt/images/${name}.qcow2 . 

  if [ ! -f ${name}.compressed.qcow2 ]; then
    sudo qemu-img convert -p -O qcow2 -c /var/lib/libvirt/images/${name}.qcow2 ${name}.compressed.qcow2
  fi

  # Restore
#DEL:  sudo mv ${name}.qcow2 /var/lib/libvirt/images/
}

# if (type == "VFIO"){
sudo rsync -av --progress --append-verify /var/lib/libvirt/qemu/nvram/${name}_VARS.fd nvram/  
#}

virsh dumpxml ${name} > xml/original.xml

sudo cfv -Crr
