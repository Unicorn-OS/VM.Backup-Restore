source var
source setting.sh

cd $bac_dir/${name}
sudo rsync -av --progress --append-verify ${name}.compressed.qcow2 /var/lib/libvirt/images/${name}.qcow2
sudo rsync -av --progress --append-verify ${name}_VARS.fd /var/lib/libvirt/qemu/nvram/
cd xml
virsh define original.xml
