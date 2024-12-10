# GitHub Actions for Yarn

This GitHub Action is currently compatible with Yarn 1.x only.

> Look [github.com/actions/setup-node](https://github.com/actions/setup-node) for more details.

This Action for [yarn](https://yarnpkg.com) enables arbitrary actions with the `yarn` command-line client, including testing packages and publishing to a registry.

## Usage

> It is required to run `actions/setup-node@v3` before `borales/actions-yarn` in order to setup the desired node version.

An example workflow how to install packages via Yarn (using repository syntax):

```yml
name: CI
on: [push]

jobs:
  build:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Set Node.js 16.x
        uses: actions/setup-node@v3
        with:
          node-version: 16.x

      - name: Run install
        uses: borales/actions-yarn@v4
        with:
          cmd: install # will run `yarn install` command
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }} # if needed
      - name: Build production bundle
        uses: borales/actions-yarn@v4
        with:
          cmd: build:prod # will run `yarn build:prod` command
      - name: Test the app
        uses: borales/actions-yarn@v4
        with:
          cmd: test # will run `yarn test` command

      - name: Run test in sub-folder
        uses: borales/actions-yarn@v4
        with:
          cmd: test
          dir: 'frontend' # will run `yarn test` in `frontend` sub folder
```

> `cmd` value will be used as a command for Yarn
>
> `dir` value will be used for Yarn `cwd`

More information about [private registry setup](https://github.com/actions/setup-node/blob/main/docs/advanced-usage.md#use-private-packages).
