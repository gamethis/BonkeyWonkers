output "service" {
  value = templatefile(
    "${path.module}/templates/Dockerfile.tpl",
    {
      source_file = var.source_file
    }
  )
}
