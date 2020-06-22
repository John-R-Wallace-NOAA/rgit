
setChromeBrowser <- function( forceChrome = TRUE)  {

   if(forceChrome)
      options(browser = "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")
   
   if(!forceChrome)
      options(browser = NULL)
}


