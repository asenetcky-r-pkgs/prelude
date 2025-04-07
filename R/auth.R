#' Grab Relevant Authentication Artifacts from System Keyring
#'
#' `setup_auth()` will return a named list including,
#' most commonly, the email and password related to
#' the service name provided.
#'
#' @param service_name Name of Service in System Keyring.
#'
#' @return An invisible named list of credentials.
#'
#' @examples
#' \dontrun{
#' auth <- setup_auth("service1")
#' foo <- function(url, email, password) {
#'  args <-
#'    list(
#'      url,
#'      email,
#'      password
#'  )
#'  invisible(TRUE)
#' }
#'
#' foo(
#'   url = "https://someurl.com/resource/12315.json",
#'   email = auth$service1$email,
#'   password = auth$service1$password
#' )
#' }
setup_auth <- function(service_name) {
  # check user input
  checkmate::assert_character(service_name)

  # handle global bindings
  service <- username <- NULL

  # grab email
  email <-
    keyring::key_list() |>
    dplyr::filter(service == service_name) |>
    dplyr::pull(username)

  # check if empty
  is_empty <- purrr::is_empty(email)

  timestamp <- make_timestamp()
  # throw error if empty
  if (is_empty) {
    rlang::abort(
      glue::glue(
        "[{timestamp}]: ERROR: Credential not found"
      )
    )
  }

  # grab password
  password <-
    keyring::key_get(
      service = service_name,
      username = email
    )

  # returned name list
  dplyr::lst(
    email,
    password
  ) |>
    invisible()
}
