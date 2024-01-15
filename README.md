# k8s-kvm-terraform-ansible
install a multi-master/ multi-worker k8s cluster on kvm vm with terraform and ansible

Notes: 

Add your user in libvirt group:
```sh
sudo usermod -a -G libvirt <loginname>
``` 
Modify and uncomment parameters in libvirtd config files:
```sh
$ grep -i "unix_sock_group" /etc/libvirt/libvirtd.conf
unix_sock_group = "libvirt"

$ grep -i "unix_sock_rw_perms" /etc/libvirt/libvirtd.conf
unix_sock_rw_perms = "0770"

$ sudo grep -i "security_driver" /etc/libvirt/qemu.conf
security_driver = "none"

$ sudo systemctl restart libvirtd
```

Create the pools (kvmpool01 and default) with your user (non-root):
```sh
mkdir /pool/kvmpool01
virsh pool-define-as kvmpool01 dir - - - - "/pool/kvmpool01"
virsh pool-build kvmpool01
virsh pool-start kvmpool01
virsh pool-autostart kvmpool01
```


