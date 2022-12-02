library(dplyr)
df<- read.table("household_power_consumption.txt", header=TRUE, sep = ";")

## Change the type of col 3:9 from character to numeric
df <- df %>% mutate_at(c(3:9), as.numeric)

## Choose the subset data from 2007/02/01 to 2007/02/02
subdf<- df[df$Date %in% c("1/2/2007", "2/2/2007"),]

## Create  additional column of date and time
subdf$DateTime <- strptime(paste(subdf$Date, subdf$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

## Open PNG device; create 'plot4.png' in default working directory
png(file = "plot4.png") 

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

with(subdf, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subdf, plot(DateTime, Voltage, type="l", xlab="", ylab="Voltage"))  
with(subdf, {
       plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="",  col = "black", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)) )
       par(new=TRUE)
       plot(DateTime, Sub_metering_2, type="l", xlab="", ylab="", col = "blue", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)) )
       par(new=TRUE)
       plot(DateTime, Sub_metering_3, type="l", xlab="", ylab="Energy Sub metering", col = "red", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)) )
       legend("topright", pch = '-', col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
           })     
with(subdf, plot(DateTime, Global_reactive_power, type="l", xlab="", ylab="Global Reactive Power"))

## Close the PNG file device
dev.off()
