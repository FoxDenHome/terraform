variable zone {
    type = object({
        id = string
        zone = string
    })
}

variable server {
    type = string
    default = "arcticfox.doridian.net"
}
