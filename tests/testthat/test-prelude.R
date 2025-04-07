test_that("prelude attaches and loads without error", {
  expect_no_error({
    library(prelude)
  })
})

test_that("prelude function throws no unexpected error", {
  expect_no_error({
    prelude()
  })
})

test_that("prelude function returns the expected list", {
  global_prelude <- prelude()

  expect_true(is.list(prelude()))

  expect_true(
    c("auth", "conn", "errors") %in% names(global_prelude) |> all()
  )
})
