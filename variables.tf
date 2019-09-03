variable "environment" {
  description = "Logical name of the environment, will be used as prefix and for tagging."
  type        = string
}

variable "name_suffix" {
  description = "Logical name to append to the log group name."
  type        = string
}

variable "create_log_group" {
  description = "Indicates if the log group needs to be created by the module."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

