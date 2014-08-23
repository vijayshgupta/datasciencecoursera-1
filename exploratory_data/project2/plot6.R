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


# filter baltimore and los angeles county data
baltimore_la_mobile_emissions <- subset(mergedData, (mergedData$fips =="24510") | (mergedData$fips =="06037") )

baltimore_la_mobile_emissions$county <- ifelse(baltimore_la_mobile_emissions$fips =="24510", "Baltimore", "Los Angeles")

#sum of each emissions per emission type per year
library(plyr)
total_baltimore_la_mobile_emissions  <- ddply(baltimore_la_mobile_emissions, c("county","year"),summarise,emissions=sum(Emissions))


library(ggplot2)
g <- ggplot(total_baltimore_la_mobile_emissions, aes(total_baltimore_la_mobile_emissions$year, total_baltimore_la_mobile_emissions$emissions))
g + geom_line(aes(color=total_baltimore_la_mobile_emissions$county)) + labs(x="year", y="Total Emissions", colour="County", title="LA Baltimore Mobile Emissions")

dev.copy(png, file = "plot6.png") 
dev.off() 
