library(gulf.utils)
library(gulf.data)

files <- dir(path = "data/raw/minilog", full.names = TRUE)

# Read the first file:
x <- read.minilog(file = files[1], project = "collectors")

# Plot the first file:
plot(time(x), x$temperature, pch = 21, bg = "grey", cex = 0.5, 
     xlab = "Date", ylab = "Temperature", main = header(x)$Study.Description)
