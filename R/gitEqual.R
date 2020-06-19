

gitEqual <- function(..., list = character(), Func, verbose = FALSE, subDir = 'R') {
    
    dots <- match.call(expand.dots = FALSE)$...
    if (length(dots) && !all(vapply(dots, function(x) is.symbol(x) || 
        is.character(x), NA, USE.NAMES = FALSE))) 
        stop("... must contain names or character strings")
    names <- vapply(dots, as.character, "")
    if (length(names) == 0L) 
        names <- character()
    Func.Name <- .Primitive("c")(list, names)
    
    if(verbose) {
       cat("\n\nFunction Name:", Func.Name, "\n\n"); flush.console()
    }
    
    source(paste0(Func.Name, '.R'), local = TRUE)
    
    Local <- get(Func.Name)
    if(verbose) {
      cat("\n\nLocal file in ", getwd(), ":\n\n", sep = "")
      print(Local); flush.console()
    }
    
    argList <- list(paste0(Func.Name, '.R'), show = FALSE, viewOnly = TRUE, verbose = verbose, subDir = subDir)
    Remote <- do.call(S, argList)
    if(verbose) {
       cat("\n\nRemote on", repoPath, ":\n\n", sep = "")
       print(Remote); flush.console()
	   cat("\n")
    }
    
    print(out <- all.equal(Local, Remote))
	cat("\n")
	invisible(out)
}    
    


