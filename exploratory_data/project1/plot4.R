# 
fn <-"./data/household_power_consumption.csv"

library('sqldf')
hconsumption<- read.csv.sql(fn, header=TRUE, sep = ";",sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

hconsumption$DateTime <- paste(hconsumption$Date, hconsumption$Time)
hconsumption$DateTime <- strptime(hconsumption$DateTime, format="%d/%m/%Y %T")

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(hconsumption, {
  plot(DateTime, Global_active_power,type='l', ylab='Globral Active Power (kilowatts)', xlab='')
  plot(DateTime, Voltage,type='l', ylab='Voltage', xlab='datetime')
  plot(DateTime, Sub_metering_1,type='l',ylab='Energy sub metering',xlab='')
  lines(DateTime, Sub_metering_2,type='l', col ="red" )
  lines(DateTime, Sub_metering_3,type='l', col ="blue")
  legend("topright", col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), pch=NA,lty = 1, cex=.4)
  plot(DateTime, Global_reactive_power,type='l', xlab='datetime')
})

dev.copy(png, file = "plot4.png") 
dev.off() 