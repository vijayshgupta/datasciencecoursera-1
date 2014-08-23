
# set working directory
setwd('c:\\webwork\\datasciencecoursera\\exploratory_data\\project2\\')

# load data
NEI <- readRDS("data/summarySCC_PM25.rds")


# sum of each emissions per emission type per year
library(plyr)
NEI_TOTAL <- ddply(NEI, c("type","year"),summarise,TotalEmissions=sum(Emissions))

# line plot x-axis years , y-axis type of source
library(datasets) 
with(NEI_TOTAL, plot(year, TotalEmissions, main = "PM25 Emissions Trends", type="n", ylab="Emissions"))
with(subset(NEI_TOTAL,NEI_TOTAL$type=="NON-ROAD"), lines(year, TotalEmissions, col = "blue"))
with(subset(NEI_TOTAL,NEI_TOTAL$type=="NONPOINT"), lines(year, TotalEmissions, col = "red"))
with(subset(NEI_TOTAL,NEI_TOTAL$type=="ON-ROAD"), lines(year, TotalEmissions, col = "green"))
with(subset(NEI_TOTAL,NEI_TOTAL$type=="POINT"), lines(year, TotalEmissions, col = "black"))
legend("topright", pch = 1, col = c("blue","red","green","black"), legend = c("NON-ROAD","NONPOINT","ON-ROAD","POINT"), cex=.8)

dev.copy(png, file = "plot1.png") 
dev.off() 