##Annual Summary Data for bio-collectors

###current year
year<-2020


##collectors Per Site
#load in data
x <- read.csv(paste0(data.path,"/collector.csv"))

#select current year of data
d1<-which(x$year==year)
x<-x[d1,]

###separate deep from regular for Fortune and Nine Mile Creek for 2020
x$site<-as.character(x$site)
x$site<-ifelse(x$collector %in% c(6661:6665), "Fortune2", x$site)
x$site<-ifelse(x$collector %in% c(6696:6700), "Nine Mile Creek2", x$site)###these aren't in csv file

#remove bad condition collectors
d2<-which(x$condition=="OK")
x<-x[d2,]

#number of good collectors per site
sum<-aggregate(x$collector, by= x["site"], length)

#add nine mile creek details
d3 <- data.frame(site="Nine Mile Creek 2", x=5)

sum<-rbind(sum,d3)

###load in observation data

y <- read.csv(paste0(data.path,"/biological.csv"))

#select current year of data
a1<-which(y$year==year)
y<-y[a1,]

#select only lobster
a2<-which(y$species=="Homarus americanus" )
y<-y[a2,]

###separate deep from regular for Fortune and Nine Mile Creek for 2020
y$site<-as.character(y$site)
y$site<-ifelse(y$collector %in% c(6661:6665), "Fortune2", y$site)
y$site<-ifelse(y$collector %in% c(6696:6700), "Nine Mile Creek2", y$site)###these aren't in csv file

##bring in YOY cut-offs
z <- read.csv(paste0(data.path,"/yoy_cutoff.csv"))
b1<-which(z$year==year)
z<-z[b1,]
z<-z[,c(1:3)]

###add in Fortune 2 YOY cut-off, same as Fortune
d4 <- data.frame(year=2020, site="Fortune2", mean=12.5)
z<-rbind(z, d4)

#put in summary table
sum<-merge(z, sum, all = TRUE)

names(sum)[3]<-"YOYSize"
names(sum)[4]<-"Collectors sampled"

#add yoy cut-off size to lobster data

y<-merge(y,z, all.x=TRUE)

y$YOY<-ifelse(y$size<=y$mean,1,0)

##yoy data
d5<-which(y$YOY==1)
yoy<-y[d5,]

SE <- function(x){###calculation of SE
   sd(x)/sqrt(length(x))
}

CV <- function(x){###calculation of CV based on Standard error
   ((sd(x)/sqrt(length(x)))/mean(x))
}

by1=yoy$site
by2=yoy$collector

yoy2<-aggregate(yoy$YOY, by=list(by1,by2), length)
names(yoy2)[1]<-"site"
names(yoy2)[2]<-"collector"
names(yoy2)[3]<-"YOY_Count"
yoy2$'YOYDensity(m2)'<-yoy2$"YOY_Count"/0.557

##add in collectors with no lobster
yoy2<-merge(x,yoy2, all.x=TRUE)
yoy2$`YOYDensity(m2)`<-ifelse(is.na(yoy2$`YOYDensity(m2)`), 0 ,yoy2$`YOYDensity(m2)`)
yoy2$YOY_Count <-ifelse(is.na(yoy2$YOY_Count), 0 ,yoy2$YOY_Count)

yoy3<-aggregate(yoy2$YOY_Count, by=yoy2['site'], sum)
names(yoy3)[2]<-"YOY_TotalCount"

a<-aggregate(yoy2$`YOYDensity(m2)`, by=yoy2['site'], mean)
b<-aggregate(yoy2$`YOYDensity(m2)`, by=yoy2['site'], SE)
c<-aggregate(yoy2$`YOYDensity(m2)`, by=yoy2['site'], CV)

yoy3<-cbind(yoy3,a[,2],b[,2],c[,2])

names(yoy3)[3]<-"YOYAverageDensity (m2)"
names(yoy3)[4]<-"YOYDensity_SE"
names(yoy3)[5]<-"YOYDensity_CV"

sum<-merge(sum, yoy3, all.x=TRUE)

##walkins
d6<-which(y$YOY==0)
wi<-y[d6,]

by1=wi$site
by2=wi$collector

wi2<-aggregate(wi$YOY, by=list(by1,by2), length)
names(wi2)[1]<-"site"
names(wi2)[2]<-"collector"
names(wi2)[3]<-"wi_Count"
wi2$'wiDensity(m2)'<-wi2$"wi_Count"/0.557

wi2<-merge(x,wi2, all.x=TRUE)
wi2$`wiDensity(m2)`<-ifelse(is.na(wi2$`wiDensity(m2)`), 0 ,wi2$`wiDensity(m2)`)
wi2$wi_Count <-ifelse(is.na(wi2$wi_Count), 0 ,wi2$wi_Count)

wi3<-aggregate(wi2$wi_Count , by=wi2['site'], sum)
names(wi3)[2]<-"OneYrPlus_TotalCount"

a<-aggregate(wi2$`wiDensity(m2)`, by=wi2['site'], mean)
b<-aggregate(wi2$`wiDensity(m2)`, by=wi2['site'], SE)
c<-aggregate(wi2$`wiDensity(m2)`, by=wi2['site'], CV)

wi3<-cbind(wi3,a[,2],b[,2],c[,2])

names(wi3)[3]<-"1Yr+_AverageDensity  (m2)"
names(wi3)[4]<-"1Yr+Ave.Density_SE"
names(wi3)[5]<-"1Yr+Ave.Density_CV"

sum<-merge(sum, wi3, all.x=TRUE)

sum$year<-2020

sum<-sum[order (sum$site),]

write.csv(sum, file=paste0(results.path, "/SGSL_Biocollectors_", year, "_PreliminaryResults.csv"))
