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

workflow "Build and Publish" {
  resolves = [
    "Docker Lint",
    "Test",
    "Docker Login",
    "Docker Publish",
  ]
  on = "push"
}

action "Master Branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Lint" {
  uses = "docker://replicated/dockerfilelint"
  needs = ["Master Branch"]
  args = "[\"./Dockerfile\"]"
}

action "Shell Lint" {
  uses = "actions/bin/shellcheck@master"
  needs = ["Master Branch"]
  args = "entrypoint.sh"
}

action "Test" {
  uses = "actions/bin/bats@master"
  needs = ["Master Branch"]
  args = "test/*.bats"
}

action "Build" {
  uses = "actions/docker/cli@master"
  needs = [
    "Docker Lint",
    "Test",
    "Shell Lint",
  ]
  args = "build -t yarn ."
}

action "Docker Tag" {
  uses = "actions/docker/tag@master"
  args = "yarn borales/yarn --no-latest"
  needs = ["Build"]
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_PASSWORD", "DOCKER_USERNAME"]
  needs = ["Build"]
}

action "Docker Publish" {
  uses = "actions/docker/cli@master"
  needs = [
    "Docker Login",
    "Docker Tag",
  ]
  args = "push borales/yarn"
}
