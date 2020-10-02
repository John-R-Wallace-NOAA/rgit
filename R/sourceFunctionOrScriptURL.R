
 sourceFunctionOrScriptURL <- function(URL) {
    
   require(RCurl)
   File.ASCII <- tempfile()
   on.exit(file.remove(File.ASCII))
   writeLines(paste(readLines(textConnection(RCurl::getURL(URL))), collapse = "\n"), File.ASCII)
   source(File.ASCII)
}
   
