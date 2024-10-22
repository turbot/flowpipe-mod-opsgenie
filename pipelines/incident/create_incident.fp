pipeline "create_incident" {
  title       = "Create Incident"
  description = "Creates an incident."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.opsgenie
    description = local.conn_param_description
    default     = connection.opsgenie.default
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

  param "tags" {
    type        = list(string)
    description = "Tags of the incident."
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
      Authorization = "GenieKey ${param.conn.incident_api_key}"
    }

    request_body = jsonencode({ for name, value in param : local.create_incident_query_params[name] => value if contains(keys(local.create_incident_query_params), name) && value != null })

  }

  output "request" {
    value = step.http.create_incident.response_body
  }
}
