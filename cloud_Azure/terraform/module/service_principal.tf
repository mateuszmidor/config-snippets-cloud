data "azuread_client_config" "current" {}

# Creates Service Principal for pre-existing "Kentik NSG Flow Exporter" app, so the app can access flow logs in Azure cloud
resource "azuread_service_principal" "kentik_nsg_flow_exporter" {
  application_id               = "a20ce222-63c0-46db-86d5-58551eeee89f" # pre-existing app ID
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

  feature_tags {
    enterprise = true # show the app in AzurePortal under Enterprise Applications
  }
}