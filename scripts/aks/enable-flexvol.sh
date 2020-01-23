#Deploy flexvol into the cluster
#(https://github.com/Azure/kubernetes-keyvault-flexvol)
kubectl create -f https://raw.githubusercontent.com/Azure/kubernetes-keyvault-flexvol/master/deployment/kv-flexvol-installer.yaml

#User managed identity resource id and key vault (you don't need to change since we are sharing)
umi="/subscriptions/67db0cb5-d026-4e61-9c32-5d98c5df9058/resourcegroups/teamResources/providers/Microsoft.ManagedIdentity/userAssignedIdentities/k8s-flexvol"
keyvault='WA8KSKeyVault'
#Enable the user managed identity in cluster - replace values with the MC_ rg and the vmss object
noderesourcegroup='MC_xxxx_xxxxx_northeurope'
nodepoolvmss='aks-nodepool1-xxxxx-vmss'

#Assign identity to the vmss 
az vmss identity assign -g $noderesourcegroup -n $nodepoolvmss --identities $umi


#################################
#############
#Already done 
az identity create -g teamResources -n k8s-flexvol 
# set policy to access keys in your Key Vault
az keyvault set-policy -n $keyvault --key-permissions get --spn c8ebe526-b662-48a3-ad60-cc6290e9aeed -g teamResources
# set policy to access secrets in your Key Vault
az keyvault set-policy -n $keyvault --secret-permissions get --spn c8ebe526-b662-48a3-ad60-cc6290e9aeed -g teamResources
# set policy to access certs in your Key Vault
az keyvault set-policy -n $keyvault --certificate-permissions get --spn c8ebe526-b662-48a3-ad60-cc6290e9aeed -g teamResources

 