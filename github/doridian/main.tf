locals {
  repositores = {
    wsvpn = {
      description = "VPN over WebSocket and WebTransport"
      required_checks = [
        "lint (macos-latest)",
        "lint (ubuntu-latest)",
        "lint (windows-latest)",
        "test (macos-latest)",
        "test (ubuntu-latest)",
      ]
    }
    water = {
      description = "A simple TUN/TAP library written in native Go."
      required_checks = [
        "lint (macos-latest)",
        "lint (ubuntu-latest)",
        "lint (windows-latest)",
        "test (macos-latest)",
        "test (ubuntu-latest)",
      ]
    }
    website           = {}
    jsip-wsvpn        = {}
    wsvpn-js          = {}
    query-finder      = {}
    healthcheckd      = {}
    factorio-fox-todo = {}
    slimfat           = {}
    rd60xx            = {}
    tracething        = {}
    terraform-provider-hexonet = {
      description = "Terraform provider for Hexonet API"
    }
    homebrew-tap = {}
    jsip = {
      description = "TCP/UDP/ICMP/IP/Ethernet stack in pure TypeScript."
    }
    RigolLib = {
      description = ".NET Interface for Rigol devices (currently Oscilloscopes)"
    }
    LuaJS = {
      description = "Lua VM running in Javascript (using emscripten)"
    }
    hammerspoon-config = {}
    HomeAssistantMQTT  = {}
    MuxyProxy = {
      description = "Multi-Protocol reverse proxy detecting a client's protocol intelligently for dynamic forwarding"
    }
    os-config = {
      description = "Various OS configuration/customization files"
    }
    deffs         = {}
    j4210u-app    = {}
    libMSRx05     = {}
    streamdeckpi  = {}
    go-streamdeck = {}
    go-haws       = {}
    gitbackup     = {}

    BambuProfiles = {
      description = "Profiles for Bambu Lab printers"
    }
    OpenBambuAPI = {
      description = "Bambu API docs"
    }
    BambuRE = {
      visibility = "private"
    }

    flippertools = {
      visibility = "private"
    }

    fakeuinput = {}

    TeslaLogger = {}

    fakerfs = {
      description = "FUSE filesystem that can overlay fake files on top of a real filesystem"
    }

    # Forks
    apt-mirror-docker = {
      description       = "Up to date apt-mirror script, containerized for mirroring + serving."
      branch_protection = false
    }
    terraform-provider-cloudns = {
      description       = "Terraform provider for ClouDNS"
      branch_protection = false
    }
    noVNC = {
      description       = "VNC client web application"
      branch_protection = false
    }
    qmk_firmware = {
      description       = "Open-source keyboard firmware for Atmel AVR and Arm USB families"
      branch_protection = false
    },
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
    driftctl = {
      description       = "Detect, track and alert on infrastructure drift"
      branch_protection = false
    }
    sevenroom-scraper = {
      description       = "I really like food."
      branch_protection = false
    }
    gopacket = {
      description       = "Provides packet processing capabilities for Go"
      branch_protection = false
    }

    BambuSource2Raw = {
      description       = "Get raw webcam stream of BambuLabX1 3D printer"
      branch_protection = false
    }
  }
}

# tfi() { terraform import "module.repo[\"$1\"].github_repository.repo" "$1"; terraform import "module.repo[\"$1\"].github_branch_protection.main" "$1:main"; }

module "repo" {
  for_each = local.repositores

  source = "../modules/repo"
  repository = merge({
    name         = each.key
    description  = ""
    homepage_url = ""

    visibility = "public"

    required_checks   = []
    branch_protection = true

    pages = null
  }, each.value)
}
