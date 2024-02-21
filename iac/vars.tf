variable "project" {
  type    = string
  default = "fyp-open-data-hackathon"
}

variable "region" {
  type    = string
  default = "asia-east1"
}

variable "region2" {
  type    = string
  default = "asia-northeast1"
}
variable "zone" {
  type    = string
  default = "asia-east1-a"
}

variable "credentials" {
  type    = string
  default = "../secretes/fyp-open-data-hackathon-ab6e5b59ab5d.json"
}

variable "list_services"{
  type = list(string)
  default = [
    "apikeys.googleapis.com"
    ]
}