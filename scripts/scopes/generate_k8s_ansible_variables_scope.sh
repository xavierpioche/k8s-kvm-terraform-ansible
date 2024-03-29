##
## set proxy here if necessary
PROXY=$(grep PROXY= ../variables | head -1 | awk -F= '{ print $2 }')
#PROXY="N"
PODSCIDR="10.200.0.0/16"
SVCSCIDR="10.201.0.0/16"
ENDPOINT="kubernetes"
##
echo "! do you need a proxy for your vms? PROXY var=${PROXY}"
##
CURR=`pwd`
cd ../../k8s-dns/terraform/current/
REVIP=$(terraform output dns_server | sed -e "s/\"//g" | awk -F. '{ print $3"."$2"."$1 }')
DOMAIN=$(terraform output domain_name | sed -e "s/\"//g")

cd ${CURR}

OUTDNS="k8s-dns_ansible_variables.yaml.j2.scope"
OUTLB="k8s-lbs_ansible_variables.yaml.j2.scope"
OUT="k8s-cluster_ansible_variables.yaml.j2.scope"
echo "variablescopes:" > ${OUT}
echo "- {" >> ${OUT}

grep "," k8s-cluster_hosts.j2.scope >> ${OUT}
grep "," k8s-dns_hosts.j2.scope >> ${OUT}
grep "," k8s-lbs_hosts.j2.scope >> ${OUT}

echo "        reverseip: ${REVIP}," >> ${OUT}
echo "        dns_domain: ${DOMAIN}," >> ${OUT}
if [ ${#PROXY} -eq 1 ]; then PROXY=N ; fi
echo "        proxy: ${PROXY}," >> ${OUT}
echo "        endpoint: ${ENDPOINT}," >> ${OUT}
echo "        podscidr: ${PODSCIDR}," >> ${OUT}
echo "        svcscidr: ${SVCSCIDR}," >> ${OUT}
echo "        ansible_user: ${LOGNAME}" >> ${OUT}
echo "}" >> ${OUT}

cp ${OUT} ${OUTLB}
cp ${OUT} ${OUTDNS}
