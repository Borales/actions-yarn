#!/usr/bin/env bats

PATH="$PATH:$BATS_TEST_DIRNAME/bin"

function setup() {
  # Ensure GITHUB_WORKSPACE is set
  export GITHUB_WORKSPACE="${GITHUB_WORKSPACE-"${BATS_TEST_DIRNAME}/.."}"
}

@test "entrypoint runs successfully" {
  run $GITHUB_WORKSPACE/entrypoint.sh help
  echo "$output"
  [ "$status" -eq 0 ]
}

@test "npmrc location can be overridden" {
  export NPM_CONFIG_USERCONFIG=$( mktemp )
  export NPM_AUTH_TOKEN=NPM_AUTH_TOKEN
  run $GITHUB_WORKSPACE/entrypoint.sh help
  [ "$status" -eq 0 ]
  [ "$(cat $NPM_CONFIG_USERCONFIG)" = "//registry.npmjs.org/:_authToken=NPM_AUTH_TOKEN" ]
}

@test "registry can be overridden" {
  export NPM_CONFIG_USERCONFIG=$( mktemp )
  export NPM_REGISTRY_URL=someOtherRegistry.someDomain.net
  export NPM_AUTH_TOKEN=NPM_AUTH_TOKEN
  run $GITHUB_WORKSPACE/entrypoint.sh help
  [ "$status" -eq 0 ]
  [ "$(cat $NPM_CONFIG_USERCONFIG)" = "//someOtherRegistry.someDomain.net/:_authToken=NPM_AUTH_TOKEN" ]
}
