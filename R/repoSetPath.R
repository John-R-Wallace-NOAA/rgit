repoSetPath <- function(repo) {
   PD <- packageDescription(repo)
   if(is.null(PD$RemoteSubdir))
      assign('repoPath', paste0(PD$GithubUsername, "/", PD$GithubRepo), pos = 1)
   if(!is.null(PD$RemoteSubdir))
      assign('repoPath', paste0(PD$GithubUsername, "/", PD$GithubRepo, "/", PD$RemoteSubdir), pos = 1)   
   repoPath
}
