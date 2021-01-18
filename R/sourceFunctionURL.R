
sourceFunctionURL <- function (URL) {
    " # For more functionality, see gitAFile() in the rgit package ( https://github.com/John-R-Wallace-NOAA/rgit ) which includes gitPush() and git() "
    require(xml2)
    File.ASCII <- tempfile()
    on.exit(file.remove(File.ASCII))
    tempDir <- tempfile()
    dir.create(tempDir); setwd(tempDir)
    on.exit(setwd('..'), add = TRUE)
    on.exit(system(paste0("rm -r -f ", tempDir)), add = TRUE)
    writeLines(paste0('source("', readLines(textConnection(xml2::download_html(URL))), '")'), File.ASCII)
    source(File.ASCII, local = parent.env(environment()))
}
