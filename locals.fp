locals {
  create_alert_query_params = {
    alias       = "alias"
    description = "description"
    entity      = "entity"
    message     = "message"
    note        = "note"
    priority    = "priority"
    tags        = "tags"
  }

  create_incident_query_params = {
    description         = "description"
    message             = "message"
    note                = "note"
    notify_stakeholders = "notifyStakeholders"
    priority            = "priority"
    tags                = "tags"
  }
}

# Common descriptions
locals {
  conn_param_description = "Name for connections to use. If not provided, the default connection will be used."
}
