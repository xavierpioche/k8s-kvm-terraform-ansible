output "domain_name" {
       value = var.vms_domain[0]
}

output "dns_server" {
	value = element(module.vm[0].vm_address[0],0)
}
