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
    # log csvString
    result = papa.parse(csvString)

    # olog result.data

    resultJSON = createResonableJSON(result.data)
    
    olog resultJSON

    resultXML = js2xml.parse("krakenTransactions", resultJSON)
    olog resultXML
    
    fs.writeFileSync(outputPath, resultXML)
    return


createResonableJSON = (data) ->
    log "createResonableJSON"
    ##TODO structure data to reasonable json
    # olog data
    head = data.shift()
    # olog head

    result = {transaction:[]}
    for d in data
        obj = mapToObject(head, d)
        if obj? then result.transaction.push(obj)
    return result

mapToObject = (head, data) ->
    if head.length != data.length then return null
    obj = {}
    for el,idx in head
        obj[el] = data[idx]
    return obj