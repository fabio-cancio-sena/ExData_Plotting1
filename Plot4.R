if(!require("data.table")) {
  install.packages("data.table")
  library(data.table)
}

power.consumption <- fread("household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE)
power.consumption[,`:=`( Date = as.Date(Date, format="%d/%m/%Y") ),]
power.consumption <- power.consumption[Date >= "2007-02-01" & Date <= "2007-02-02",,]
power.consumption[,`:=`( Datetime = as.POSIXct(paste(Date, Time)) ),]

par(mfrow=c(2,2), mar=c(1,1,1,1), oma=c(0,0,0,0))

plot(Global_active_power ~ Datetime, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="",
     data = power.consumption)
plot(Voltage ~ Datetime, 
     type="l", 
     ylab="Voltage (volt)", 
     xlab="",
     data = power.consumption)
plot(Sub_metering_1 ~ Datetime, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="",
     data = power.consumption)
lines(Sub_metering_2 ~ Datetime,
      col='Red',
      data = power.consumption)
lines(Sub_metering_3 ~ Datetime,
      col='Blue',
      data = power.consumption)
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), 
       lty=1, lwd=2, bty="n")
plot(Global_reactive_power ~ Datetime, 
     type="l", 
     ylab="Global Rective Power (kilowatts)",
     xlab="",
     data = power.consumption)

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

rm(power.consumption)