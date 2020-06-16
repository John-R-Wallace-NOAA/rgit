# rgit

Install with:

      remotes::install_github("John-R-Wallace-NOAA/rgit")

rgit requires the git app (https://git-scm.com/downloads) to be installed.  You will be asked for user credentials at first use.
#
The git() function is a wrapper for the git app, and hence any git action be done from within R:

    rgit::git("config --global user.name John-R-Wallace-NOAA")
    
    gitEmail <- "john.wallace@noaa.gov"
    rgit::git(paste0("config --global user.email '", gitUserEmail, "'"))
    
    rgit::git("clone https://github.com/John-R-Wallace-NOAA/rgit.git")
    
    i <- 'gitEdit.R'
    rgit::git(paste0('add ', i))
    ...
    
    rgit::git('commit --amend --no-edit --allow-empty')  
    rgit::git('push -u -v --force origin master')


#
Example usage:

Look at the git() wrapper function from this repo and show how it could be pushed back to here (with the correct permissions):

    library(rgit)
    # Use with GitHub
    # Set the GitHub repoPath, gitName, and gitEmail to the ones you will be using.
    repoPath <- "John-R-Wallace-NOAA/rgit"
     gitName <- "John-R-Wallace-NOAA" 
    gitEmail <- "john.wallace@noaa.gov"

    # Pull the file directly from GitHub to view with all comments shown and unchanged user line widths  
    #    (functions installed with the remotes or devtools packages have comments stripped and shortened line widths)
    S(git, viewOnly = TRUE) 
    
    # Pull and save 'git.R' to the working directory [getwd()] 
    gitAFile(paste0(repoPath, "/master/R/git.R"), "script", File = "git.R", show = FALSE)  
    
    # This would normally be done with a properly user configured gitEdit() function
    # gitEdit(git)
    
    # Show the file in the working directory
    file.show('git.R')  
    
    # Inspect what is going on with verbose = TRUE and inspecting the undeleted repo (would need permissions to push)
    gitPush(git.R, subDir = 'R',  gitDir = repoPath, verbose = TRUE, deleteRepoAfterPush = FALSE) 
    
    
    # As in rm() and other functions, the dots ('...') come first so the other arguments need to be fully named
    args(gitPush)  
    function (..., list = character(), gitDir = repoPath, subDir = NULL, 
        gitUserName = gitName, gitUserEmail = gitEmail, deleteRepoAfterPush = TRUE, 
        verbose = FALSE) 
    
    # A normal call with defaults
     gitPush(git.R, subDir = 'R')  # Full argument name 'subDir' used 
    
Verbose output with 2 files (git.R & gitPush.R) being pushed and the default removal of the cloned repo:
 
    gitPush(git.R, gitPush.R, subDir = 'R', verbose = TRUE)  # As in rm(), a mixture of quoted and unquoted file names can be used

    The local directory: rgit will be removed.
    
    1: Stop?
    2: Delete the directory and continue?
    
    Selection: 2
    
    
    The local working directory is:  C:/Users/Public/
    
    The git URL is: https://github.com/John-R-Wallace-NOAA/rgit.git
    
    The list of files to be pushed is:
     git.R gitPush.R
    
    Files and directories cloned from remote rgit repo:
       DESCRIPTION gitPush.R NAMESPACE R README.md 
    
    
     git.R was copied from C:/Users/Public/ to rgit/R 
    
     gitPush.R was copied from C:/Users/Public/ to rgit/R 
    
    Working directory is now: C:/Users/Public/rgit 
    
     R/git.R was added to the local repo.
    
     R/gitPush.R was added to the local repo.
    
    Files that are changed in the local repo of rgit have been pushed to GitHub.
    
    Working directory is now: C:/Users/Public 
    
    The local rgit directory was deleted.
    
Until I add a verify feature, on first use in a new repo doublecheck that the commit times on GitHub are recently changed.  Only files with actual changes will have recently changed commit times.
# 
Changing accounts:

To change accounts, that the Windows git app uses, go to:

    Control Panel > User Accounts > Credential Manager > Window Credentials > Generic Credentials

and remove the entry for the current account.  See:  https://snede.net/git-does-not-remember-username-password/

On next use of the Windows git app you will be prompted for the different account's credentials.


