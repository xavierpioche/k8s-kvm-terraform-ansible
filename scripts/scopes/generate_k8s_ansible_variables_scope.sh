
OUTDNS="k8s-dns_ansible_variables.yaml.j2.scope"
OUTLB="k8s-lbs_ansible_variables.yaml.j2.scope"
OUT="k8s-cluster_ansible_variables.yaml.j2.scope"
echo "variablescopes:" > ${OUT}
echo "- {" >> ${OUT}

grep "," k8s-cluster_hosts.j2.scope >> ${OUT}
grep "," k8s-dns_hosts.j2.scope >> ${OUT}
grep "," k8s-lbs_hosts.j2.scope >> ${OUT}

echo "        reverseip: 122.168.192," >> ${OUT}
echo "        dns_domain: k8s.xprd.local," >> ${OUT}
echo "        ansible_user: xavier" >> ${OUT}
echo "}" >> ${OUT}

cp ${OUT} ${OUTLB}
cp ${OUT} ${OUTDNS}
