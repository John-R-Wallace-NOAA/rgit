# rgit

Install with:

      remotes::install_github("John-R-Wallace-NOAA/rgit")

rgit requires the git app (https://git-scm.com/downloads) to be installed.  You will be asked for user credentials at first use.


Look at the git() wrapper function from this repo and show how it could be pushed back to here (with the correct permissions):

    # Set the repoPath to the one you will be using.
    repoPath <- "John-R-Wallace-NOAA/rgit"
    
    # Pull the file directly from GitHub with all comments shown and long line width 
    S(git) 
    
    # Pull and save 'git.R' to the working directory [getwd()]. 
    gitAFile(paste0(repoPath, "/master/R/git.R"), "script", File = "git.R", show = FALSE)  
    
    # This would normally be done with a properly user configured gitEdit() function.
    # gitEdit(git)
    
    # Show the file in the working directory.
    file.show('git.R')  
    
    # Inspect what is going on with verbose = TRUE and inspecting the undeleted repo.
    gitPush(git.R, subDir = 'R',  gitDir = repoPath, verbose = TRUE, deleteRepoAfterPush = FALSE) 
    
    # A normal call with defaults.
    gitPush(git.R, subDir = 'R')   
    
    
Verbose output below with default removal of cloned repo

    gitPush(git.R, gitPush.R, subDir = 'R', verbose = TRUE)

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
    
