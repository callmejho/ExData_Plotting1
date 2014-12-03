## Load data.table and lubridate packages
library(data.table)
library(lubridate)
## Read data set in a data table
power <- fread(input = "household_power_consumption.txt", na.strings = '?')
## Use lubridate to create DateTime, convert power$Date and then subset
power <- power[,DateTime:=dmy_hms(paste(power$Date, power$Time))]
power$Date <- dmy(power$Date)
power <- power[power$Date == ymd("2007-02-01") | power$Date == ymd("2007-02-02"),]

## coerce Sub_metering 1,2,3 to numeric
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)

## Open PNG device
png(filename = "plot3.png", height = 480, width = 480, units = "px")

## Create plot
plot(power$DateTime, power$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
## Add lines
lines(power$DateTime, power$Sub_metering_1, type = "l", col = "black")
lines(power$DateTime, power$Sub_metering_2, type = "l", col = "red")
lines(power$DateTime, power$Sub_metering_3, type = "l", col = "blue")
## Add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

## Close device
dev.off()