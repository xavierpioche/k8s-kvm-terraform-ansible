dnsserver=$(terraform -chdir="../../../k8s-dns/terraform/current/" output -json dns_server)
#dnsserver=$(terraform -chdir="../kvm-dns" output -json dns_server | sed -e 's/\"//g')

echo "dns_server = $dnsserver"

triple=$(terraform -chdir="../../../k8s-dns/terraform/current/" output -json domain_name| sed -e 's/\"//g'| sed -e 's/\./:/g')

echo ${triple}| while IFS=: read A B C
do

echo "common_vm_envx = \"$B\""
echo "common_vm_subenvx = \"$A\""
echo "common_vm_tld = \"$C\""

done

reverse=$(echo $dnsserver | sed -e 's/\"//g' | awk -F. '{ print $3"."$2"."$1 }')

echo "reverse = \"$reverse.in-addr.arpa\""
