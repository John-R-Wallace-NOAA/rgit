S_RCurl <- function(File, gitPath = ifelse(is.null(subDir), paste0(repoPath., "/", branch, "/"), 
      paste0(repoPath., "/", branch, "/", subDir, "/")), branch = 'master', repoPath. = repoPath, subDir = 'R', show = TRUE, ...) {
                
    if (!(is.character(substitute(File))))
        File <- paste0(deparse(substitute(File)), ".R")
    rgit::gitAFile_RCurl(paste0(gitPath, File), show = show, ...)     
}
