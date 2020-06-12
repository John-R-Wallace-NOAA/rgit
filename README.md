# rgit

rgit requires the git app (https://git-scm.com/downloads) to be installed.  At first use you will asked for user credentials.


Look at the git() wrapper function from this repo and show how it ccould be pushed back to here:


    repoPath <- "John-R-Wallace-NOAA/rgit"
    
    git <- S(git) # Show file directly from GitHub with all comments shown and long line width 
                  #      (remotes::install_github() shortens line width)

    capture.output(cat("git <- "), file = 'git.R') # Capture cat() output to getwd()
    capture.output(git, file = 'git.R', append = TRUE) # Append git output

    gitPush(git.R, subDir = 'R',  gitDir = repoPath, verbose = TRUE, deleteRepoAfterPush = FALSE) # Inspect what is going on.
    
    gitPush(git.R, subDir = 'R')  # A normal call with defaults. 
