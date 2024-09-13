variable "region" {
  description = "The region of resources"
  type        = string
  default     = "asia-southeast1" # Singapore
}
variable "zone" {
  type = string
}
variable "project_id" {
  type = string
}

variable "github_org" {
  type = string
}
variable "github_token" {
  type        = string
  description = "need for github auth"
}
