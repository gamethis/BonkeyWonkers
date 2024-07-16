module "service_config" {
  source = ".//modules/helloworld"
  user   = "NONAME"
}

resource "local_file" "helloworld" {
  content  = module.service_config.service
  filename = "${path.module}/HelloWorld.txt"
}
