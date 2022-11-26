import {debug} from '@actions/core'
import {exec, getExecOutput} from '@actions/exec'
import {which} from '@actions/io'

export const ensureYarnIsInstalled = async () => {
  try {
    await which('yarn', true)
  } catch (e) {
    await exec('npm install --global yarn')
  }

  const [{stdout: yarnVersion}, {stdout: nodeVersion}] = await Promise.all([
    getExecOutput('yarn', ['--version'], {silent: true}),
    getExecOutput('node', ['--version'], {silent: true})
  ])
  debug(`Node ${nodeVersion.trim()} detected`)
  debug(`Yarn v${yarnVersion.trim()} detected`)
}
