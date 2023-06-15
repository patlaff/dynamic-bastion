env = "prd"
rg = "laff-ca-prd-rg"
vnet = "laff-ca-prd-vnet"

windows_vms = {
  testwindowsvm = {
    subnet_name  = "laff-ca-prd-sn"
    vm_size      = "Standard_B2s"
    disk_size_gb = "250"
    admin_username = "adminuser"
  }
}

linux_vms = {
  testlinuxvm = {
    subnet_name  = "laff-ca-prd-sn"
    vm_size      = "Standard_B2s"
    disk_size_gb = "250"
    admin_username = "adminuser"
  }
}
