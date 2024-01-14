resource "dns_a_record_set" "srv" {
  name = var.vm_name
  zone = "${var.vm_subenvx}.${var.vm_envx}.${var.vm_tld}."
  addresses =   var.vm_address 
  ttl = 300
}

resource "dns_ptr_record" "ptr" {
  zone = "${var.reverse}."
  name = "${element(split(".",var.vm_address[0]),3)}"
  ptr = "${var.vm_name}.${var.vm_subenvx}.${var.vm_envx}.${var.vm_tld}."
  ttl = 300
}
