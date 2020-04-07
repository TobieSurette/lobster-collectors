# Load test image:
x <- read.csv("/Users/crustacean/Desktop/Lobster/Collector Data 2019.csv", stringsAsFactors = FALSE)   
str <- names(x)

str <- gsub("Size.CL..CW.or.TL", "size", str)
str <- gsub("Collector.Number", "colllector", str)
str <- gsub("Notes", "colllector", str)
names(x) <- tolower(str)

hist(x$size, n = 200, col = "grey")
   
