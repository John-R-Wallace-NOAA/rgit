

gitEqual <- function(..., list = character(), Func, verbose = FALSE, subDir = 'R') {
    ' # Remote '
	dots <- match.call(expand.dots = FALSE)$...
    if (length(dots) && !all(vapply(dots, function(x) is.symbol(x) || 
        is.character(x), NA, USE.NAMES = FALSE))) 
        stop("... must contain names or character strings")
    names <- vapply(dots, as.character, "")
    if (length(names) == 0L) 
        names <- character()
    Func.Name <- .Primitive("c")(list, names)
	
	if(verbose) cat("\n\n", Func.Name, "\n")
	
	JRWToolBox::Source(paste0(Func.Name, '.R'))
	assign(Func.Name, eval(parse(text = Func.Name)), pos = 1)
	if(verbose) {
	
	  cat("\nR object in Global area:", ls(pattern = Func.Name), "\n\n")
	   print(eval(parse(text = Func.Name)))
	   
	}
	
	argList <- list(paste0(Func.Name, '.R'), show = FALSE, viewOnly = TRUE, verbose = verbose, subDir = subDir)
	Remote <- do.call(S, argList)
	if(verbose) print(Remote); flush.console()
	
	all.equal(eval(parse(text = Func.Name)), Remote)
}	
	


