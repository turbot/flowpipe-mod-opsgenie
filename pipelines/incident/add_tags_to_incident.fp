pipeline "add_tags_to_incident" {
  title       = "Add Tags to Incident"
  description = "Add tags to an incident."

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
    description = "Type of the identifier that is provided as an in-line parameter."
    default     = "id"
  }

  param "note" {
    type        = string
    description = "Additional incident note to add."
    optional    = true
  }

  param "tags" {
    type        = list(string)
    description = "The list of tags to add into incident."
  }

  step "http" "add_tags_to_incident" {
    method = "post"
    url    = "https://api.opsgenie.com/v1/incidents/${param.identifier}/tags?identifierType=${param.identifierType}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${param.incident_api_key}"
    }
    request_body = jsonencode({
      for name, value in param : name => value if value != null
    })
  }

  output "incident" {
    value = step.http.add_tags_to_incident.response_body
  }
}
