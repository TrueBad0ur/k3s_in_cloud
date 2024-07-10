variable "image_flavor" {
  type    = string
  default = "debian-12-202407091435.git7d768af5"
}


variable "compute_flavor" {
  type    = string
  default = "STD2-4-4"
}


variable "key_pair_name" {
  type    = string
  default = "key"
}


variable "availability_zone_name" {
  type    = string
  default = "GZ1"
}
