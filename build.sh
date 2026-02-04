#!/bin/bash

# get dependencies and compile application
mix deps.get --only prod
MIX_ENV=prod mix compile

# compile assets
MIX_ENV=prod mix assets.deploy
# MIX_ENV=prod mix phx.digest

# custom tasks
MIX_ENV=prod mix ecto.migrate

# build release
MIX_ENV=prod mix release

# optionally run the application as prod for local testing
# PORT=4000 MIX_ENV=prod mix phx.server