resource "local_file" "file1" {
  content  = "Yo ho ho, I'm File 1"
  filename = "${path.cwd}/file1.txt"
}