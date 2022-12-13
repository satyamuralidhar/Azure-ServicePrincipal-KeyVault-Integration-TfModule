output "keyvault_tenant_id" {
  value = data.azuread_client_config.config.tenant_id
}

output "keyvault_object_id" {
  value = data.azuread_client_config.config.object_id
}

output "keyvault_id" {
    value = azurerm_key_vault.mykv.id
}