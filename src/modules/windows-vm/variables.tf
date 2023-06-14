variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet" {
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