resource "local_file" "file1" {
  content  = "Yo ho ho, I'm File 1"
  filename = "${path.cwd}/file1.txt"
}

resource "local_file" "file2" {
  content  = "Well Hello There, I'm File 2"
  filename = "${path.cwd}/file2.txt"
}
