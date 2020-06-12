
S <- function(File, show = TRUE, ...) {
    if (!(is.character(substitute(File))))
        File <- deparse(substitute(File))

     gitAFile(paste0(repoPath, File, ".R"), show = show, ...)     
}



