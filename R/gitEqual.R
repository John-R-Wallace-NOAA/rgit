
gitEqual <- function(..., list = character(), branch = 'master', subDir = 'R', verbose = FALSE) {
    
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
    
    if(exists(Func.Name, where = globalenv(), inherits = FALSE))  { 
       OLD <- get(Func.Name, pos = globalenv())
       on.exit(assign(Func.Name, OLD, pos = globalenv()))
     } else
       on.exit(rm(list = Func.Name, pos = globalenv())) # viewOnly arg doesn't appear to work in gitAFile() when called inside a function ???
    
    argList <- list(paste0(Func.Name, '.R'), show = FALSE, branch = branch, subDir = subDir, verbose = verbose)
    Remote <- do.call(rgit::S, argList)
    
    
    if(verbose) {
        cat("\n\nRemote on ", repoPath, ":\n\n", sep = "")
        print(Remote); flush.console()
        cat("\n")
    }
    
    environment(Remote) <- environment(Local)
    print(out <- base::all.equal(Local, Remote))
    cat("\n")
    invisible(out)
}    
    

