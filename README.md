# k8s-kvm-terraform-ansible
install a multi-master/ multi-worker k8s cluster on kvm vm with terraform and ansible

## installation notes 

Create a ssh key if not exists:
```sh
ssh-keygen
```
Install packages:
```sh
sudo apt install qemu-kvm
sudo apt install libvirt-clients
sudo apt install virt-manager
sudo apt install mkisofs
sudo snap install terraform –classic
sudo apt install ansible
```
Get ubuntu cloud image:
```sh
mkdir ~/Download
cd ~/Download
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
```

Add your user in libvirt group:
```sh
sudo usermod -a -G libvirt ${LOGNAME}
``` 

Modify or uncomment parameters in libvirtd config files:
```sh
$ if [ ! -f /etc/libvirt/libvirtd.conf.orig ]; then sudo cp /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.orig; fi

$ echo 'unix_sock_group = "libvirt"' | sudo tee -a /etc/libvirt/libvirtd.conf
$ grep -i "unix_sock_group" /etc/libvirt/libvirtd.conf
unix_sock_group = "libvirt"

$ echo 'unix_sock_rw_perms = "0770"' | sudo tee -a /etc/libvirt/libvirtd.conf
$ grep -i "unix_sock_rw_perms" /etc/libvirt/libvirtd.conf
unix_sock_rw_perms = "0770"

$ if [ ! -f /etc/libvirt/qemu.conf.orig ]; then sudo cp /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.orig; fi

$ echo 'security_driver = "none"' | sudo tee -a /etc/libvirt/qemu.conf
$ sudo grep -i "security_driver" /etc/libvirt/qemu.conf
security_driver = "none"

$ sudo systemctl restart libvirtd
```

Create the pools (kvmpool01 and default) with your user (non-root):
```sh
mkdir /pool/kvmpool01 /pool/default
virsh pool-define-as kvmpool01 dir - - - - "/pool/kvmpool01"
virsh pool-build kvmpool01
virsh pool-start kvmpool01
virsh pool-autostart kvmpool01

virsh pool-define-as default dir - - - - "/pool/default"
virsh pool-build default
virsh pool-start default
virsh pool-autostart default
```

## Running
### create the dns and the lbs
```sh
./1_go_dns_lbs
```
### create the k8s cluster
```sh
./2_go_k8s
```

## Lab
As any lab, it's possible to crash you k8s cluster. In this case, if you want to recreate, just:
```sh
./9_go_destroy 
```



