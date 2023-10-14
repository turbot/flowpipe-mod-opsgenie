pipeline "reopen_incident" {
  title       = "Reopen Incident"
  description = "Reopen an incident."

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
    description = "Type of the identifier that is provided as an in-line parameter"
    default = "id"
  }

  param "note" {
    type =  string
    description = "Additional incident note to add."
    optional = true
  }

  step "http" "reopen_incident" {
    method = "POST"
    url    = "https://api.opsgenie.com/v1/incidents/${param.identifier}/reopen?identifierType=${param.identifierType}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${param.token}"
    }
    request_body = jsonencode({
        for name, value in param : name => value if value != null
    })
  }

  output "incident" {
    value = jsondecode(step.http.reopen_incident.response_body)
  }
}
