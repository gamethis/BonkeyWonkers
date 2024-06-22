resource "local_file" "file3" {
  content  = "I'm the best file, I'm File 3"
  filename = "${path.cwd}/file3.txt"
}

resource "local_file" "file2" {
  content  = "Well Hello There, I'm File 2"
  filename = "${path.cwd}/file2.txt"
}