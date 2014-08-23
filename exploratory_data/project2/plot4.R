setwd('c:\\webwork\\datasciencecoursera\\exploratory_data\\project2\\')

# load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# extract sub-colums from data frame 
# combustion sector
# use only scc and sector colum
SCC_Fuel_Comb <- SCC[grep("Coal",SCC$EI.Sector) ,c("SCC","EI.Sector")]

# merge data frames
mergedData <- merge(NEI,SCC_Fuel_Comb, by="SCC" )

total <- ddply(mergedData, c("year"),summarise,emissions=sum(Emissions))

library(ggplot2)
g <- ggplot(total, aes(total$year, total$emissions))
g + geom_line() + labs(x="year", y = "time", title="US coal combustion emissions") + expand_limits( y = 0)


dev.copy(png, file = "plot4.png") 
dev.off() 

