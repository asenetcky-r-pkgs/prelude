the <- rlang::new_environment()

.onAttach <- function(libname, pkgname) {
  if (rlang::is_interactive()) {
    packageStartupMessage(
      "Loading prelude()"
      # probably add a hook to look for an env var to silences this or not
      # maybe add something that hints to the user what kinds of things
      # were just loaded - like you have auth, conn, vector of paths,
      # random x, etc.... loaded
    )
  }
}

.onLoad <- function(libname, pkgname) {
  # load prelude object with connections
  # and auth, etc... into "the" env
  prelude()
}
