
gitPushQ <- function(..., verbose = FALSE, checkEquality = FALSE) {
    
   # The oddity of calling a character vector 'list' kept from the rm() function code.
   dots <- match.call(expand.dots = FALSE)$...
   if (length(dots) && !all(vapply(dots, function(x) is.symbol(x) || 
       is.character(x), NA, USE.NAMES = FALSE))) 
       stop("... must contain names or character strings")
   names <- vapply(dots, as.character, "")
   if (length(names) == 0L) 
       names <- character()
   list <- .Primitive("c")(names)
   
   list <- c(list, list(verbose = verbose, checkEquality = checkEquality) )
  
   do.call(gitPush, list)
}
