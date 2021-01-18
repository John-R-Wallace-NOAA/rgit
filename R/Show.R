

Show <- function(File, gitPath = ifelse(is.null(subDir), paste0(repoPath., "/", branch, "/"), 
         paste0(repoPath., "/", branch, "/", subDir, "/")), branch = 'master', repoPath. = repoPath, subDir = 'R', show = TRUE, ...) {
                
    if (!(is.character(substitute(File))))
        File <- paste0(deparse(substitute(File)), ".R")
		
    rgit::sourceFunctionURL(paste0('https://raw.githubusercontent.com/', gitPath, File))
	
    if(show) {
	   fileName <- JRWToolBox::get.subs(File, '.')
       fileName <- fileName[-length(fileName)]
       fileName <- paste(fileName, collapse = '.')
	   cat("\n")
       print(eval(parse(text = fileName), envir = globalenv()))
    } else
       invisible()
}


