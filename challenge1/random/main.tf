variable "resource_count" {
  default = 3
}
#Random String
resource "random_string" "resource_code" {
  count = "${var.resource_count}"
  length  = 3
  special = false
  upper   = false
  number  = false
}

output "resource_code" {
  value = "${random_string.resource_code.*.result}"
}