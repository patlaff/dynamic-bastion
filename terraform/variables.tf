variable "env" {
  type = string
}

variable "rg" {
  type = string
}

variable "vnet" {
  type = string
}

variable "subnet" {
  type = string
}

variable "vms" {
  type = map(map(object({
    vm_size      = string
    disk_size_gb = string
  })))
}