compute = {
  compute1 = {
    resource_group_name             = "rg-compute-1"
    location                        = "East US"
    vnet_name                       = "vnet-compute-1"
    address_space                   = ["10.0.0.0/16"]
    pip_name                        = "pip-compute-1"
    allocation_method               = "Static"
    sku                             = "Standard"
    nic_name                        = "nic-compute-1"
    vm_name                         = "vm-compute-1"
    vm_size                         = "Standard_D2s_v4"
    admin_username                  = "adminuser"
    admin_password                  = "P@ssw0rd1234"
    disable_password_authentication = false
    subnets = [{
      address_prefixes = ["10.0.0.0/24"]
      name             = "generic_subnet-1"
    }]

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  }
}
