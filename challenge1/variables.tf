variable "project_id" {
  description = "project id"
  default = ""
}

variable "region" {
  description = "region"
  default = "us-central1"
}
/*
variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "min_node" {
  description = "minimum node for Autoscaling"
}

variable "max_node" {
  description = "maximum node for Autoscaling"
}
*/

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "node_location" {
  description = "zone zode location"
  type        = list(string)
  default = ["us-central1-a", "us-central1-b"]
}

variable "machine_type" {
  description = "machine type for nodes"
  default = "n1-standard-1"
}

# variable "max_pods" {
#   description = "maximum pods per node"
# }
/*
variable "disk_size_gb" {
  description = "disk size for nodes"
}

variable "disk_type" {
  description = "disk types for nodes"
}
*/

variable "cluster" {
  default = "cluster-name"
}
variable "web-app" {
  type        = string
  description = "Name of application"
  default     = "web-app"
}
variable "zone" {
  default = "us-central1-a"
}
variable "docker-image" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "impavithra/flask-app:v2"
}
variable "ATC_USERNAME" {
  default = "PAVITHRA"
}

variable "ATC_PASSWORD" {
  default = "1234@#abc"
}