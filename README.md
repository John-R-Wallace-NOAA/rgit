# rgit

Install with:

      remotes::install_github("John-R-Wallace-NOAA/rgit")

rgit requires the git app (https://git-scm.com/downloads) to be installed.  You will be asked for user credentials at first use.


Look at the git() wrapper function from this repo and show how it could be pushed back to here:

    
    repoPath <- "John-R-Wallace-NOAA/rgit"  # Set the repoPath to the one you will be using.
    
    S(git) # Pull the file directly from GitHub with all comments shown and long line width 
    
    gitAFile(paste0(repoPath, "/master/R/git.R"), "script", File = "git.R", show = FALSE) # Pull and save 'git.R' to the working directory [getwd()] 
    
    # This would normally be done with a properly user configured gitEdit() function
    # gitEdit(git)
    
    file.show('git.R')  # Show the file in the working directory

    gitPush(git.R, subDir = 'R',  gitDir = repoPath, verbose = TRUE, deleteRepoAfterPush = FALSE) # Inspect what is going on.
    
    gitPush(git.R, subDir = 'R')  # A normal call with defaults. 
    
    
Verbose output below with default removal of cloned repo


    The directory: rgit will be removed.
    
    1: Stop?
    2: Delete the directory and continue?
    
    Selection: 2
    
    
    The home directory is:  C:/Users/Public/
    
    The git URL is: https://github.com/John-R-Wallace-NOAA/rgit.git
    
    The list of files to be pushed is:
     git.R gitPush.R
    
    Files and directories cloned from rgit:
       DESCRIPTION gitPush.R NAMESPACE R README.md 
    
    
     git.R was copied from C:/Users/Public/ to rgit/R 
    
     gitPush.R was copied from C:/Users/Public/ to rgit/R 
    
    Working directory is now: C:/Users/Public/rgit 
    
     R/git.R was added to the local repo.
    
     R/gitPush.R was added to the local repo.
    
    Files that are changed in the local repo of rgit have been pushed to GitHub.
    
    Working directory is now: C:/Users/Public 
    
    The local rgit directory was deleted.
    
