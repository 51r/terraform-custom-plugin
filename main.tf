terraform {
  required_providers {
    extip = {
      source = "local.providers/peter/extip"
    }
  }
}

data "extip" "external_ip" {}

output "external_ip" {
  value = data.extip.external_ip.ipaddress
}
