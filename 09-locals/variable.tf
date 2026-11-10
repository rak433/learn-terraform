variable "ami_id" {
  type    = string
  default = "ami-0055977a6e828a4f4"
  description = "AMI ID of the instance"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
  description = "Instance type of ec2"

  validation {
    # Returns true if var.instance_type is one of the items in the list
    condition     = contains(["t3.micro", "t3.small", "t3.medium", "t3.large"], var.instance_type)
    error_message = "The instance_type must be one of t3.micro, t3.small, t3.medium or t3.large."
  }
}

variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

# variable "ec2_tags" {
#    default = {
#        Name = "roboshop-dev"
#    }
# }

variable "cidr" {
    type = list
    default = ["0.0.0.0/0"]
}

variable "from_port" {
    type = number
    default = 0
}