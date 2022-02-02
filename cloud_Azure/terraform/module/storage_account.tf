# Creates one storage account per resource group to store flow logs
# StorageAccounts are mapped 1:1 to resource_group_names and this fact is used to get storage account id for given resource group name 
resource "azurerm_storage_account" "logs_storage_account" {
  count = length(var.resource_group_names)
  
  name                     = "${terraform.workspace}${tostring(count.index)}" # constrainst: Azure-wide unique, up to 24 alphanum letters
  resource_group_name      = var.resource_group_names[count.index]
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    app = "kentik_flow_log_exporter"
  }
}