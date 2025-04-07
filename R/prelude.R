#' Setup Standard Environment
#'
#' `prelude()` sets up the standard connections required, authentication
#' and other common objects needed for analytics and development and
#' stores it in the "the" environment.
#'
#' @returns The prelude object invisibly - a named list from the
#' `the` environment with connections and authentication.
#'
#' @export
#'
#' @examples
#' prelude()
prelude <- function() {
  safe_con <- purrr::safely(
    setup_connections,
    otherwise = dplyr::lst(
      # consider giving options or other generic simulations
      "prod" = dbplyr::simulate_mssql(),
      "stg" = dbplyr::simulate_mssql(),
      "dev" = dbplyr::simulate_mssql()
    )
  )

  safe_auth <- purrr::safely(
    setup_auth,
    otherwise = dplyr::lst(
      email = "emailname@email.com",
      password = "thispasswordisntrealnothingisreal"
    )
  )

  connections <- safe_con()

  # consider how to handle default expectations
  # plus whatever the user adds
  # some sort of hidden yaml and auto edit the .gitignore?
  # something cached somewhere else?
  auth_service <- safe_auth("standard-service")
  app_token <- safe_auth("standard-token")

  # grab errors
  errors <-
    dplyr::lst(
      "conn" = connections$error,
      "auth" = auth_service$error
    )

  # standard connection names
  conn <-
    dplyr::lst(
      "prod" = connections$result$prod,
      "stg" = connections$result$stg,
      "dev" = connections$result$dev
    )

  # keep auth in list to prevent accidental reveals when
  # screen sharing, but remove service name
  auth <-
    dplyr::lst(
      email = auth_service$result$email,
      password = auth_service$result$password,
      token = app_token$result$password
    )

  # Keep in prelude list
  # Functions will know to check prelude, then global environment
  # and then throw errors if desired
  prelude <-
    dplyr::lst(
      "conn" = conn,
      "auth" = auth,
      "errors" = errors
    )

  # Sent to global environment
  assign("prelude", prelude, envir = the)
  invisible(prelude)
}
