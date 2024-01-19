resource "dns_a_record_set" "srv" {
  name = var.vm_name
  zone = "${var.vm_subenvx}.${var.vm_envx}.${var.vm_tld}."
  #addresses =   var.vm_address 
  addresses =   try(length(var.vm_address[0]), 0) > 0 ? var.vm_address : ["1.1.1.1"]
  ttl = 300
}

resource "random_integer" "fakeip" {
  min = 1
  max = 250
}

resource "dns_ptr_record" "ptr" {
  zone = "${var.reverse}."
  #name = "${element(split(".",var.vm_address[0]),3)}"
  name = try(length(var.vm_address[0]), 0) > 0 ? element(split(".",var.vm_address[0]),3) : random_integer.fakeip.result
  ptr = "${var.vm_name}.${var.vm_subenvx}.${var.vm_envx}.${var.vm_tld}."
  ttl = 300
}
