variable "vm_count" {
  description = "Количество виртуальных машин"
  type        = number
  default     = 2
}

variable "vm_cores" {
  description = "Количество CPU"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Объем RAM"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Размер диска"
  type        = number
  default     = 20
}