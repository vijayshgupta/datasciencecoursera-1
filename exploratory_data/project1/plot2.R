# 
fn <-"./data/household_power_consumption.csv"

library('sqldf')
hconsumption<- read.csv.sql(fn, header=TRUE, sep = ";",sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

hconsumption$DateTime <- paste(hconsumption$Date, hconsumption$Time)
hconsumption$DateTime <- strptime(hconsumption$DateTime, format="%d/%m/%Y %T")

# plot 1 frequency vs global active power (kilowatts)
library(datasets)
par(mfrow = c(1,1))
with(hconsumption, plot(DateTime, Global_active_power,type='l', ylab='Globral Active Power (kilowatts)', xlab=''))

dev.copy(png, file = "plot2.png") 
dev.off() 