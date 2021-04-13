###script to make annual length frequency table. 

rm(list = ls())
graphics.off()
library(gulf)
library(gulf.data)
library(gulf.graphics)
library(gulf.spatial)
library(readxl)

format = "jpg"


#library("Hmisc", lib.loc="~/R/win-library/3.5")
#library("ggplot2", lib.loc="~/R/win-library/3.5")

year<-2020

b <- read.csv(locate(file = "^biological.csv"))

b <- b[b$species == "Homarus americanus", ]

b <- b[b$year  == year, ]

width=7
height=5
format = "jpg"



file <- paste0("Lobster_Collectors_LengthFrequencies_", year)
if (format == "jpg") jpeg(file = paste0("results/figures/", file, ".jpeg"), width = 600 * 8, height = 600 * 8, res = 75 * 8)
if (format == "pdf") pdf(file = paste0("results/figures/", file, ".pdf"), width = 8, height = 8)

par(mar = c(6, 6, 6, 6))


h<-hist(b$size, width = 1, space = 0,
        names.arg = NULL, legend.text = NULL, beside = FALSE,
        horiz = FALSE, density = NULL, angle = 45,
        col = "grey75", border = "grey28",
        main = NULL, sub = NULL, xlab = NULL, ylab = NULL,
        xlim=c(0, 60),
        ylim = c(0, 75), 
        xaxs="i",###take out offset
        yaxs="i",##take out offset
        xpd = FALSE, log = "",
        axes = FALSE, axisnames = FALSE,
        inside = TRUE, plot = TRUE, axis.lty = 0, offset = 0,
        add = FALSE, args.legend = NULL, breaks=seq(0, 60, by=1)) 

     
#text(h$mids,h$counts,labels=h$counts, adj=c(0.5, -0.5), cex=0.6)###use histogram values to add count to each column

axis(2, at=(seq(0,75, by=25)), labels=(seq(0, 75, by=25)), las=2, pos=0, tck=-0.02)##formatted so labels are horizontal and have a comma
axis(1, at=(seq(0, 60, by=5)), labels=(seq(0, 60, by=5)),tck=-0.02, cex=0.9)


mtext("Carapace length (mm)", side=1, line=2.5, cex=1.0)
mtext("Number of lobsters", side=2, line=3.0, cex=1.0, las=0)
#mtext("Landings (t)", side=2, line=4, cex=1.2, pos=0)###title on left side of graph. 
if (format != "") dev.off()


