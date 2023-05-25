variable "vpc" {
  type = object({
    vpc_name = string
    cidr_block = string
    igw_name = string
    public_av_zone = list(string)
    private_av_zone = list(string)
    db_av_zone = list(string)
    public_cidr = list(string)
    private_cidr = list(string)
    db_cidr = list(string)
    subnet_public_name = list(string)
    subnet_private_name = list(string)
    subnet_db_name = list(string)
    nat_name = string
    elastic_ip_allocation_id = string
    public_rt_name = string
    private_rt_name = string
    s3_endpoint_name = string
    })
}



variable "skillup_required_tags" {
  description = "Skillup required tags"
  type        = map(string)
  default = {
    "GBL_CLASS_0" = "SERVICE"
    "GBL_CLASS_1" = "TEST"
  }
}

