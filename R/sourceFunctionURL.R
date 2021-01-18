

sourceFunctionURL <- function (URL) {
    " # For more functionality, see gitAFile() in the rgit package ( https://github.com/John-R-Wallace-NOAA/rgit ) which includes gitPush() and git() "
    require(xml2)
    File.ASCII <- tempfile()
    on.exit(file.remove(File.ASCII))
    writeLines(paste0('source("', readLines(textConnection(xml2::download_html(URL))), '")'), File.ASCII)
    source(File.ASCII, local = parent.env(environment()))
}
