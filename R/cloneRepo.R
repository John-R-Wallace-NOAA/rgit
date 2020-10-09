

cloneRepo <- function(repoPath. = repoPath, gitUserName = gitName, gitUserEmail = gitEmail, autoExit = TRUE)  {

    # Download function and scripts from GitHub (you will be asked once for your password, if you are not already logged into GitHub).
    rgit::git(paste0("config --global user.name --replace-all '", gitUserName, "'"), autoExit = autoExit)
    rgit::git(paste0("config --global user.email --replace-all '", gitUserEmail, "'"), autoExit = autoExit)
    rgit::git(paste0("clone https://github.com/", repoPath., ".git"), autoExit = autoExit)
}