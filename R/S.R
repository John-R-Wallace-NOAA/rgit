
S <- function(File, repoPath. = repoPath, gitPath = paste0(repoPath., "/master/", subDir, "/"), subDir = 'R', show = TRUE, ...) {
    if (!(is.character(substitute(File))))
        File <- paste0(deparse(substitute(File)), ".R")
    rgit::gitAFile(paste0(gitPath, File), show = show, ...)     
}


