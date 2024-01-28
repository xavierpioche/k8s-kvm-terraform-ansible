lbservername=$(terraform -chdir=../../terraform/kvm-lbs output -json information | jq -c -r '.[0]."'0'".vm_name' | awk -F'[\"]' '{ print $2 }')

lbserveraddress=$(terraform -chdir=../../terraform/kvm-lbs output lb_server | sed -e 's/\"//g')

 

echo "${lbservername} ansible_host=${lbserveraddress} ansible_user=${LOGNAME}"
