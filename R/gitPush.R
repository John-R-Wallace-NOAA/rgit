
gitPush <- function(..., list = character(), repoPath. = repoPath, branch = 'master', subDir = 'R', message = "Changed with rgit", messageB = "", roxygenize = FALSE, clean = FALSE, gitUserName = gitName, 
                     gitUserEmail = gitEmail, autoExit = TRUE, deleteRepoAfterPush = TRUE, verbose = FALSE, checkEquality = TRUE)  {

    # To not use a sub-directory set the 'subDir' argument to NULL
    # Initial setup - the oddity of calling a character vector 'list' kept from the rm() function code.
    
    dots <- match.call(expand.dots = FALSE)$...
    if (length(dots) && !all(vapply(dots, function(x) is.symbol(x) || is.character(x), NA, USE.NAMES = FALSE))) 
        stop("... must contain names or character strings")
    names <- vapply(dots, as.character, "")
    if (length(names) == 0L) 
        names <- character()
    list <- .Primitive("c")(list, names)
    list.R <- paste(list, ".R", sep = "")
    
    HomeDir <- paste0(getwd(), "/")
    
    repo <- JRWToolBox::get.subs(repoPath., "/")[2] # Avoid the list produced by strsplit() (I wrote get.subs() to work in both R and SPlus before strsplit() came out.) 
    if(dir.exists(repo)) {
    
       cat(paste0("\nThe directory: ", repo, " will be removed.\n"))
       switch(menu(c("Stop?", "Delete the directory and continue?")) + 1,
           stop("Stopped by user."), stop("Stopped by user."), cat("\n"))
    }
   
    system(paste0("rm -r -f ", repo)) # Make sure the repo directory is deleted 
    
    # Download function and scripts from GitHub (you will be asked once for your password, if you are not already logged into GitHub).
    rgit::git(paste0("config --global user.name --replace-all '", gitUserName, "'"), autoExit = autoExit)
    rgit::git(paste0("config --global user.email --replace-all '", gitUserEmail, "'"), autoExit = autoExit)
    rgit::git(paste0("clone -b ", branch,  " https://github.com/", repoPath., ".git"), autoExit = autoExit)
    
    if(verbose) {
       cat("\n\nThe local working directory is: ", HomeDir)
       cat("\n\nThe git URL is: https://github.com/", repoPath., ".git", sep = "")
       cat("\n\nThe list of files to be pushed is:\n", list.R)
       cat("\n\nFiles and directories cloned from the remote ", repo, " repo:\n", sep = "")
       cat("  ", vapply(list.files(repo), as.character, ""), "\n")
    }
    
    # Copy the files to the local repo, add the files to the repo, and push the repo (only files that are changed are moved, that's how git push works).
    
    for (i in list.R)  {
    
      file.copy(i, paste0(repo, "/", subDir), overwrite = TRUE)
      if(verbose)
         cat("\n", i, "was copied from", HomeDir, "to", paste0(repo, "/", subDir), "\n")
    }
    
    setwd(paste0(HomeDir, repo))
    if(verbose) 
        cat("\nWorking directory is now:", getwd(), "\n")
    
    for (i in list.R)  {
    
      if(!is.null(subDir))
          i <- paste0(subDir,"/", i)
      rgit::git(paste0('add ', i), autoExit = autoExit)
      if(verbose)
         cat("\n", i, "was added to the local repo.\n")
    }
    
    if(roxygenize) {
    
       require(roxygen2)
       roxygen2::roxygenize(clean = clean)
       
       for (i in list)  {
         i <- paste0("man/", i, ".Rd")
         rgit::git(paste0('add ', i), autoExit = autoExit)
         if(verbose)
            cat("\n", i, "was added to the local repo.\n")
       } 
       rgit::git('add DESCRIPTION', autoExit = autoExit)
       rgit::git('add NAMESPACE', autoExit = autoExit)
       if(verbose)
            cat("DESCRIPTION and NAMESPACE were added to the local repo.\n")
    }    
    
    rgit::git(paste0('commit --amend --no-edit --allow-empty -m"', message, '" -m"', message2, '"'), autoExit = autoExit)  # The message text needs double quotes (") to work
    rgit::git(paste0('push -u -v --force-with-lease origin ', branch), autoExit = autoExit) 
        
    if(verbose)
       cat(paste0("\nFiles that are changed in the local repo of ", repo, " have been pushed to GitHub.\n"))
    
    setwd(HomeDir)
    if(verbose) 
        cat("\nWorking directory is now:", getwd(), "\n\n")
    
    if(deleteRepoAfterPush) {
       system(paste0("rm -r -f ", repo))
       if(verbose) 
          cat("The local", repo, "directory was deleted.\n\n")   
    }
    
    if(checkEquality) {
    
       if(length(list) == 1)
          cat("\nIs the file on the remote repo equal to the local file?:\n\n")
       else
          cat("\nAre the files on the remote repo equal to the local files?:\n\n")
          
       cat("Pausing for 30 seconds total to let the remote repo update\n")
       Sys.sleep(10); cat("10 secs\n")    
        
       cat("\nWith a correct call, gitPush() changes will be seen immediately on the GitHub web site. What takes a little time is for the changes to\n") 
          cat("   migrate to the '.git' URL where gitEqual() can access them. Under normal conditions, this is no longer then 30 seconds, but can, on rare\n") 
          cat("   occasions, take substantially longer. The way to check gitPush() changes, with no chance of delay, is to look at the repo on GitHub.\n")
          cat("   (A date and time stamp, in a comment on top of the file may be quicker then looking for changes in a file.)\n\n")  
      
       cat("\nWithout looking on GitHub, if the repo is slow to update, later try: rgit::gitEqual(<single_file>) on any file not found equal.\n\n")
       Sys.sleep(10); cat("20 secs\n")
    
       cat("\nIf there still is an issue make sure all arguments are spelled out fully, and try in this order: verbose = TRUE in the gitEqual() call;,\n")
           cat("    verbose = TRUE, autoExit = FALSE, and deleteRepoAfterPush = FALSE in the gitPush() call (changing one at a time).\n")
           
       cat("\nAfter becoming comfortable with gitPush()'s success, one can use 'gitPushQ()', which is a wrapper for gitPush()\n") 
          cat("    with checkEquality = FALSE as the default (and hence Quicker).\n") 
          cat("    Hence, another approach is to first run gitPushQ(), pause, and then check with gitEqual(). Repeat if gitEqual() is FALSE.\n\n")
       Sys.sleep(10); cat("30 secs\n")
       
       for(i in list) {
       
          cat("\n", i, ": ", rgit::gitEqual(list = i, branch = branch, subDir = subDir, verbose = verbose), "\n", sep = "")
      }
    }
    invisible()
}







