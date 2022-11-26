# GitHub Actions for Yarn

> Look [github.com/actions/setup-node](https://github.com/actions/setup-node) for more details.

This Action for [yarn](https://yarnpkg.com) enables arbitrary actions with the `yarn` command-line client, including testing packages and publishing to a registry.

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
```

> `cmd` value will be used as a command for Yarn

More information about [private registry setup](https://github.com/actions/setup-node/blob/main/docs/advanced-usage.md#use-private-packages).
