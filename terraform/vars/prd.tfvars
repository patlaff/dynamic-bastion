env = "prd"

rg = "laff-ca-prd-rg"

vnet = "laff-ca-prd-vnet"

subnet = "AzureBastionSubnet"

vms = {
  windows = {
    test_windows_vm = {
      vm_size      = "Standard_B2s"
      disk_size_gb = "250"
    }
  }
  linux = {
    test_linux_vm = {
      vm_size      = "Standard_B2s"
      disk_size_gb = "250"
    }
  }
}
    