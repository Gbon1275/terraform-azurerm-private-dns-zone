output "Private_DNS_Zone" {
  value = try(azurerm_private_dns_zone.private_DNS_Zone.name, "")
  description = "Name of Zone that has just been deployed"
}