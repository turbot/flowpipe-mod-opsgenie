pipeline "create_incident" {
  title       = "Create Incident"
  description = "Creates an incident."

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
    description = "Message of the incident."
  }

  param "description" {
    type        = string
    description = "Description field of the incident."
    optional    = true
  }

  param "responders" {
    type = list(object({
      type = string
    }))
    description = "Teams/users that the incident is routed to via notifications."
    optional    = true
  }

  param "tags" {
    type        = list(string)
    description = "Tags of the incident."
    optional    = true
  }

  param "details" {
    type        = map(string)
    description = "Map of key-value pairs to use as custom properties of the incident."
    optional    = true
  }

  param "priority" {
    type        = string
    description = "Priority level of the incident."
    optional    = true
  }

  param "note" {
    type        = string
    description = "Additional note that is added while creating the incident."
    optional    = true
  }

  param "impacted_services" {
    type        = list(string)
    description = "Services on which the incident will be created."
    optional    = true
  }

  param "status_page_entry" {
    type = object({
      title  = string
      detail = string
    })
    description = "Status page entry fields."
    optional    = true
  }

  param "notify_stakeholders" {
    type        = bool
    description = "Indicate whether stakeholders are notified or not."
    optional    = true
  }


  step "http" "create_incident" {
    method = "post"
    url    = "https://api.opsgenie.com/v1/incidents/create"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${credential.opsgenie[param.cred].incident_api_key}"
    }

    request_body = jsonencode({ for name, value in param : local.create_incident_query_params[name] => value if contains(keys(local.create_incident_query_params), name) && value != null })

  }

  output "request" {
    value = step.http.create_incident.response_body
  }
}
