resource "local_file" "file3" {
  content  = "I'm the best file, I'm File 3"
  filename = "${path.cwd}/file3.txt"
}
