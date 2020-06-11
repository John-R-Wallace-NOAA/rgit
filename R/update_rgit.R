
update_rgit <- function(quiet = FALSE, ...) {

   if(any(search() %in% "package:rgit"))
      detach("package:rgit")
   
   JRWToolBox::lib("John-R-Wallace-NOAA/rgit", quiet = quiet, ...)
}

