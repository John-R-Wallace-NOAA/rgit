
S <- function(File, gitPath = ifelse(is.null(subDir), paste0(repoPath., "/", branch, "/"), 
      paste0(repoPath., "/", branch, "/", subDir, "/")), branch = 'master', 
      repoPath. = ifelse(environmentName(environment(File)) %in% c("", "R_GlobalEnv"), repoPath, paste0(packageName, '/', environmentName(environment(File)))),
      packageName = "John-R-Wallace-NOAA", subDir = 'R', show = TRUE, verbose = FALSE, ...) {
      
  ' # To only view the file and not save it to R_GlobalEnv, use S(..., viewOnly = TRUE) '
  
    if(!(is.character(substitute(File))))
         File.Name <- deparse(substitute(File))  
         
    Try <- try(rgit::gitAFile(paste0(gitPath, File.Name, ".R"), showNameOnly = FALSE, show = FALSE, ...))
    if(inherits(Try, "try-error"))
       stop(paste0("\n\nEnvironment Name of File: ", environmentName(environment(File)), "; gitPath = ", gitPath, "\n\n"))
    
    if(verbose)
       cat(paste0("\n\nEnvironment Name of File: ", environmentName(environment(File)), "; gitPath = ", gitPath, "\n\n"))
    else 
       gitPath <- gitPath # Needed for file path in temp folder to be found (???)   
       
    rgit::gitAFile(paste0(gitPath, File.Name, ".R"), show = show, ...)  
}
