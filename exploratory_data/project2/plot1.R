
# set working directory
setwd('c:\\webwork\\dscoursera\\exploratory_data\\project2\\')

# load data
NEI <- readRDS("data/summarySCC_PM25.rds")


# sum of each emissions per emission type per year
library(plyr)
NEI_TOTAL <- ddply(NEI, c("year"),summarise,TotalEmissions=sum(Emissions))

# line plot x-axis years , y-axis type of source
library(datasets) 
with(NEI_TOTAL, plot(year, TotalEmissions, main = " Total US PM25 Emissions Trends", type="l", ylab="Emissions"))

dev.copy(png, file = "plot1.png") 
dev.off() 