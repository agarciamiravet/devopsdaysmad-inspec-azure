terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devopsdays"
    storage_account_name = "stordevopsdaysmad"
    container_name       = "terraform-backend"
    key                  = "terraform-devopsdays.tfstate"
  }
}