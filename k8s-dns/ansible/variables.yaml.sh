dnsforwarder=$(grep "nameserver" /etc/resolv.conf | head -1 | awk '{ print $2 }')
domainname=$(terraform -chdir=../terraform/current/ output domain_name | sed -e 's/\"//g')
dnsservername=$(terraform -chdir=../terraform/current/ output -json information | jq -c -r '.[0]."'0'".vm_name' | awk -F'[\"]' '{ print $2 }')
dnsserveraddress=$(terraform -chdir=../terraform/current/ output dns_server | sed -e 's/\"//g')
reverseip=$(terraform -chdir=../terraform/current/ output dns_server | sed -e 's/\"//g'| awk -F. '{ print $3"."$2"."$1 }')
proxy=$(grep PROXY= ../../scripts/variables | head -1 | awk -F= '{ print $2 }')

echo "dnsforwarder: ${dnsforwarder}"
echo "domainname: ${domainname}"
echo "dnsservername: ${dnsservername}"
echo "dnsserveraddress: ${dnsserveraddress}" 
echo "reverseip: ${reverseip}"
echo "proxy: ${proxy}"
echo "no_proxy: localhost"
