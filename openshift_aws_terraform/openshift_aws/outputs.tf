output "master_domain" {
  value = format("https://console.%s.%s:8443/", var.domain, var.tld)
}

output "bastion_ip_address" {
  value = aws_eip.bastion_eip.public_ip
}

output "admin_password" {
  value = random_string.admin_password.result
}
