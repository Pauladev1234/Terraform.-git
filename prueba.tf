resource "azurerm_resource_group" "resource_group_paula" {
  name     = "terraform-rg"
  location = "West Europe"
}

resource "azurerm_static_site" "paula_static_site" {
  name                = "pauladevops_static_site"
  resource_group_name = azurerm_resource_group.paula.name
  location            = azurerm_resource_group.paula.location
}

resource "azurerm_dns_cname_record" "paula_dns" {
  name                = "my-domain"
  zone_name           = "contoso.com"
  resource_group_name = azurerm_resource_group.paula.name
  ttl                 = 300
  record              = azurerm_static_site.paula.default_host_name
}

resource "azurerm_static_site_custom_domain" "paula_custom_domain" {
  static_site_id  = azurerm_static_site.paula.id
  domain_name     = "${azurerm_dns_cname_record.paula.name}.${azurerm_dns_cname_record.example.zone_name}"
  validation_type = "cname-delegation"
}