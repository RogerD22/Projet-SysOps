variable "ami_ubuntu" {
  description = "l'AMI de Ubuntu 22.04"
  type        = string
}

variable "instance_type" {
  description = "le type d'instance pour les tests"
  type        = string
}
variable "key_name" {
  description = "clée SSH pour se connecter à l'instance"
  type        = string
}
