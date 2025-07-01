import os
import azure.functions as func
from azure.identity import DefaultAzureCredential
from azure.mgmt.keyvault import KeyVaultManagementClient
from azure.mgmt.keyvault.models import VaultCreateOrUpdateParameters, Sku, SkuName, VaultProperties, AccessPolicyEntry, Permissions

def main(name: str) -> str:
    credential = DefaultAzureCredential()
    subscription_id = os.environ["AZURE_SUBSCRIPTION_ID"]
    resource_group = os.environ["RESOURCE_GROUP"]
    location = os.environ.get("LOCATION", "eastus")

    client = KeyVaultManagementClient(credential, subscription_id)

    vault_name = f"{name}-kv"
    parameters = VaultCreateOrUpdateParameters(
        location=location,
        properties=VaultProperties(
            tenant_id=os.environ["AZURE_TENANT_ID"],
            sku=Sku(name=SkuName.standard),
            access_policies=[],  # Add user/service access if needed
            enabled_for_deployment=True,
            enabled_for_disk_encryption=True,
            enabled_for_template_deployment=True
        )
    )

    result = client.vaults.begin_create_or_update(resource_group, vault_name, parameters).result()
    return f"KeyVault {vault_name} created"