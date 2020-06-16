
S <- function(File, show = TRUE, ...) {
    if (!(is.character(substitute(File))))
        File <- deparse(substitute(File))

     rgit::gitAFile(paste0(repoPath, "/master/R/", File, ".R"), show = show, ...)     
}



