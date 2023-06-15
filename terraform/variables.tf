variable "env" {
  type = string
}

variable "rg" {
  type = string
}

variable "vnet" {
  type = string
}

variable "windows_vms" {
  type = map(object({
    subnet_name  = string
    vm_size      = string
    disk_size_gb = string
  }))
}

variable "linux_vms" {
  type = map(object({
    subnet_name  = string
    vm_size      = string
    disk_size_gb = string
  }))
}