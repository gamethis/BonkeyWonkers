variable "source_file" {
  type        = string
  description = "Path of the source go file to run in Docker."
}

variable "commands" {
  type = list(string)
  default = ["whoami", "pwd", "ls -ltra"]
}