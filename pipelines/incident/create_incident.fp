pipeline "create_incident" {
  title       = "Create Incident"
  description = "Create an incident."

  tags = {
    type = "featured"
  }
  
  param "incident_api_key" {
    type        = string
    description = "API key to make incident API call."
    default     = var.incident_api_key
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
    default     = "P3"
  }

  param "note" {
    type        = string
    description = "Additional note that is added while creating the incident."
    optional    = true
  }

  param "impactedServices" {
    type        = list(string)
    description = "Services on which the incident will be created."
    optional    = true
  }

  param "statusPageEntry" {
    type = object({
      title  = string
      detail = string
    })
    description = "Status page entry fields."
    optional    = true
  }

  param "notifyStakeholders" {
    type        = bool
    description = "Indicate whether stakeholders are notified or not."
    default     = false
  }


  step "http" "create_incident" {
    method = "post"
    url    = "https://api.opsgenie.com/v1/incidents/create"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${param.incident_api_key}"
    }
    request_body = jsonencode({
      for name, value in param : name => value if value != null
    })
  }

  output "incident" {
    value = step.http.create_incident.response_body
  }
}
