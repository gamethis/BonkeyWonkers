variable "user" {
  type        = string
  description = "Name of user."
}

variable "list" {
  type        = list(string)
  default     = ["pickleball", "poker", "dogs"]
}
