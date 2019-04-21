workflow "Build and Publish" {
  resolves = "Docker Publish"
  on = "push"
}

action "Shell Lint" {
  uses = "actions/bin/shellcheck@master"
  args = "entrypoint.sh"
}

action "Test" {
  uses = "actions/bin/bats@master"
  args = "test/*.bats"
}

action "Docker Lint" {
  uses = "docker://replicated/dockerfilelint"
  args = ["Dockerfile"]
}

action "Build" {
  needs = ["Shell Lint", "Test", "Docker Lint"]
  uses = "actions/docker/cli@master"
  args = "build -t yarn ."
}

action "Docker Tag" {
  needs = ["Build"]
  uses = "actions/docker/tag@master"
  args = "yarn borales/yarn --no-latest"
}

action "Publish Filter" {
  needs = ["Build"]
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Login" {
  needs = ["Publish Filter"]
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Publish" {
  needs = ["Docker Tag", "Docker Login"]
  uses = "actions/docker/cli@master"
  args = "push borales/yarn"
}

workflow "Pull Request" {
  on = "pull_request"
  resolves = ["Docker Lint [PR]", "Shell Lint [PR]", "Test [PR]"]
}

action "Docker Lint [PR]" {
  uses = "docker://replicated/dockerfilelint"
  args = "Dockerfile"
}

action "Shell Lint [PR]" {
  uses = "actions/bin/shellcheck@master"
  args = "entrypoint.sh"
}

action "Test [PR]" {
  uses = "actions/bin/bats@master"
  args = "test/*.bats"
}
