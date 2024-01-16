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
### create the dns
- Start with terraform/kvm-dns (terraform init, plan, apply, refresh)
- then go to ansible/k8s-dns, modify the hosts file and the variable file, 
- then execute command ansible-playbook init.yml
### create the k8s cluster
- start with terraform/kvm-k8s, modify variables.auto.tfvars with the correct ip for dns_server and reverse then :
```sh
cd terraform/kvm-k8s
terraform init
terraform plan && terraform apply ; sleep 5 ; terraform refresh ; terraform plan && terraform apply
cd ../../scripts/
./go_kvm_disk_resize 
./go_ansible_config_k8s_cluster
cd ../ansible/k8s-cluster
ansible-playbook main.yml
```

## Lab
As any lab, it's possible to crash you k8s cluster. In this case, if you want to recreate, just:
```sh
cd terraform/kvm-k8s
terraform destroy
terraform plan && terraform apply ; sleep 5 ; terraform refresh ; terraform plan && terraform apply
cd ../../scripts/
./go_kvm_disk_resize
./go_ansible_config_k8S_cluster
cd ../ansible/k8s-cluster
ansible-playbook main.yml
```



