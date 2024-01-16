dnsservername=$(terraform -chdir=../../terraform/kvm-dns output -json information | jq -c -r '.[0]."'0'".vm_name' | awk -F'[\"]' '{ print $2 }')

dnsserveraddress=$(terraform -chdir=../../terraform/kvm-dns output dns_server | sed -e 's/\"//g')

 

echo "${dnsservername} ansible_host=${dnsserveraddress} ansible_user=${LOGNAME}"
