library(gulf.utils)

output <- "png" # "png"  # or ""
language <- "english"
file <- "sampling summaries/figures/Sampling"
resolution <- 75 # Image resolution ppi

if (language == "english"){
   xlab <- "Year"
   ylab <- "Month"
   lang.str <- "en"
}
if (language == "french"){
   xlab <- "Année"
   ylab <- "Mois"
   lang.str <- "fr"
}
x <- read.csv("data/site.csv", header = TRUE, stringsAsFactors = FALSE)
x$deployed <- julian(date(x$date.deployed))
x$retrieved <- julian(date(x$date.retrieved))

# Define years and sites:
years <- sort(unique(x$year))
sites <- sort(unique(x$site))

# Initialize sampling table:
m <- array(0, dim = c(year = length(years), day = 365, site = length(sites)))
dimnames(m) <- list(year = years, day = 1:365, site = sites)

# Calculate sampling table:
for (i in 1:length(years)){
   for (j in 1:length(sites)){
      xx <- x[x$year == years[i] & x$site == sites[j], ]
      if (nrow(xx) > 0){
         index <- ((1:365) >= xx$deployed) & ((1:365) <= xx$retrieved)
         m[as.character(years[i]), index, sites[j]] <- 1
      }
   }
}

# Define julian day for reference dates:
refdate <- julian(date(year = 2019, month = 6:11, day = 1))
names(refdate) <- month.name[6:11]

for (j in 1:length(sites)){
   if (output == "png") png(filename = paste0(file, " - ", sites[j], "_", lang.str, ".png"), 
                         width = 6.5, height = 6.5, res = resolution, units = "in")
   par(mar = c(5, 4, 2, 2) + 0.1)


   image(as.numeric(dimnames(m)[[1]]), as.numeric(dimnames(m)[[2]]), m[,,j], 
         xlab = "", ylab = "", xaxt = "n", yaxt = "n", col = c("white", "grey80"),
         ylim = c(152, 300))

   # Grid lines:
   for (i in 1:length(years)) lines(rep(years[i]-0.5, 2), par("usr")[3:4], col = "grey70")
   for (i in 1:length(refdate)) lines(par("usr")[1:2], rep(refdate[i], 2),col = "grey70")

   # Tick labels:
   axis(1, at = years[seq(1, length(years), by = 2)], cex = 0.75, las = 2)
   axis(1, at = years[seq(2, length(years), by = 2)], cex = 0.75, las = 2)
   at <- refdate[-length(refdate)] + diff(refdate) / 2
   labels <- names(refdate)[-length(refdate)]
   axis(2, at = at[seq(1, length(at), by = 2)], labels = labels[seq(1, length(at), by = 2)])
   axis(2, at = at[seq(2, length(at), by = 2)], labels = labels[seq(2, length(at), by = 2)])
   mtext(xlab, 1, 3.5, cex = 1.5)
   mtext(ylab, 2, 2.5, cex = 1.5)
   box()

   if (output != "") dev.off()
}
