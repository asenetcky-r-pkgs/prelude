test_that("grab_prelude() pulls prelude to the current environment", {
  curr_env <- rlang::current_env()

  expect_null(
    get0("prelude", mode = "list", envir = .GlobalEnv, inherits = FALSE)
  )
  expect_null(
    get0("prelude", mode = "list", envir = curr_env, inherits = FALSE)
  )
  expect_true(
    get0(
      "prelude",
      mode = "list",
      envir = the,
      inherits = FALSE
    ) |>
      is.list()
  )

  prelude_object <- grab_prelude()

  expect_true(
    get0("prelude_object", envir = curr_env) |> is.list()
  )
})

test_that("grab_*_conn family of function pulls conns to current environment", {
  curr_env <- rlang::current_env()

  expect_null(
    get0("prelude", mode = "list", envir = .GlobalEnv, inherits = FALSE)
  )
  expect_null(
    get0("prelude", mode = "list", envir = curr_env, inherits = FALSE)
  )
  expect_true(
    get0(
      "prelude",
      mode = "list",
      envir = the,
      inherits = FALSE
    ) |>
      is.list()
  )

  expect_no_error({
    grab_prod_conn()
    grab_stg_conn()
    grab_dev_conn()
  })

  prod <- grab_prod_conn()
  stg <- grab_stg_conn()
  dev <- grab_dev_conn()

  expect_true(
    exists("prod", envir = curr_env, inherits = FALSE)
  )
  expect_true(
    exists("stg", envir = curr_env, inherits = FALSE)
  )
  expect_true(
    exists("dev", envir = curr_env, inherits = FALSE)
  )

  expect_true(
    c(prod, stg, dev) |>
      purrr::map_lgl(
        \(conn) class(conn) == "Microsoft SQL Server"
      ) |>
      all()
  )
})


test_that("grab_prelude_auth pulls auth to current environment", {
  curr_env <- rlang::current_env()

  expect_null(
    get0("prelude", mode = "list", envir = .GlobalEnv, inherits = FALSE)
  )
  expect_null(
    get0("prelude", mode = "list", envir = curr_env, inherits = FALSE)
  )
  expect_true(
    get0(
      "prelude",
      mode = "list",
      envir = the,
      inherits = FALSE
    ) |>
      is.list()
  )

  expect_no_error(grab_prelude_auth())

  auth <- grab_prelude_auth()

  expect_true(
    exists("auth", envir = curr_env, inherits = FALSE)
  )
  expect_true(
    class(auth) == "list"
  )
  expect_true(
    c("email", "password", "token") %in% names(auth) |> all()
  )
})

test_that("grab_prelude_errors pulls auth to current environment", {
  curr_env <- rlang::current_env()

  expect_null(
    get0("prelude", mode = "list", envir = .GlobalEnv, inherits = FALSE)
  )
  expect_null(
    get0("prelude", mode = "list", envir = curr_env, inherits = FALSE)
  )
  expect_true(
    get0(
      "prelude",
      mode = "list",
      envir = the,
      inherits = FALSE
    ) |>
      is.list()
  )

  expect_no_error(grab_prelude_errors())

  errors <- grab_prelude_errors()

  expect_true(
    exists("errors", envir = curr_env, inherits = FALSE)
  )
  expect_true(
    class(errors) == "list"
  )
  expect_true(
    c("conn", "auth") %in% names(errors) |> all()
  )
})

test_that("grab_prelude_errors has no captured errors at prod", {
  testthat::skip()
  # TODO: add if_prod helper back

  errors <- grab_prelude_errors()

  expect_null(errors$conn)
  expect_null(errors$auth)
})

test_that("grab_prelude_errors has the expected captured errors outside of prod", {
  testthat::skip()
  # TODO: add if_prod helper back

  errors <- grab_prelude_errors()

  expect_true(
    c("call", "message") %in% names(errors$conn) |> all()
  )
  expect_true(
    c("call", "message") %in% names(errors$auth) |> all()
  )
})
