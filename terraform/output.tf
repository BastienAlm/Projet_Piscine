output "backend-ip" {
  value       = "${aws_instance.web.*.public_ip}"
  description = "PublicIP address details"
}