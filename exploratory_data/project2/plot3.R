setwd('c:\\webwork\\datasciencecoursera\\exploratory_data\\project2\\')

# load data
NEI <- readRDS("data/summarySCC_PM25.rds")

# get subset baltimore NEI 2.5 emissions
baltimore_pm25_emissions <- subset(NEI,NEI$fips =="24510" )

# sum of each emissions per emission type per year
library(plyr)
total_baltimore_pm25_emissions  <- ddply(baltimore_pm25_emissions, c("fips","year","type"),summarise,TotalEmissions=sum(Emissions))

library(ggplot2)
g <- ggplot(total_baltimore_pm25_emissions, aes(total_baltimore_pm25_emissions$year, total_baltimore_pm25_emissions$TotalEmissions))
g + geom_line(aes(color=total_baltimore_pm25_emissions$type)) + labs(x="Year", y="Emissions", title="Baltimore City Emissions Sources Type",colour="Types of sources")

dev.copy(png, file = "plot3.png") 
dev.off() 