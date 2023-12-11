locals {
  create_alert_query_params = {
    actions     = "actions"
    alias       = "alias"
    description = "description"
    details     = "details"
    entity      = "entity"
    message     = "message"
    note        = "note"
    priority    = "priority"
    responders  = "responders"
    source      = "source"
    tags        = "tags"
    user        = "user"
    visible_to  = "visibleTo"
  }

  create_incident_query_params = {
    description         = "description"
    details             = "details"
    impacted_services   = "impactedServices"
    message             = "message"
    note                = "note"
    notify_stakeholders = "notifyStakeholders"
    priority            = "priority"
    responders          = "responders"
    status_page_entry   = "statusPageEntry"
    tags                = "tags"
  }
}

# Common descriptions
locals {
  cred_param_description = "Name for credentials to use. If not provided, the default credentials will be used."
}
