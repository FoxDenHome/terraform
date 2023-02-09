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
    hashtopolis-docker       = {},
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
    shutdownd                = {},
    slow-uboot-flasher       = {},
    tesla-proxy              = {},
    tetris-os                = {},
    tuya-prometheus          = {},
    vfmgr                    = {},
    wireworld_cuda           = {},
  }
}

# tfi() { terraform import "module.archived_repo[\"$1\"].github_repository.repo" "$1"; }

module "archived_repo" {
  source = "../modules/repo/archived"

  for_each = local.archived_repositores

  repository = merge({
    name = each.key

    visibility = "public"
  }, each.value)
}
