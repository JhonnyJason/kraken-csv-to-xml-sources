##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("mainprocessmodule")

#endregion

##############################################################################
import papa from "papaparse"
import pathModule from "path"
import fs from "fs"
import * as js2xml from "js2xmlparser"

##############################################################################
import * as cfg from "./configmodule.js"

##############################################################################
export execute = (e) ->
    log "execute"
    olog e
    inputPath = pathModule.resolve(e.inputFile)
    if e.outputFile? then outputPath = pathModule.resolve(e.outputPath)
    else outputPath = inputPath+".xml"

    csvString = fs.readFileSync(inputPath, "utf8")
    log csvString
    result = papa.parse(csvString)

    olog result.data

    result = js2xml.parse("transactions", result.data)
    olog result

    return

