# temporary until I get the helpers package online

#' Create a standard timestamp
#'
#' @returns A character string of a standardized timestamp.
#'
#' @examples
#' make_timestamp()
make_timestamp <- function() {
  Sys.time() |>
    as.character() |>
    stringr::str_trunc(width = 24, ellipsis = "") |>
    stringr::str_pad(width = 24, side = "right", pad = "0")
}
