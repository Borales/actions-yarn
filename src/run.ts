import {exec} from '@actions/exec'

export const run = async (cmd: string, {cwd}: {cwd: string}) => {
  await exec('yarn', [cmd], {cwd})
}
