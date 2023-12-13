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

  param "tags" {
    type        = list(string)
    description = "Tags of the alert."
    optional    = true
  }

  param "entity" {
    type        = string
    description = "Entity field of the alert that is generally used to specify which domain the alert is related to."
    optional    = true
  }

  param "priority" {
    type        = string
    description = "Priority level of the alert."
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
