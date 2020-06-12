# rgit


    repoPath <- "John-R-Wallace-NOAA/rgit"
    
    git <- S(git) # Show file directly from GitHUb with all comments shown and long line width 
                  #      (remotes::install_github() shortens line width)

    capture.output(cat("git <- "), file = 'git.R') # Capture cat() output to getwd()
    capture.output(git, file = 'git.R', append = TRUE) # Append git output

    gitPush(git.R, subDir = 'R', verbose = TRUE, deleteRepoAfterPush = FALSE)
