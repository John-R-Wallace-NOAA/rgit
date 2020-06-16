git <- function (gitCommand, autoExit = TRUE) 
{
    shell(paste0("echo git ", gitCommand, " > run.bat"))
    if(autoExit)
        shell("echo exit >> run.bat")
    shell("start /wait run.bat")
    shell("del run.bat")
}   



