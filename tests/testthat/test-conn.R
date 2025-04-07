test_that("expect errors when not at prod", {
  testthat::skip()
  # TODO: add if_prod helper back

  expect_error(
    setup_connections(),
    regexp = "Missing expected DSNs"
  )
})

test_that("no errors when at prod", {
  testthat::skip()
  # TODO: add if_prod helper back

  expect_no_error(
    setup_connections()
  )
})

test_that("expected connections are sql servers", {
  testthat::skip()
  # TODO: add if_prod helper back

  conn_object <- setup_connections()

  expect_true(is.list(conn_object))
  expect_true(
    c("prod", "stg", "dev") %in% names(conn_object) |> all()
  )
  expect_true(
    conn_object |>
      purrr::map_lgl(
        \(conn) class(conn) == "Microsoft SQL Server"
      ) |>
      all()
  )
})
