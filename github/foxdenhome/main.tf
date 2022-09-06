locals {
  repositores = {
    nodered = {
      branch_protection = false
    }
    homeassistant = {
      branch_protection = false
    }
    NixieClockDori = {

    }
    LCDify = {

    }
    terraform = {

    }
    e621dumper = {

    }
    redfox = {

    }
    docker = {

    }
    router = {
      branch_protection = false
    }
    CC1101Duino = {

    }
    ntp = {

    }
    islandfox = {

    }
    nas = {

    }
    "3dprinter-config" = {

    }
    desk-control = {

    }
    backup = {

    }
    scripts = {

    }
    sshkeys = {

    }
  }
}

module "repo" {
  for_each = local.repositores

  source = "../modules/repo"
  repository = merge({
    name              = each.key
    description       = ""
    visibility        = "public"
    required_checks   = []
    branch_protection = true
  }, each.value)
}
