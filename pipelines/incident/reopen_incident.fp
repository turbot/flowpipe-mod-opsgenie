pipeline "reopen_incident" {
  title       = "Reopen Incident"
  description = "Reopens an incident."

  param "conn" {
    type        = connection.opsgenie
    description = local.conn_param_description
    default     = connection.opsgenie.default
  }

  param "identifier" {
    type        = string
    description = "Identifier of the incident."
  }

  param "identifier_type" {
    type        = string
    description = "Type of the identifier that is provided as an in-line parameter"
  }

  param "note" {
    type        = string
    description = "Additional incident note to add."
    optional    = true
  }

  step "http" "reopen_incident" {
    method = "POST"
    url    = "https://api.opsgenie.com/v1/incidents/${param.identifier}/reopen?identifierType=${param.identifier_type}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${param.conn.incident_api_key}"
    }

    request_body = jsonencode(
      param.note != null ? {
        note = param.note
      } : {}
    )
  }

  output "request" {
    value = step.http.reopen_incident.response_body
  }
}
