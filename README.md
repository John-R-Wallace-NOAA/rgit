# rgit

Install with:

      remotes::install_github("John-R-Wallace-NOAA/rgit")

rgit requires the git app (https://git-scm.com/downloads) to be installed.  You will be asked for user credentials at first use.
#
The git() function is a wrapper for the git app, and hence any git action can be done from within R. For example, assume 'gitPush.R' with a changed comment is in the current working directory. Below are the steps for pushing 'gitPush.R' with a "Comment changed" message. Note that the argument 'autoExit' is set to FALSE, so that each step in the Command Window can be inspected. Type 'exit' to exit the Command Window to move to the next step. Once the repo is cloned, 'git status' or any other git command can be given in the Command Window (git push requires the correct permissions):

    getwd()  # Check working directory
    file.show('gitPush.R')   # Check the file in the working directory that is to be pushed 
    
    system("rm -r -f , rgit") # Make sure the repo directory is deleted
    git('config --global --replace-all user.name "John-R-Wallace-NOAA"', autoExit = FALSE)
    git('config --global --replace-all user.email "john.wallace@noaa.gov"', autoExit = FALSE)
    git('clone https://github.com/John-R-Wallace-NOAA/rgit.git', autoExit = FALSE)
    file.copy('gitPush.R', 'rgit/R', overwrite = TRUE)
    setwd('rgit')
    git('add R/gitPush.R', autoExit = FALSE)
    git('commit --amend --no-edit -m"Comment changed"', autoExit = FALSE) # The informative comment comes after -m
    git('status', autoExit = FALSE) # This status is confusing (to me at least)
    git('push -u -v --force-with-lease origin master', autoExit = FALSE)  # 'git status' makes sense now.  
    setwd('../')
    system("rm -r -f rgit") # Delete repo after push - inspect it before deletion if you like
    getwd()  # Check for original working directory
    
All these steps are in the function gitPush() which can be called with autoExit = FALSE, but using verbose = TRUE is a good first step when diagnosing problems. Note that quotes, on the file name in current working directory to be pushed, are optional, and that gitPush() allows single or double quotes on message argument:

    gitPush(gitPush.R, message = 'Fixed another comment', verbose = TRUE)   
    
The default subdirectory to push to is 'R'; to push a file to the main root of a repo use: subDir = NULL

#
### More example usage with additional information

Look at the git() wrapper function and show how it could be pushed back to this repo (with the correct permissions):

    library(rgit)
    # Use with GitHub
    # Set the GitHub repoPath, gitName, and gitEmail to the ones you will be using.
    repoPath <- "John-R-Wallace-NOAA/rgit"
     gitName <- "John-R-Wallace-NOAA" 
    gitEmail <- "john.wallace@noaa.gov"

    # Use the function S() (for Show and/or Save) to pull the file directly from GitHub to view with all comments shown 
    #    and with unchanged user line widths (functions installed with the remotes or devtools packages have comments 
    #    stripped and have shortened line widths)
    S(git, viewOnly = TRUE) 
    
    # Pull and save 'git.R' to the working directory [getwd()] 
    gitAFile(paste0(repoPath, "/master/R/git.R"), "script", File = "git.R", show = FALSE)  
    
    # This would normally be done with a properly user configured gitEdit() function
    # gitEdit(git)
    
    # Show the file in the current working directory
    file.show('git.R')  
    
    # Inspect what is going on with verbose = TRUE and by also looking at the undeleted repo
    gitPush(git.R, subDir = 'R',  gitDir = repoPath, verbose = TRUE, deleteRepoAfterPush = FALSE) 
    
    
    # As in rm() and other functions, when the ellipses ('...') come first the other arguments need to be fully named
    args(gitPush)  
    function (..., list = character(), gitDir = repoPath, subDir = NULL, 
        gitUserName = gitName, gitUserEmail = gitEmail, deleteRepoAfterPush = TRUE, 
        verbose = FALSE) 
    
    # If an argument is used, the full name needs to be given
    gitPush(git.R, subDir = 'R') 
    
Verbose output with 2 files (git.R & gitPush.R) being pushed and the default removal of the cloned repo:
   
    # As in rm(), a mixture of quoted and unquoted file names can be used
    gitPush(git.R, gitPush.R, subDir = 'R', verbose = TRUE)  

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
    
On first use in a new repo, double check that the commit times on GitHub are recently changed.  Only files with actual changes will have recently changed commit times.

Checking that files in the remote repo are same as those in the local working directory can be accomplished by following this example with gitPush:

    gitPush_Remote <- S(gitPush, show = F, viewOnly = TRUE) # gitPush isn't saved to [[.GlobalEnv]] when viewOnly = TRUE 
    source('gitPush.R')
    all.equal(gitPush_Git, gitPush_Remote)
    rm(gitPush_Git, gitPush_Remote)

# 
### Changing accounts

To change accounts, that the Windows git app uses, go to:

    Control Panel > User Accounts > Credential Manager > Window Credentials > Generic Credentials

and remove the entry for the current account.  See:  https://snede.net/git-does-not-remember-username-password/

On next use of the Windows git app, where credentials are needed e.g. doing a push, you will be prompted for the different account's credentials.

#
### Retrieving Git info from R

Get a situation report on your current Git/GitHub status:

    usethis::git_sitrep()
    
Retrieve GitHub personal access token:

    Sys.getenv('GITHUB_PAT')

   
   
    
    



