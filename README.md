# rgit

Install with:

      remotes::install_github("John-R-Wallace-NOAA/rgit")

rgit requires the git app (https://git-scm.com/downloads) to be installed.  You will asked for user credentials at first use.


Look at the git() wrapper function from this repo and show how it could be pushed back to here:

    
    repoPath <- "John-R-Wallace-NOAA/rgit"  # Set the repoPath to the one you will be using.
    
    S(git) # Pull the file directly from GitHub with all comments shown and long line width 
    
    gitAFile(paste0(repoPath, "/master/R/git.R"), "script", File = "git.R", show = FALSE) # Pull and save 'git.R' to the working directory [getwd()] 
    
    # This would normally be done with a properly user configured gitEdit() function
    # gitEdit(git)
    
    file.show('git.R')  # Show the file in the working directory

    gitPush(git.R, subDir = 'R',  gitDir = repoPath, verbose = TRUE, deleteRepoAfterPush = FALSE) # Inspect what is going on.
    
    gitPush(git.R, subDir = 'R')  # A normal call with defaults. 
