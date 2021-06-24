

S_tidy <- function(File, gitPath = ifelse(is.null(subDir), paste0(repoPath., "/", branch, "/"), 
      paste0(repoPath., "/", branch, "/", subDir, "/")), branch = 'master', repoPath. = repoPath, subDir = 'R', ...) {

    JRWToolBox::lib(formatR)
        
    tempFile.R <- tempfile(fileext = "R")
    on.exit(file.remove(tempFile.R))
        
    if (!(is.character(substitute(File))))
        File <- paste0(deparse(substitute(File)), ".R")
    rgit::gitAFile(paste0(gitPath, File), File = tempFile.R, showNameOnly = FALSE, ...)     
    
    formatR::tidy_source(tempFile.R, width.cutoff = getOption("width") - 10)
}


