## Load data.table and lubridate packages
library(data.table)
library(lubridate)
## Read data set in a data table
power <- fread(input = "household_power_consumption.txt", na.strings = '?')
## Use lubridate to create DateTime, convert power$Date and then subset
power <- power[,DateTime:=dmy_hms(paste(power$Date, power$Time))]
power$Date <- dmy(power$Date)
power <- power[power$Date == ymd("2007-02-01") | power$Date == ymd("2007-02-02"),]

## coerce Global_active_power to numeric
power$Global_active_power <- as.numeric(power$Global_active_power)
## Open PNG device
png(filename = "plot2.png", height = 480, width = 480, units = "px")
## Plot 
plot(power$DateTime, power$Global_active_power, ylab = "Global active power (kilowatts)", xlab="", type = "l")
## Close device
dev.off()