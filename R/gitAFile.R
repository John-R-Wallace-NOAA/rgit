
gitAFile <- function (URL, type = c("function", "csv", "script", "RData", "RPckageZip", "Binary", "pdfGitHub")[1], File = NULL, shortName = NULL, run = FALSE, 
                      showNameOnly = TRUE, show = FALSE, viewOnly = FALSE, deleteFileObj = ifelse(is.null(File), TRUE, FALSE), rawGitPrefix = TRUE, verbose = FALSE, ...) 
{
  # Example:  gitAFile("John-R-Wallace-NOAA/rgit/master/R/gitAFile.R")
  # Adds the raw GitHub prefix to create a full URL when type = "function", i.e.: paste0("https://raw.githubusercontent.com", "John-R-Wallace-NOAA/JRWToolBox@master/R/panel.conf.pred.band.R") 
  # Set rawGitPrefix = FALSE to not add a prefix.
    
  # Example of pdf download: gitAFile("https://github.com/James-Thorson/VAST/blob/master/manual/VAST_model_structure.pdf", "pdf")
  # Or directly using browseGitPDF: rgit::browseGitPDF("https://github.com/James-Thorson/VAST/blob/master/manual/VAST_model_structure.pdf")
  # See displaying pdf's from GitHub: https://webapps.stackexchange.com/questions/48061/can-i-trick-github-into-displaying-the-pdf-in-the-browser-instead-of-downloading 
  
    JRWToolBox::lib(httr)

    getURL <- function(url) {
        getTMP <- httr::GET(url)
        httr::content(getTMP)
    }
     
    Source <- function(file, ...) {
        ls.ext <- function(file) {
            local({
                base::source(file, TRUE)
                base::ls()
            })
        }
        base::source(file, ...)
        ls.ext(file)
    }
    
    # ------------------------------------
    
    if(rawGitPrefix) 
           URL <- paste0('https://raw.githubusercontent.com/', URL)
           
    # URL <- paste(strsplit(URL," ")[[1]], collapse = '%20')
    URL20 <- gsub(' ', '%20', URL)       
           
    if(verbose) {
           cat("\n\n"); print(URL); cat("\n")
    }
    
    if(grepl(type, "csv"))         
        return(read.csv(textConnection(getURL(URL20))))
  
    if(grepl(type, "function") | grepl(type, "script")) {
        if(verbose) {
           cat("\n"); print(head(readLines(textConnection(getURL(URL20))), 20)); cat("\n")
        }
        if(is.null(File)) {
           if(type == "script") {
              File.ASCII <- strsplit(URL, "/")[[1]]
              File.ASCII <- rev(File.ASCII)[1]
           } else
             File.ASCII <- tempfile()
        } else 
           File.ASCII <- File
        writeLines(paste(readLines(textConnection(getURL(URL20))), collapse = "\n"), File.ASCII)
        if(verbose) 
           cat("\n", type, "written to:", File.ASCII, "\n")
        if(deleteFileObj & is.null(File) & type == "function" )
           on.exit(file.remove(File.ASCII), add = TRUE)
    } 
       
    if(grepl(type, "function")) {
          s.name <- Source(File.ASCII)
          if(showNameOnly)
            cat("\n", s.name, "\n")
          if(run) 
            eval(parse(text = s.name), envir = globalenv())(...)
          if(show)
             print(eval(parse(text = s.name), envir = globalenv()))
          if(viewOnly)   
             on.exit(rm(list = s.name, pos = globalenv()), add = TRUE)
          return(invisible(eval(parse(text = s.name), envir = globalenv())))
    }
     
    if(grepl(type, "script")) {
       if(run)
          source(File.ASCII)
       if(show)
          file.show(File.ASCII)
    }
     
    if(type %in% c("RData", "RPckageZip", "Binary")) {
        # https://stackoverflow.com/questions/18833031/download-rdata-and-csv-files-from-ftp-using-rcurl-or-any-other-method 
        # test <- load(rawConnection(getBinaryURL(URL20)))  # Does not work for me on binary RData files 
        
        if(is.null(File)) {
          if(type %in% "RPckageZip") 
             File.BINARY <- tempfile(fileext = ".zip")
          else
             File.BINARY <- tempfile()        
        } else {
          File.BINARY <- File
        }
        
       download.file(URL20, File.BINARY, mode = 'wb')
       
    if(type %in% "RData") {
          if(show)
             JRWToolBox::load(File.BINARY)
          if(!show)
             base::load(File.BINARY, .GlobalEnv)
    }
       
    if(type %in% "RPckageZip") {
          # install_local(File.BINARY)
          unzip(File)
          noZipName <- get.subs(File, sep = ".")
          noZipName <- paste(noZipName[-length(noZipName)], collapse = ".")
          if(is.null(shortName)) {
               shortName <- get.subs(noZipName, sep = "-")
               shortName <- paste(shortName[-length(shortName)], collapse = "-")
               file.rename(noZipName, shortName)
          }     
          if(!is.null(shortName))
             setwd(noZipName)
          zip(paste0(shortName, ".zip"), files = shortName)
          install.packages(paste0(shortName, ".zip"),  repos = NULL, type = "win.binary")
          if(!is.null(shortName))
             setwd("..")
       }
    }
     
    if(grepl(type, "pdfGitHub")) { 
        rgit::browseGitPDF(URL20)
    }
     
}








