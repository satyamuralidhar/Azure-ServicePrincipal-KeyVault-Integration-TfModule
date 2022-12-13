/* keyvault outputs */

output "keyvault_object_id" {
  value = module.keyvault.keyvault_object_id
}
output "keyvault_tenant_id" {
  value = module.keyvault.keyvault_tenant_id
}

output "key_vault_id" {
  value = module.keyvault.keyvault_id
}

//service principal outputs

output "service_principle_application_id" {
  value = module.serviceprincipal.service_principle_application_id
}
output "service_principle_object_id" {
  value = module.serviceprincipal.service_principle_object_id
}
output "service_principle_subscription_id" {
  value = module.serviceprincipal.service_principle_object_id
}

