pipeline "resolve_incident" {
  title       = "Resolve Incident"
  description = "Resolve an incident."

  tags = {
    type = "featured"
  }

  param "incident_api_key" {
    type        = string
    description = "API key to make incident API call."
    default     = var.incident_api_key
  }

  param "identifier" {
    type        = string
    description = "Identifier of the incident."
  }

  param "identifierType" {
    type        = string
    description = "Type of the identifier that is provided as an in-line parameter"
    default     = "id"
  }

  param "note" {
    type        = string
    description = "Additional incident note to add."
    optional    = true
  }

  step "http" "resolve_incident" {
    method = "POST"
    url    = "https://api.opsgenie.com/v1/incidents/${param.identifier}/resolve?identifierType=${param.identifierType}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${param.incident_api_key}"
    }
    request_body = jsonencode({
      for name, value in param : name => value if value != null
    })
  }

  output "incident" {
    value = step.http.resolve_incident.response_body
  }
}
