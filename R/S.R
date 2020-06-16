
S <- function(File, repoPath. = repoPath, show = TRUE, ...) {
    assign('repoPath.', repoPath., pos = 1) # Need this so gitAFile sees the external repoPath
    if (!(is.character(substitute(File))))
        File <- deparse(substitute(File))

     rgit::gitAFile(paste0(repoPath., "/master/R/", File, ".R"), show = show, ...)     
}



