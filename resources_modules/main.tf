resource "azurerm_resource_group" "practice-rg" {
  for_each = var.compute
  name     = each.value.resource_group_name
  location = each.value.location
}

resource "azurerm_virtual_network" "practice-vnet" {
  depends_on          = [azurerm_resource_group.practice-rg]
  for_each            = var.compute
  name                = each.value.vnet_name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }
  }
}
resource "azurerm_public_ip" "practice_pip" {
  depends_on          = [azurerm_resource_group.practice-rg]
  for_each            = var.compute
  name                = each.value.pip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_network_interface" "practice_nic" {
  for_each            = var.compute
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.datasubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.datapip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "vmname" {
  for_each                        = var.compute
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.vm_size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids = [
    data.azurerm_network_interface.datanic[each.key].id
  ]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}





