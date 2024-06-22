output "service" {
  value = templatefile(
    "${path.module}/templates/Dockerfile.tftpl",
    {
      source_file = var.source_file
    }
  )
}
