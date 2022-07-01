variable "subscription_id" {
    type = string
    description = "ID of Azure Suscription"
}

variable "resource_group_name" {
    type = string
    description = "Name of the resource group where the resourtce will be held"
}

variable "domain_name" {
    type = string
    description = "Name of Domain you want to use"
}

variable "a_records" {
    type = list(object({
        name = string
        ttl = number
        value = list(string)
    }))
    description = "List of A records."
}

variable "mx_records" {
    type = list(object({
        name = string
        priority = number
        ttl = number
        value = string
    }))
    description = "List of MX Records."
}

variable "cname_records" {
    type = list(object({
        name = string
        ttl = number
        value = string
    }))
    description = "List of CNAME records."
}

variable "srv_records" {
    type = list(object({
        name = string
        preference = number
        weight = number
        port = number
        ttl = number
        value = string
    }))
    description = "List of SRV records"
}

variable "txt_records" {
    type = list(object({
        name = string
        ttl = number
        value = list(string)
    }))
    description = "List of TXT records"
}


variable "ptr_records" {
    type  = list(object({
        name = string
        ttl = number
        value = string
    }))
    description = "List of PTR records."
}