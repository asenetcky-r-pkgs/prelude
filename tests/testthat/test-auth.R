test_that("expect specific error when provided bogus service", {
  expect_error(
    setup_auth("bogus"),
    regexp = "Credential not found"
  )
})

test_that("expect specific credentials to exist in prod environment", {
  # TODO: add if_prod helper back
  testthat::skip()

  prod_auth_object <- setup_auth("prod_auth")
  token_auth_object <- setup_auth("prod_token")

  expect_true(
    prod_auth_object |> is.list() && token_auth_object |> is.list()
  )

  expect_true(
    c("email", "password") %in%
      names(prod_auth_object) |>
      all() &&
      c("email", "password") %in% names(token_auth_object) |> all()
  )
})
