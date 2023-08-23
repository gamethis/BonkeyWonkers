module service_config {
    source = "../modules/helloworld"
    source_file = "helloworld.py"
}

resource "local_file" "dockerfile" {
    content  = module.service_config.service
    filename = "${path.module}/Dockerfile"
}