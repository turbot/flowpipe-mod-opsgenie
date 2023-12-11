pipeline "create_alert" {
  title       = "Create Alert"
  description = "Creates an alert."

  tags = {
    type = "featured"
  }

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "message" {
    type        = string
    description = "Message of the alert"
  }

  param "alias" {
    type        = string
    description = "Client-defined identifier of the alert, this is also the key element of Alert De-Duplication."
    optional    = true
  }

  param "description" {
    type        = string
    description = "Description field of the alert that is generally used to provide detailed information about the alert."
    optional    = true
  }

  param "responders" {
    type = list(object({
      id       = string
      name     = string
      username = string
      type     = string
    }))
    description = "Teams, users, escalations, and schedules that the alert will be routed to send notifications. Type field is mandatory for each item, where possible values are team, user, escalation, and schedule. If the API Key belongs to a team integration, this field will be overwritten with the owner team. Either id or name of each responder should be provided."
    optional    = true
  }

  param "visible_to" {
    type = list(object({
      id       = string
      name     = string
      username = string
      type     = string
    }))
    description = "Teams and users that the alert will become visible to without sending any notification. Type field is mandatory for each item, where possible values are team and user. In addition to the type field, either id or name should be given for teams and either id or username should be given for users."
    optional    = true
  }

  param "actions" {
    type        = list(string)
    description = "Custom actions that will be available for the alert."
    optional    = true
  }

  param "tags" {
    type        = list(string)
    description = "Tags of the alert."
    optional    = true
  }

  param "details" {
    type        = map(string)
    description = "Map of key-value pairs to use as custom properties of the alert."
    optional    = true
  }

  param "entity" {
    type        = string
    description = "Entity field of the alert that is generally used to specify which domain the alert is related to."
    optional    = true
  }

  param "source" {
    type        = string
    description = "Source field of the alert. Default value is the IP address of the incoming request."
    optional    = true
  }

  param "priority" {
    type        = string
    description = "Priority level of the alert."
    optional    = true
  }

  param "user" {
    type        = string
    description = "Display name of the request owner."
    optional    = true
  }

  param "note" {
    type        = string
    description = "Additional note that will be added while creating the alert."
    optional    = true
  }

  step "http" "create_alert" {
    method = "post"
    url    = "https://api.opsgenie.com/v2/alerts"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${credential.opsgenie[param.cred].alert_api_key}"
    }

    request_body = jsonencode({ for name, value in param : local.create_alert_query_params[name] => value if contains(keys(local.create_alert_query_params), name) && value != null })
  }

  output "request" {
    value = step.http.create_alert.response_body
  }
}
