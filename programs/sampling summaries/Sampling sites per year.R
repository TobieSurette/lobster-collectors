library(gulf.utils)

output <- "png"  # or ""
language <- "english"
resolution <- 75 # Image resolution ppi

if (language == "english"){
   file <- "sampling summaries/figures/Sampling sites per year_en"
   xlab <- "Year"
}
if (language == "french"){
   file <- "sampling summaries/figures/Sampling sites per year_fr"
   xlab <- "Année"
}
x <- read.csv("data/site.csv", header = TRUE, stringsAsFactors = FALSE)

m <- table(x$year, x$site)

years <- as.numeric(rownames(m))
sites <- colnames(m)

if (output == "png") png(filename = paste0(file, ".png"), width = 6.5, height = 5, res = resolution, units = "in")

par(mar = c(5, 9, 2, 2) + 0.1)

image(years, 1:ncol(m), m, xlab = "", ylab = "", xaxt = "n", yaxt = "n", col = c("white", "grey80"))

# Grid lines:
for (i in 1:length(years)) lines(rep(years[i]-0.5, 2), par("usr")[3:4], col = "grey70")
for (i in 1:length(sites)) lines(par("usr")[1:2], rep(i-0.5, 2),col = "grey70")

# Tick labels:
axis(1, at = years[seq(1, length(years), by = 2)], cex = 0.75, las = 2)
axis(1, at = years[seq(2, length(years), by = 2)], cex = 0.75, las = 2)
axis(2, at = seq(1, length(sites), by = 2), labels = sites[seq(1, length(sites), by = 2)], cex = 0.6, las = 2)
axis(2, at = seq(2, length(sites), by = 2), labels = sites[seq(2, length(sites), by = 2)], cex = 0.6, las = 2)
mtext(xlab, 1, 3.5, cex = 1.5)
box()

if (output != "") dev.off()
