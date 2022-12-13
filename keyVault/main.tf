
/*key vault creation and interagte spn secrets into keyvault */

# resource "azurerm_resource_group" "myrsg" {
#   name     = var.key_vault_location_name
#   location = var.key_vault_location_name
# }

resource "azurerm_key_vault" "mykv" {
  name                       = var.keyvault_name
  location                   = var.key_vault_location_name
  resource_group_name        = var.key_vault_resource_group_name
  soft_delete_retention_days = var.soft_delete_retention_days
  tenant_id                  = data.azuread_client_config.config.tenant_id
  sku_name                   = var.key_vault_sku_name

  access_policy {
    tenant_id = data.azuread_client_config.config.tenant_id
    object_id = data.azuread_client_config.config.object_id

    key_permissions = [
      "Get",
      "List",
      "Purge"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Purge"
    ]

    storage_permissions = [
      "Get",
      "Purge"
    ]
    }
}
