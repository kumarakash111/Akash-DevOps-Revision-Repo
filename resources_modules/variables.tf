variable "compute" {
  type = map(object({
    resource_group_name             = string
    location                        = string
    vnet_name                       = string
    address_space                   = list(string)
    pip_name                        = string
    allocation_method               = string
    sku                             = string
    nic_name                        = string
    vm_name                         = string
    vm_size                         = string
    admin_username                  = string
    admin_password                  = string
    disable_password_authentication = bool

    os_disk = object(
      {
        caching              = string
        storage_account_type = string
      }
    )

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    subnets = list(object({
      name             = string
      address_prefixes = list(string)
    }))
  }))
}
