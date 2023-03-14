#Definimos el resource group a crear
resource "azurerm_resource_group" "resource_group_paula" {
  name     = "terraform-rg"
  location = "West Europe"
}

#Definimos el service plan a crear
resource "azurerm_app_service_plan" "app_service_paula" {
  name                = "pauladevops_serviceplan"
  location            = azurerm_resource_group.paula.location
  resource_group_name = azurerm_resource_group.paula.name

  sku {
    tier = "Free"
    size = "F1"
  }
}


resource "azurerm_app_service" "app_service_terraform" {
  name                = "pauladevops-terraform"
  location            = azurerm_resource_group.paula.location
  resource_group_name = azurerm_resource_group.paula.name
  app_service_plan_id = azurerm_app_service_plan.app_service_paula.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "MySql"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}