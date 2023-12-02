locals {
  archived_repositores = {
    AccountsClient                = {}
    BarAPI                        = {}
    BungeeFailover                = {}
    ChatLinkRouter                = {}
    ChatLinkRouter_Java           = {}
    DependencyBuilder             = {}
    DiscordLink                   = {}
    FBoxLiHTTPd                   = {}
    FoxBukkitBadge                = {}
    FoxBukkitChatLink             = {}
    FoxBukkitCheckoff             = {}
    FoxBukkitScoreboard           = {}
    FoxBukkitSlackLink            = {}
    FoxBungee                     = {}
    FoxelBoxAPI                   = {}
    FoxelBoxAndroid               = {}
    FoxelBoxChatForge             = {}
    FoxelBoxClient                = {}
    FoxelLog                      = {}
    LogBlock                      = {}
    LowSecurity                   = {}
    MultiBukkit                   = {}
    Organization                  = {}
    RavenBukkit                   = {}
    RedisDependency               = {}
    Remote-Entities               = {}
    RestartIfEmpty                = {}
    SpigotPatcher                 = {}
    StaticWorld                   = {}
    TechnicServerPlatform         = {}
    TechnicSolder                 = {}
    ThreadingDependency           = {}
    VoidGenerator                 = {}
    collectivization-maven-plugin = {}
    dynmap                        = {}
    iOS                           = {}
    zOLD_BungeeAntiProxy          = {}
    zOLD_BungeeReloader           = {}
    zOLD_FoxBukkit                = {}
    zOLD_MCSecurityManager        = {}
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
