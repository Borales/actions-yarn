# GitHub Actions for Yarn

> Look [github.com/actions/setup-node](https://github.com/actions/setup-node) for more details.

This Action for [yarn](https://yarnpkg.com) enables arbitrary actions with the `yarn` command-line client, including testing packages and publishing to a registry.

> **Please keep in mind** that this Action was originally written for GitHub Actions beta (when Docker was the only way of doing things).
Consider using [actions/setup-node](https://github.com/actions/setup-node) to work with Yarn. This repository will be mostly supporting the existing flows.

## Usage

An example workflow how to install packages via Yarn (using repository syntax):

```yml
name: CI
on: [push]
jobs:
  build:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: borales/actions-yarn@v3.0.0
        with:
          cmd: install # will run `yarn install` command
      - uses: borales/actions-yarn@v3.0.0
        with:
          cmd: build # will run `yarn build` command
      - uses: borales/actions-yarn@v3.0.0
        with:
          cmd: test # will run `yarn test` command
```

> `cmd` value will be used as a command for Yarn

### Secrets

* `NPM_AUTH_TOKEN` - **Optional**. The token to use for authentication with the npm registry. Required for `yarn publish` ([more info](https://docs.npmjs.com/getting-started/working_with_tokens))

### Environment variables

* `NPM_REGISTRY_URL` - **Optional**. To specify a registry to authenticate with. Defaults to `registry.npmjs.org`
* `NPM_CONFIG_USERCONFIG` - **Optional**. To specify a non-default per-user configuration file. Defaults to `$HOME/.npmrc` ([more info](https://docs.npmjs.com/misc/config#npmrc-files))

#### Example

To authenticate with, and publish to, a registry other than `registry.npmjs.org`:

```yml
- uses: borales/actions-yarn@v3.0.0
  with:
    auth-token: ${{ secrets.NPM_TOKEN }}
    registry-url: someOtherRegistry.someDomain.net
```
