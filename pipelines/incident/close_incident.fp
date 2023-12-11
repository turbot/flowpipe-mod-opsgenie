pipeline "close_incident" {
  title       = "Close Incident"
  description = "Closes an incident."

  tags = {
    type = "featured"
  }

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "identifier" {
    type        = string
    description = "Identifier of the incident."
  }

  param "identifier_type" {
    type        = string
    description = "Type of the identifier that is provided as an in-line parameter"
    default     = "id"
  }

  param "note" {
    type        = string
    description = "Additional incident note to add."
    optional    = true
  }

  step "http" "close_incident" {
    method = "POST"
    url    = "https://api.opsgenie.com/v1/incidents/${param.identifier}/close?identifierType=${param.identifier_type}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${credential.opsgenie[param.cred].incident_api_key}"
    }

    request_body = jsonencode(
      param.note != null ? {
        note = param.note
      } : {}
    )
  }

  output "request" {
    value = step.http.close_incident.response_body
  }
}
