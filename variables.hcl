# TODO: Should these have defaults?
# Right now they do due to :
# panic: missing 2 variable values:
# repository_full_name not set
# token not set

variable "token" {
  type        = string
  description = "The Opsgenie personal access token to authenticate to the Opsgenie APIs, e.g., `u+gLkyUh9sGsEGH3nmtw`. Please see https://support.atlassian.com/opsgenie/docs/api-key-management/ for more information."
  default     = "42c8a183-b509-4556-a61b-af659695f860"
}
