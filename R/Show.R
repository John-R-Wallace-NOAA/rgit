Show <- function(File, gitPath = ifelse(is.null(subDir), paste0(repoPath., "/", branch, "/"), 
         paste0(repoPath., "/", branch, "/", subDir, "/")), branch = 'master', repoPath. = repoPath, subDir = 'R', show = TRUE, ...) {
                
    if (!(is.character(substitute(File))))
        File <- paste0(deparse(substitute(File)), ".R")
        
    rgit::sourceFunctionURL(paste0('https://raw.githubusercontent.com/', gitPath, File))
    
    if(show) {
       s.name <- JRWToolBox::get.subs(File, '.')
       s.name <- s.name[-length(s.name)]
       s.name <- paste(s.name, collapse = '.')
       cat("\n")
       print(eval(parse(text = s.name), envir = globalenv()))
    } else
       invisible()
}

