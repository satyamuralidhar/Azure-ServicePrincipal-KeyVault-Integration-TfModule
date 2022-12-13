
data "azuread_client_config" "config" {}
data "azurerm_subscription" "mysubscrip" {}

module "serviceprincipal" {
  source                            = "./servicePrincipal"
  ad_service_principal_name         = var.ad_service_principal_name
  service_principal_role_assignment = var.service_principal_role_assignment

}
/* spn secret keys creation */
resource "time_rotating" "time" {
  rotation_days = 7
}

resource "azuread_service_principal_password" "myspnkey" {
  service_principal_id = module.serviceprincipal.service_principle_object_id
  rotate_when_changed = {
    rotation = time_rotating.time.id
  }
}

/* resource group creation */

resource "azurerm_resource_group" "myresourcegroup" {
  name     = var.key_vault_resource_group_name
  location = var.key_vault_location_name
}


module "keyvault" {
  source                        = "./keyVault"
  keyvault_name                 = format("%s-%s", var.key_vault_location_name, "mykeyvault")
  key_vault_resource_group_name = var.key_vault_resource_group_name
  key_vault_location_name       = var.key_vault_location_name
  keyvault_tenant_id            = module.keyvault.keyvault_tenant_id
  keyvault_object_id            = module.keyvault.keyvault_object_id
  soft_delete_retention_days    = var.soft_delete_retention_days
  key_vault_sku_name            = var.key_vault_sku_name
}


resource "azurerm_key_vault_secret" "spnsecret" {
  name         = module.serviceprincipal.service_principle_object_id
  value        = azuread_service_principal_password.myspnkey.value
  key_vault_id = module.keyvault.keyvault_id
}


