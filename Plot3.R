if(!require("data.table")) {
  install.packages("data.table")
  library(data.table)
}

power.consumption <- fread("household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE)
power.consumption[,`:=`( Date = as.Date(Date, format="%d/%m/%Y") ),]
power.consumption <- power.consumption[Date >= "2007-02-01" & Date <= "2007-02-02",,]
power.consumption[,`:=`( Datetime = as.POSIXct(paste(Date, Time)) ),]

plot(Sub_metering_1 ~ Datetime,
     type = "l", 
     ylab = "global Active Power (kilowatts)",
     xlab = "", 
     data = power.consumption)
lines(Sub_metering_2 ~ Datetime, col='Red', data = power.consumption)
lines(Sub_metering_3 ~ Datetime, col='Blue', data = power.consumption)

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

rm(power.consumption)