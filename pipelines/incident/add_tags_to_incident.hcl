pipeline "add_tags_to_incident" {
  title       = "Add Tags to Incident"
  description = "Add tags to an incident."

  param "token" {
    type        = string
    description = "Token to make an API call."
    default     = var.token
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
    description = "TList of tags to add into incident."
  }

  step "http" "add_tags_to_incident" {
    method = "POST"
    url    = "https://api.opsgenie.com/v1/incidents/${param.identifier}/tags?identifierType=${param.identifierType}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${param.token}"
    }
    request_body = jsonencode({
      for name, value in param : name => value if value != null
    })
  }

  output "incident" {
    value = jsondecode(step.http.add_tags_to_incident.response_body)
  }
}
