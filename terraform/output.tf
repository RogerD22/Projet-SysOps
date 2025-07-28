output "public_ip" {
  description = "IP publique de l'instance Ubuntu"
  value       = aws_eip.vm_eip.public_ip
}