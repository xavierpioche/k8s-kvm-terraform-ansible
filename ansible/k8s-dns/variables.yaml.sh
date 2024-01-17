dnsforwarder=$(grep "nameserver" /etc/resolv.conf | head -1 | awk '{ print $2 }')
domainname=$(terraform -chdir=../../terraform/kvm-dns output domain_name | sed -e 's/\"//g')
dnsservername=$(terraform -chdir=../../terraform/kvm-dns output -json information | jq -c -r '.[0]."'0'".vm_name' | awk -F'[\"]' '{ print $2 }')
dnsserveraddress=$(terraform -chdir=../../terraform/kvm-dns output dns_server | sed -e 's/\"//g')
reverseip=$(terraform -chdir=../../terraform/kvm-dns output dns_server | sed -e 's/\"//g'| awk -F. '{ print $3"."$2"."$1 }')
proxy=$(grep PROXY= ../../scripts/scopes/generate_k8s_ansible_variables_scope.sh | awk -F= '{ print $2 }')

echo "dnsforwarder: ${dnsforwarder}"
echo "domainname: ${domainname}"
echo "dnsservername: ${dnsservername}"
echo "dnsserveraddress: ${dnsserveraddress}" 
echo "reverseip: ${reverseip}"
echo "proxy: ${proxy}"
echo "no_proxy: localhost"
