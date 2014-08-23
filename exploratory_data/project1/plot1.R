# 
fn <-"./data/household_power_consumption.csv"
library('sqldf')
hconsumption<- read.csv.sql(fn, header=TRUE, sep = ";",sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

# plot 1 frequency vs global active power (kilowatts)
library(datasets)
par(mfrow = c(1,1))
with(hconsumption, hist(Global_active_power,xlab="Global Active Power (killowatts)",col="red",main="Global Active Power"))

dev.copy(png, file = "plot1.png") 
dev.off() 