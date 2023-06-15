variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "disk_size_gb" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "key_vault" {
  type = object({
    id = string
  })
}

variable "common_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}