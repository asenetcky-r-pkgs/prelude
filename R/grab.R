#' Return the prelude object from the "the" environment
#'
#' @returns The prelude object invisibly - a named list from the
#' `the` environment with connections and authentication.
#' @export
#'
#' @family grabs
#'
#' @examples
#' global_prelude_object <- grab_prelude()
grab_prelude <- function() {
  # Does prelude exist in "the"
  prelude_exist <-
    exists("prelude", envir = the, inherits = FALSE)

  if (prelude_exist) {
    # Grab prelude from "the" environment
    get("prelude", envir = the, inherits = FALSE) |>
      invisible()
  } else {
    invisible(NULL)
  }
}

#' Return connections from the prelude
#'
#' `grab_prod_conn()`returns the production connection.
#' `grab_stg_conn()` returns the staging connection.
#' `grab_dev_conn()` returns the development connection.
#'
#' @returns A SQL Server connection object.
#' @export
#'
#' @family grabs
#'
#' @examples
#' prod <- grab_prod_conn()
#' stg <- grab_stg_conn()
#' dev <- grab_dev_conn()
grab_prod_conn <- function() {
  grab_conn("prod")
}

#' @rdname grab_prod_conn
#' @export
#' @family grabs
grab_stg_conn <- function() {
  grab_conn("stg")
}

#' @rdname grab_prod_conn
#' @export
#' @family grabs
grab_dev_conn <- function() {
  grab_conn("dev")
}

#' Return a specific connection from the prelude
#'
#' @param conn_name A character string of the connection name.
#'
#' @family grabs
#' @returns A SQL Server connection object.
grab_conn <- function(conn_name) {
  # grab prelude
  prelude <- grab_prelude()

  if (is.null(prelude)) {
    rlang::abort("prelude not found")
  }

  # return connection
  prelude$conn[[conn_name]] |>
    invisible()
}


#' Return authentication from the prelude
#'
#' @return A named list of authentication objects.
#' @export
#'
#'
#' @family grabs
#'
#' @examples
#' grab_prelude_auth()
grab_prelude_auth <- function() {
  # grab prelude
  prelude <- grab_prelude()

  if (is.null(prelude)) {
    rlang::abort("prelude not found")
  }

  # return stg connection
  prelude$auth |>
    invisible()
}


#' Return captured errors from the prelude
#'
#' @return A named list of prelude-related errors.
#' @export
#'
#' @family grabs
#'
#' @examples
#' grab_prelude_errors()
grab_prelude_errors <- function() {
  # grab prelude
  prelude <- grab_prelude()

  if (is.null(prelude)) {
    rlang::abort("prelude not found")
  }

  # return stg connection
  prelude$errors |>
    invisible()
}
