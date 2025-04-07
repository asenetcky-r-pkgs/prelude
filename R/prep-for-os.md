# prep for open source

need to scrub this and then possibly turn some of this
into more general funs, and maybe a function factory or two.

## todo list

### auth.r

-`setup_auth`
    - doesn't look too bad at first
    - only seems to reference keyrings
        - references keying email and keyring password - does not show anything
- TODO: modify this setup your own auth - like maybe have more general setup_* funs
    - maybe one for secrets that involve keyring - so auth
    - maybe another for jsut simple environment vars that persist somehow? like conn strings, emails etc...

### conn.R

looks pretyt okay. the biggest deal are the references to other privat packages.

- `setup_connections`
- reference to `helpers::make_timestamp`
- references to generic prod, stg, dev conns
- example has reference to `odp::read_table` which is wrong anyway -  needs to be 
`squeal::read_table`
- TODO: extend out the idea above in `setup_auth` -  setup_ for secrets, non-secrets, 
and probably one for conns

### grab.R
 looks pretty okay.
 I'm thinking the generic prod, stg, dev, conns are probably fine. 
 going to need setup helpers, picking what conns to simulate, which sql backend
 etc...

### prelude.R
has some stuff that needs to be scrubbed...

- `prelude`
    - [X] auth_service <- safe_auth("ODP") will need to be scrubbed
    - [X] app_token <- safe_auth("CT DMAG ODP App Token) will need to be scrubbed
- TODO: 
    - [] need a way to pick what to simulate
    - [] need a way to feed actual production choices - need to export a user facing 
    version of setup_* 
    - [] need to figure out runtime vs buildtime envs etc...

### zzz.R
- [X] looks pretty good but it references odp::prelude - need to scrub that reference.

### README.md
- [X] need to scrub references to azure and urls to repos

### NEWS.md
- [X] need to scrub references to azure repo urls

### DESCRIPTION
- [X] change to MIT license
- [] need to double check MIT license compatibility with depends
- [] need to update role for license holding

### tests
-[x] scrub tests
-[X] scrub helper references