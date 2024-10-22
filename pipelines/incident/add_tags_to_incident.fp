pipeline "add_tags_to_incident" {
  title       = "Add Tags to Incident"
  description = "Adds tags to an incident."

  param "conn" {
    type        = connection.opsgenie
    description = local.conn_param_description
    default     = connection.opsgenie.default
  }

  param "tags" {
    type        = list(string)
    description = "The list of tags to add into incident."
  }

  param "identifier" {
    type        = string
    description = "Identifier of the incident."
  }

  param "identifier_type" {
    type        = string
    description = "Type of the identifier that is provided as an in-line parameter."
  }

  param "note" {
    type        = string
    description = "Additional incident note to add."
    optional    = true
  }

  step "http" "add_tags_to_incident" {
    method = "post"
    url    = "https://api.opsgenie.com/v1/incidents/${param.identifier}/tags?identifierType=${param.identifier_type}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "GenieKey ${param.conn.incident_api_key}"
    }

    request_body = jsonencode(merge(
      {
        tags = param.tags
      },
      param.note != null ? {
        note = param.note
      } : {}
    ))
  }

  output "request" {
    value = step.http.add_tags_to_incident.response_body
  }
}
