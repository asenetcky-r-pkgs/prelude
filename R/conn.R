#' Setup Sql Server Connections
#'
#' `setup_connections()` checks the system's DSNs for
#' the expected sql servers and if found
#' will setup the connections for the user and return
#' in a named list.  If the expected DSNs are not found
#' an error will be thrown.
#'
#' @return An invisible named list of connections.
#'
#' @examples
#' \dontrun{
#' connections <- setup_connections()
#' table <- odp::read_table(
#'   conn = connections$prod,
#'   database_name = "fake_db",
#'   schema_name = "fake_schema",
#'   table_name = "fake_table",
#'   lazy = TRUE
#' )
#' }
setup_connections <- function() {
  # capture list of dsns
  DSNs <- odbc::odbcListDataSources() |> dplyr::as_tibble()

  # check list or fail
  assert_connections <-
    all(
      c("prod", "stg", "dev") %in% DSNs$name
    )

  timestamp <- make_timestamp()
  # throw error is missing DSNs
  if (!assert_connections) {
    rlang::abort(
      glue::glue(
        "[{timestamp}]: ERROR: Missing expected DSNs"
      )
    )
  }

  # return named list of connections
  dplyr::lst(
    prod = DBI::dbConnect(odbc::odbc(), "prod"),
    stg = DBI::dbConnect(odbc::odbc(), "stg"),
    dev = DBI::dbConnect(odbc::odbc(), "dev")
  ) |>
    invisible()
}
