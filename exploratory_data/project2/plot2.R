setwd('c:\\webwork\\datasciencecoursera\\exploratory_data\\project2\\')

# load data
NEI <- readRDS("data/summarySCC_PM25.rds")

# get subset baltimore NEI 2.5 emissions
baltimore_pm25_emissions <- subset(NEI,NEI$fips =="24510" )

# sum of each emissions per emission type per year
library(plyr)
total_baltimore_pm25_emissions  <- ddply(baltimore_pm25_emissions, c("fips","year"),summarise,TotalEmissions=sum(Emissions))

# plot the total emission for baltimore city - x:year, y:emissions
library(datasets) 
with(total_baltimore_pm25_emissions, plot(year, TotalEmissions, main = "Baltimore City PM25 Emissions Trends",ylab="Emissions" , type="l")) 

dev.copy(png, file = "plot2.png") 
dev.off() 