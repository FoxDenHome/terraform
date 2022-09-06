locals {
  repositores = {
    wsvpn = {
      description = "VPN over WebSocket and WebTransport"
      required_checks = [
        "Errcheck",
        "Imports",
        "Sec",
        "Shadow",
        "StaticCheck",
        "test-darwin",
        "test-linux",
        "test-windows",
      ]
    }
    water = {
      description = "A simple TUN/TAP library written in native Go."
      required_checks = [
        "Errcheck",
        "Imports",
        "Sec",
        "Shadow",
        "StaticCheck",
        "test-darwin",
        "test-linux",
        "test-windows",
      ]
    }
    website = {

    }
    jsip-wsvpn = {

    }
    wsvpn-js = {

    }
    query-finder = {

    }
    healthcheckd = {

    }
    factorio-fox-todo = {

    }
    slimfat = {

    }
    rd60xx = {

    }
    tracething = {

    }
    terraform-provider-hexonet = {
      description = "Terraform provider for Hexonet API"
    }
    homebrew-tap = {

    }
    jsip = {
      description = "TCP/UDP/ICMP/IP/Ethernet stack in pure TypeScript."
    }
    RigolLib = {
      description = ".NET Interface for Rigol devices (currently Oscilloscopes)"
    }
    LuaJS = {
      description = "Lua VM running in Javascript (using emscripten)"
    }
    hammerspoon-config = {

    }
    HomeAssistantMQTT = {

    }
    MuxyProxy = {
      description = "Multi-Protocol reverse proxy detecting a client's protocol intelligently for dynamic forwarding"
    }
    os-config = {
      description = "Various OS configuration/customization files"
    }
    deffs = {

    }
    j4210u-app = {

    }
    libMSRx05 = {

    }

    # Forks
    picotcp = {
      description       = "PicoTCP is a free TCP/IP stack implementation"
      branch_protection = false
    }

    factorio-docker = {
      description       = "Factorio headless server in a Docker container"
      branch_protection = false
    }

    factorio-pause-commands = {
      description       = "Factorio mod to add pause and unpause commands"
      branch_protection = false
    }

    NoTouchScreenFirmware = {
      description       = "Stripped down version of BIGTREETECH-TouchScreenFirmware which only supports ST7920 emulation (Marlin Mode)"
      branch_protection = false
    }
  }
}

# tfi() { terraform import "module.repo[\"$1\"].github_repository.repo" "$1"; terraform import "module.repo[\"$1\"].github_branch.main" "$1:main"; terraform import "module.repo[\"$1\"].github_branch_protection.main" "$1:main"; }

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
