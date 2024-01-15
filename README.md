# k8s-kvm-terraform-ansible
install a multi-master/ multi-worker k8s cluster on kvm vm with terraform and ansible

Notes: 

Add your user in libvirt group:
```sh
sudo usermod -a -G libvirt <loginname>
``` 

Create the pools with your user (non-root):
```sh
mkdir /pool/kvmpool1
virsh pool-define-as kvmpool1 dir - - - - "/pool/kvmpool1"
virsh pool-build kvmpool1
virsh pool-start kvmpool1
virsh pool-autostart kvmpool1
```


