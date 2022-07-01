#--------------------------------------------------------------------------------------------------------------------
# AZURE PRIVATE DNS MODULE
#--------------------------------------------------------------------------------------------------------------------
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
data "azurerm_resource_group" "DNS_ResourceGroup" {
  name = var.resource_group_name
}

locals { 
  a_records     = var.a_records
  mx_records    = var.mx_records
  srv_records   = var.srv_records
  cname_records = var.cname_records
  txt_records   = var.txt_records
  ptr_records   = var.ptr_records
}

#--------------------------------------------------------------------------------------------------------------------
# Deploying the azure private dns zone
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_zone" "private_DNS_Zone" {
  name                = var.domain_name
  resource_group_name = var.resource_group_name
}

#--------------------------------------------------------------------------------------------------------------------
# Private Only DNS A Records
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_a_record" "a_records_private" {
  depends_on = [
    azurerm_private_dns_zone.private_DNS_Zone
  ]
  for_each = { for rs in local.a_records : rs.name => rs }

  resource_group_name = var.resource_group_name
  zone_name           = var.domain_name

  name    = each.value.name
  ttl     = each.value.ttl
  records = each.value.value
}

#--------------------------------------------------------------------------------------------------------------------
# Private ONLY DNS CNAME Records
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_cname_record" "cname_records_private" {
  depends_on = [
    azurerm_private_dns_zone.private_DNS_Zone
  ]
  for_each = { for rs in local.cname_records : rs.name => rs }

  resource_group_name = var.resource_group_name
  zone_name           = var.domain_name

  name   = each.value.name
  ttl    = each.value.ttl
  record = each.value.value
}

#--------------------------------------------------------------------------------------------------------------------
# Private ONLY DNS MX Records
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_mx_record" "mx_record_private" {
  depends_on = [
    azurerm_private_dns_zone.private_DNS_Zone
  ]
  for_each = { for rs in local.mx_records : rs.name => rs }

  resource_group_name = var.resource_group_name
  zone_name           = var.domain_name

  name = each.value.name
  ttl  = each.value.ttl

  record {
      preference = each.value.priority
      exchange   = each.value.value
  }
}

#--------------------------------------------------------------------------------------------------------------------
# Private ONLY DNS SRV Records
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_srv_record" "srv_records_private" {
  depends_on = [
    azurerm_private_dns_zone.private_DNS_Zone
  ]
  for_each = { for rs in local.srv_records : rs.name => rs }

  resource_group_name = var.resource_group_name 
  zone_name           = var.domain_name

  name = each.value.name
  ttl  = each.value.ttl

  record {
      priority = each.value.preference
      weight   = each.value.weight
      port     = each.value.port
      target   = each.value.value
  }
  
}

#--------------------------------------------------------------------------------------------------------------------
# Private ONLY DNS TXT Records
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_txt_record" "txt_records_private" {
  depends_on = [
    azurerm_private_dns_zone.private_DNS_Zone
  ]
  for_each = { for rs in local.txt_records : rs.name => rs}

  resource_group_name = var.resource_group_name 
  zone_name           = var.domain_name

  name = each.value.name
  ttl  = each.value.ttl

  dynamic "record"{
    for_each = each.value.value
    content {
      value = record.value
    }
  }
}

#--------------------------------------------------------------------------------------------------------------------
# Private DNS PTR Records
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_ptr_record" "ptr_records_private" {
  depends_on = [
    azurerm_private_dns_zone.private_DNS_Zone
  ]
  for_each = { for rs in local.ptr_records : rs.name => rs}

  zone_name           = var.domain_name  
  resource_group_name = var.resource_group_name 

  name                = each.value.name
  ttl                 = each.value.ttl
  records             = each.value.value
}
