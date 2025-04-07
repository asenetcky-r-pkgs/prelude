
<!-- README.md is generated from README.Rmd. Please edit that file -->

# prelude

<!-- badges: start -->

<!-- badges: end -->

The goal of `prelude` is to help setup the development environment for
users and provide helpers for connections, authentication and other
common objects needed in their analytic workflow.

## Installation

You can install the development version of prelude like so:

``` r
# insert github link when ready
```

## Authentication

Users in their production environment with their keyring already setup
will have easy access to the authentication related credentials.

``` r
library(prelude)

auth <- prelude::grab_prelude_auth()

auth
#> $email
#> [1] "emailname@email.com"
#> 
#> $password
#> [1] "thispasswordisntrealnothingisreal"
#> 
#> $token
#> [1] "thispasswordisntrealnothingisreal"
```

## Connections

Users who already have their dsns setup with generic names like prod,
stg, and dev will have easy access to them. `prelude` provides easy
access to the different connections.

``` r
prod <- prelude::grab_prod_conn()
stg <- prelude::grab_stg_conn()
dev <- prelude::grab_dev_conn()

prod
#> list()
#> attr(,"version")
#> [1] '15.0'
#> attr(,"class")
#> [1] "Microsoft SQL Server" "TestConnection"       "DBIConnection"
stg
#> list()
#> attr(,"version")
#> [1] '15.0'
#> attr(,"class")
#> [1] "Microsoft SQL Server" "TestConnection"       "DBIConnection"
dev
#> list()
#> attr(,"version")
#> [1] '15.0'
#> attr(,"class")
#> [1] "Microsoft SQL Server" "TestConnection"       "DBIConnection"
```

## Errors and Placeholders

If users are not in the expected production environment `prelude` will
use fake placeholders instead, and `purrr::safely` capture any errors
for users to handle as they see fit.

``` r
errors <- grab_prelude_errors()

errors$auth$message
#> [2025-04-07 13:59:26.7330]: ERROR: Credential not found
errors$conn$message
#> [2025-04-07 13:59:26.6739]: ERROR: Missing expected DSNs
```

## Environment

`prelude` loads the prelude object into the empty environment, named
`the` on package attachment. The `the` environment is built at compile
time and is not directly available to developers during run time.
However, they will be able to access the contents of prelude through the
exported `grab` family of functions.
