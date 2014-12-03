## Load data.table and lubridate packages
library(data.table)
library(lubridate)
## Read data set in a data table
power <- fread(input = "household_power_consumption.txt", na.strings = '?')
## Use lubridate to convert power$Date and then subset
power$Date <- dmy(power$Date)
power <- power[power$Date == ymd("2007-02-01") | power$Date == ymd("2007-02-02"),]
## coerce Global_active_power to numeric
power$Global_active_power <- as.numeric(power$Global_active_power)
## Open PNG device
png(filename = "plot1.png", height = 480, width = 480, units = "px")
## Plot histogram
hist(power$Global_active_power, xlab = "Global active power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")
## Close PNG device
dev.off()