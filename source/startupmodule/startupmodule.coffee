##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("startupmodule")

#endregion

##############################################################################
#region imports
import c from 'chalk'

##############################################################################
import * as mp from "./mainprocessmodule.js"
import * as ca from "./cliargumentsmodule.js"

#endregion

##############################################################################
#region internal variables
errLog = (arg) -> console.log(c.red(arg))
successLog = (arg) -> console.log(c.green(arg))

#endregion

##############################################################################
export cliStartup = ->
    log "cliStartup"
    try
        e = ca.extractArguments()
        await mp.execute(e)
        successLog('All done!');
    catch err
        errLog("Error!")
        errLog(err)
        if err.stack then errLog(err.stack)
        process.exit(-1)
