library(gulf.utils)
library(gulf.data)

year <- 2018
files = dir.github(username = 'TobieSurette', repo = 'lobster-collectors')
files <- files[intersect(grep('minilog', files), grep(as.character(year), files))]

x <- NULL
for (i in 1:length(files)){
   tmp <- read.minilog(file = files[i])
   
   # Device name:
   device <- as.character(header(tmp)$Source.Device)

   # Extract site:
   site <- as.character(header(tmp)$Study.Description)
   site <- strsplit(str, paste0(" ", year))[[1]][1]
   site <- str
  
   tmp <- cbind(device = device, site = site, tmp)
   x  <- rbind(x, tmp)    
}

excel(x)
