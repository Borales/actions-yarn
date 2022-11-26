import {debug, getInput, setFailed, getState} from '@actions/core'
import {ensureYarnIsInstalled} from './yarn'
import {run} from './run'

const main = async () => {
  await ensureYarnIsInstalled()

  const cmd: string = getInput('cmd', {required: true})
  const cwd: string = getState('repositoryPath')

  try {
    debug(`Running "${cmd}" command`)

    await run(cmd, {cwd})
  } catch (error) {
    if (error instanceof Error) setFailed(error.message)
  }
}

main()
