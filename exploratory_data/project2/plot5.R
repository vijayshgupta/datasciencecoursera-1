setwd('c:\\webwork\\datasciencecoursera\\exploratory_data\\project2\\')

# load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# extract sub-colums from data frame 
# sector that contains on the road vechicles
# use only scc and sector colum
SCC_on_road_mobile <- SCC[grep("On-Road",SCC$EI.Sector) ,c("SCC","EI.Sector")]

# merge data frames
mergedData <- merge(NEI,SCC_on_road_mobile, by="SCC" )

# get subset baltimore NEI 2.5 emissions
baltimore_pm25_mobile_emissions <- subset(mergedData,mergedData$fips =="24510" )

#sum of each emissions per emission type per year
library(plyr)
total_baltimore_pm25_mobile_emissions  <- ddply(baltimore_pm25_mobile_emissions, c("year"),summarise,emissions=sum(Emissions))

library(ggplot2)
g <- ggplot(total_baltimore_pm25_mobile_emissions, aes(total_baltimore_pm25_mobile_emissions$year, total_baltimore_pm25_mobile_emissions$emissions))
g + geom_line() + labs(x="year", y="Total Emissions", title="Baltimore PM25 emissions from Motor Vechicles")


dev.copy(png, file = "plot5.png") 
dev.off() 