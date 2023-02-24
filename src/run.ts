import {exec} from '@actions/exec'

export const run = async (cmd: string, {cwd}: {cwd: string}): Promise<void> => {
  await exec('yarn', cmd.split(' '), {cwd})
}
