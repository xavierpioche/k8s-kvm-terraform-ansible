
OUT="k8s-cluster_ansible_variables.yaml.j2.scope"
echo "variablescopes:" > ${OUT}
echo "- {" >> ${OUT}

grep "," k8s-cluster_hosts.j2.scope >> ${OUT}
grep "," k8s-dns_hosts.j2.scope >> ${OUT}
grep "," k8s-lbs_hosts.j2.scope >> ${OUT}

echo "        dns_domain: k8S.xprd.local," >> ${OUT}
echo "        ansible_user: xavier" >> ${OUT}
echo "}" >> ${OUT}
