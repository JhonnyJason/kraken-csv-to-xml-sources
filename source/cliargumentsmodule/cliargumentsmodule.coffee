##############################################################################
#region debug
import {createLogFunctions} from "thingy-debug"
{log, olog} = createLogFunctions("cliargumentsmodule")

#endregion

##############################################################
import meow from 'meow'

##############################################################
#region internal functions
getHelpText = ->
    log "getHelpText"
    return """
        Usage 
            $ kraken-csv-to-xml transactions.csv
    
        Options
            required: arg1, --input-file, -i
                the path to the csv file to read and translate

            optional: arg2, --output-file, -i
                the path to the xml file to be written.
                if it is not defined we will write the output as <input-file-name>.xml 

        Examples
            $ kraken-csv-to-xml transactions.csv
            ...
    """

getOptions = ->
    log "getOptions"
    return {
        importMeta: import.meta,
        flags:
            inputFile: 
                type: "string" # or string
                alias: "i"
            outputFile:
                type: "string"
                alias: "o"
    }

##############################################################
extractMeowed = (meowed) ->
    log "extractMeowed"

    inputFile = null
    outputFile = null

    if meowed.input[0] then inputFile = meowed.input[0]
    if meowed.flags.inputFile then inputFile = meowed.flags.inputFile

    if meowed.input[1] then outputFile = meowed.input[1]
    if meowed.flags.outputFile then output = meowed.flags.outputFile


    return {inputFile, outputFile}

throwErrorOnUsageFail = (extract) ->
    log "throwErrorOnUsageFail"
    if !extract.inputFile then throw new Error("Usag error: no input-file has been defined!")
    return
#endregion

##############################################################
export extractArguments = ->
    log "extractArguments"
    meowed = meow(getHelpText(), getOptions())
    extract = extractMeowed(meowed)
    throwErrorOnUsageFail(extract)
    return extract
