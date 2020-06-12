# rgit


    repoPath <- "John-R-Wallace-NOAA/rgit"
    
    git <- S(git) # Shows file directly from GitHUb with all comments shown and long line width (remotes::install_github() shortens line width)

    capture.output(cat("git <- "), file = 'git.R') # Capture git output to getwd()
    capture.output(git, file = 'git.R', append = TRUE) # Capture git output to getwd()
    file.show('git.R')  # Show git.R


    gitPush(git.R, subDir = 'R', verbose = TRUE, deleteRepoAfterPush = FALSE)
