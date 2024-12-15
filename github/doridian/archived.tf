locals {
  archived_repositores = {
    AmplifiLink          = {},
    CoreLogic            = {},
    CorsairLinkPlusPlus  = {},
    DracoChat            = {},
    FoxEEEControl        = {},
    FoxdenNetworkScripts = {},
    FoxyMC_Classic       = {},
    GCodeWebGL           = {},
    HackCPU              = {},
    HackmudIRC           = {},
    JumpAndRoll          = {},
    KeyboardControl      = {},
    QuickRecovery        = {},
    SPAuthProxy          = {},
    SPMisc               = {},
    SSLChainLib          = {},
    SSLChainWeb          = {},
    ShaderBox            = {},
    ShaderDemo           = {},
    SteamMobileLib       = {},
    XVManageNode         = {},
    XVManagePanel        = {},
    Yiffcraft            = {},
    bcachefs-scripts     = {},
    cfworker-doh         = {},
    channeler            = {},
    chat-finder = {
      visibility = "private",
    },
    docker-minico2           = {},
    docker-pihole            = {},
    docker-seafile           = {},
    evldns                   = {},
    fhem-InfluxDBLog         = {},
    gitrunner                = {},
    hashtopolis-agent-python = {},
    jumpme                   = {},
    ledbadge                 = {},
    ledmgr                   = {},
    mikronode                = {},
    minit                    = {},
    netgen                   = {},
    netmap                   = {},
    nettest                  = {},
    node-dnsd                = {},
    node-mount               = {},
    node-unshare             = {},
    ntp-clock-projector      = {},
    opendkame                = {},
    pingshell                = {},
    presencegetter           = {},
    puppeteer-page-proxy     = {},
    rfcat-mqtt               = {},
    sdr-misc                 = {},
    slow-uboot-flasher       = {},
    tesla-proxy              = {},
    tetris-os                = {},
    tuya-prometheus          = {},
    vfmgr                    = {},
    wireworld_cuda           = {},
    BambuSource2Raw = {
      description = "Get raw webcam stream of BambuLabX1 3D printer"
    }
    NoTouchScreenFirmware = {
      description = "Stripped down version of BIGTREETECH-TouchScreenFirmware which only supports ST7920 emulation (Marlin Mode)"
    }
    RigolLib = {
      description = ".NET Interface for Rigol devices (currently Oscilloscopes)"
    }
    TeslaLogger  = {}
    healthcheckd = {}
    j4210u-app   = {}
    rd60xx       = {}
    sdparm = {
      description = "Fork of the official git-svn mirror for sdparm, access SCSI parameters (mode+VPD pages)"
    }
    floppy-linux           = {}
    mister-linux           = {}
    tiny-floppy-bootloader = {}
    MCAdmin                = {}
  }
}

# tfimp() { tofu import "module.archived_repo[\"$1\"].github_repository.repo" "$1"; }

module "archived_repo" {
  source = "../modules/repo/archived"

  for_each = local.archived_repositores

  repository = merge({
    name = each.key

    visibility = "public"
  }, each.value)
}
