import {debug, getInput, setOutput, setFailed} from '@actions/core'
import {ensureYarnIsInstalled} from './yarn'
import {run} from './run'

const main = async () => {
  await ensureYarnIsInstalled()

  const cmd: string = getInput('cmd', {required: true})

  try {
    debug(`Running "${cmd}" command`)

    await run(cmd)
    setOutput(cmd, 'Done')
  } catch (error) {
    if (error instanceof Error) setFailed(error.message)
  }
}

main()
