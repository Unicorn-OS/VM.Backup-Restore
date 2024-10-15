name=ubuntu24.10

mkdir -p xml nvram

sudo mv /var/lib/libvirt/images/${name}.qcow2 . 
sudo rsync -av --progress --append-verify /var/lib/libvirt/qemu/nvram/${name}_VARS.fd nvram/  

if [ ! -f ${name}.compressed.qcow2 ]; then
  sudo qemu-img convert -p -O qcow2 -c ${name}.qcow2 ${name}.compressed.qcow2
fi

virsh dumpxml ${name} > xml/original.xml

sudo cfv -Crr
