output "service" {
  value = templatefile(
    "${path.module}/templates/HelloWorld.tftpl",
    {
      user = var.user
    }
  )
}
