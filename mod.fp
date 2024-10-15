mod "opsgenie" {
  title         = "Opsgenie"
  description   = "Run pipelines to supercharge your Opsgenie workflows using Flowpipe."
  color         = "#2684FF"
  documentation = file("./README.md")
  icon          = "/images/mods/turbot/opsgenie.svg"
  categories    = ["library", "incident response"]

  opengraph {
    title       = "Opsgenie Mod for Flowpipe"
    description = "Run pipelines to supercharge your Opsgenie workflows using Flowpipe."
    image       = "/images/mods/turbot/opsgenie-social-graphic.png"
  }

  require {
    flowpipe {
      min_version = "1.0.0"
    }
  }
}
