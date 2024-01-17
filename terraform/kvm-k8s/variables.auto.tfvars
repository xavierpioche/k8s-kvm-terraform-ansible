vms_name = [ "k8sma1" , "k8sma2", "k8sma3" , "k8swk1", "k8swk2", "k8swk3" ]
vms_domain = [ "k8s.xprd.local", "k8s.xprd.local", "k8s.xprd.local", "k8s.xprd.local", "k8s.xprd.local", "k8s.xprd.local" ]
vms_ip_type = [ "dhcp", "dhcp", "dhcp", "dhcp", "dhcp", "dhcp" ]
vms_memoryMB = [ 8192, 4096, 4096, 4096, 4096, 4096 ]
vms_cpu = [ 2 , 2 , 2 , 2 , 2 , 2 ]
vms_pool = [ "kvmpool01" , "kvmpool01", "kvmpool01", "kvmpool01", "kvmpool01", "kvmpool01" ]
vms_disk = [ 20 , 20 , 20 , 30, 30, 30 ]

common_vm_subenvx = "k8s"
common_vm_envx = "xprd"
common_vm_tld = "local"

dns_server = "192.168.122.192"
reverse = "122.168.192.in-addr.arpa"

ansible_user="xavier"
image_path="/home/xavier/Downloads"
image_name="jammy-server-cloudimg-amd64.img"
