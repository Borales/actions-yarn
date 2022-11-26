import {exec} from '@actions/exec'

export const run = async (cmd: string) => {
  await exec('yarn', [cmd])
}
