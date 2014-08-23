# 
fn <-"./data/household_power_consumption.csv"

library('sqldf')
hconsumption<- read.csv.sql(fn, header=TRUE, sep = ";",sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

hconsumption$DateTime <- paste(hconsumption$Date, hconsumption$Time)
hconsumption$DateTime <- strptime(hconsumption$DateTime, format="%d/%m/%Y %T")
library(datasets)
par(mfrow = c(1,1))
with(hconsumption, plot(DateTime, Sub_metering_1,type='l',ylab='Energy sub metering',xlab=''))
with(hconsumption, lines(DateTime, Sub_metering_2,type='l', col ="red" ))
with(hconsumption, lines(DateTime, Sub_metering_3,type='l', col ="blue"))
legend("topright", col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), pch=NA,lty = 1, cex=.8)

dev.copy(png, file = "plot3.png") 
dev.off() 