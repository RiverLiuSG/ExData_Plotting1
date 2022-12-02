library(dplyr)
df<- read.table("household_power_consumption.txt", header=TRUE, sep = ";")

## Change the type of col 3:9 from character to numeric
df <- df %>% mutate_at(c(3:9), as.numeric)

## Choose the subset data from 2007/02/01 to 2007/02/02
subdf<- df[df$Date %in% c("1/2/2007", "2/2/2007"),]

## Create  additional column of date and time
subdf$DateTime <- strptime(paste(subdf$Date, subdf$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

## Open PNG device; create 'plot3.png' in default working directory
png(file = "plot3.png")

## Create plot and send to a file, annotate plot (no plot appears on screen)

with(subdf, {
  plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="",  col = "black", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)) )
  par(new=TRUE)
  plot(DateTime, Sub_metering_2, type="l", xlab="", ylab="", col = "blue", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)) )
  par(new=TRUE)
  plot(DateTime, Sub_metering_3, type="l", xlab="", ylab="Energy Sub metering", col = "red", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)) )
  legend("topright", pch = '-', col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  })

## Close the PNG file device
dev.off()


