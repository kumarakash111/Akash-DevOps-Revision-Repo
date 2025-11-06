data "azurerm_subnet" "datasubnet" {
  for_each             = var.compute
  name                 = each.value.subnets[0].name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "datapip" {
  for_each            = var.compute
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_network_interface" "datanic" {
  for_each            = var.compute
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}
