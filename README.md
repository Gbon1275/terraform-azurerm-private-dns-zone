# Azure Private DNS Module
![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)
![Terraform Version](https://img.shields.io/badge/Terraform%20Version-latest-blue)
![Version](https://img.shields.io/badge/Version-0.0.9-green)

##  Description
This terraform module will create a private dns zone and populate it with records 

## Features

- Will create a new or update an existing azure private dns zone.

## Requirements

To use this module you will need to have terraform installed.
## Examples
```
"domain_name" = "Example.com"

"subscription_id" = "0000000000000000000"

"a_records" [
   {
      name    = "www"
      ttl     = 3600
      value   = ["192.0.2.56"]
      
    },
    {
      name    = "www"
      ttl     = 3600
      value   = ["192.0.2.56"]
    } 
]

"mx_records" {
   [
      name    = "mail"
      ttl     = 3600
      priority = 10
      value   = "mail1"
    },
    {
      name    = "@"
      ttl     = 3600
      prority = 20
      value   = "mail1"
    }
]

"cname_records" {
    {
      name    = "example"
      ttl     = 3600
      value   = "example.com"
    },
    {
      name    = "example"
      ttl     = 3600
      value   = "example.com"
    },
}

"srv_records" [
    {
      name    = "_sip._tcp"
      ttl     = 3600
      preference = 10
      weight  = 60
      port    = 5060
      value   = "Sip1"
    },
    {
      name    = "_sip._tcp"
      ttl     = 3600
      preference = 10
      weight  = 60
      port    = 5060
      value   = "Sip1"
    }
]

"txt_records" [
    {
      name    = ""
      ttl     = 3600
      value   = ["service.something.com"]
      
    },
    {
      name    = ""
      ttl     = 3600
      value   = ["service.something.com" ]
    }
]

"ptr_records" [
    {
       name  = ""
       ttl   = 300
       value = "test.example.com"
        
    },
    {
       name  = ""
       ttl   = 300
       value = "test.example.com"
    }
]

```
## Arguments
| Name | Type | Description |
| --- | --- | --- |
|  `resource_group`       | `string` | Where the resources will be held. |
|  `DNS Zone Name`          | `string` | Name of the domain space you are building |
|  `a_records`       | `object` | List of a records to be created in the zone |
|  `mx_records`       | `object` | List of mx records to be created in the zone |
|  `cname_records`       | `object` | List of cname records to be created in the zone |
|  `srv_records`       | `object` | List of srv records to be created in the zone |
|  `txt_records`       | `object` | List of txt records to be created in the zone |
|  `ptr_records`       | `object` | List of ptr records to be created in the zone |
