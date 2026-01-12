variable "vm_count" {
  description = "Количество виртуальных машин"
  type        = number
}

variable "vm_cores" {
  description = "Количество CPU"
  type        = number
}

variable "vm_memory" {
  description = "Объем RAM"
  type        = number
}

variable "disk_size" {
  description = "Размер диска"
  type        = number
}