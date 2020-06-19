
gitEqual <- function(Func, verbose = FALSE, ...) {
    
  Func.Name <- deparse(substitute(Func))
	if(verbose) cat("\n\n", Func.Name, "\n")
	
	JRWToolBox::Source(paste0(Func.Name, '.R'))
	assign(Func.Name, eval(parse(text = Func.Name)), pos = 1)
	if(verbose) print(eval(parse(text = Func.Name)))
	
	argList <- c(list(paste0(Func.Name, '.R'), show = FALSE, viewOnly = TRUE, verbose = verbose), ...)
	Remote <- do.call(S, argList)
	if(verbose) print(Remote); flush.console()
	
	all.equal(eval(parse(text = Func.Name)), Remote)
}	
	
	
