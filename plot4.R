## Load data.table and lubridate packages
library(data.table)
library(lubridate)
## Read data set in a data table
power <- fread(input = "household_power_consumption.txt", na.strings = '?')
## Use lubridate to create DateTime, convert power$Date and then subset
power <- power[,DateTime:=dmy_hms(paste(power$Date, power$Time))]
power$Date <- dmy(power$Date)
power <- power[power$Date == ymd("2007-02-01") | power$Date == ymd("2007-02-02"),]

## coerce Sub_metering 1,2,3, Voltage, Global_reactive_power and Global_active_power to numeric
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Voltage <- as.numeric(power$Voltage)

## Open PNG device
png(filename = "plot4.png", height = 480, width = 480, units = "px")

## Set up four plot grid
par(mfrow = c(2,2))

## top left plot
plot(power$DateTime, power$Global_active_power, ylab = "Global active power", xlab="", type = "l")

## top right plot
plot(power$DateTime, power$Voltage, xlab="datetime", ylab="Voltage", type="l")

## bottom left plot
## Create plot
plot(power$DateTime, power$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
## Add lines
lines(power$DateTime, power$Sub_metering_1, type = "l", col = "black")
lines(power$DateTime, power$Sub_metering_2, type = "l", col = "red")
lines(power$DateTime, power$Sub_metering_3, type = "l", col = "blue")
## Add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")

## bottom right plot
plot(power$DateTime, power$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type = "l")

## Close device
dev.off()
