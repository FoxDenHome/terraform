variable "account_id" {
    type = string    
}

variable "domain" {
    type = string
}

variable "mx" {
    type = bool
}

variable spf_additions {
    type = string
}

variable redirect_all_to_main {
    type = bool
}

variable redirect_www_to_root {
    type = bool
}

variable add_www_cname {
    type = bool
}

variable main_domain {
    type = string
}
