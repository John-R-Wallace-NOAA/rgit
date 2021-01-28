
sourceFunctionURL <- function (URL) 
{
    " # For more functionality, see gitAFile() in the rgit package ( https://github.com/John-R-Wallace-NOAA/rgit ) which includes gitPush() and git() "
    require(httr)
    File.ASCII <- tempfile()
    on.exit(file.remove(File.ASCII))
    getTMP <- httr::GET(URL)
    write(paste(readLines(textConnection(httr::content(getTMP))), collapse = "\n"), File.ASCII)
    source(File.ASCII)
}
