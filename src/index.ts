import {debug, getInput, setFailed, getState} from '@actions/core'
import {ensureYarnIsInstalled} from './yarn'
import {run} from './run'
import {resolve} from 'path'

const main = async (): Promise<void> => {
  await ensureYarnIsInstalled()

  const cmd: string = getInput('cmd', {required: true})
  const dir: string = getInput('dir')
  const cwd: string = resolve(getState('repositoryPath'), dir || '')

  try {
    debug(`Running "${cmd}" command`)

    await run(cmd, {cwd})
  } catch (error) {
    if (error instanceof Error) setFailed(error.message)
  }
}

main()
