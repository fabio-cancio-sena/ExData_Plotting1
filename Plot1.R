if(!require("data.table")) {
  install.packages("data.table")
  library(data.table)
}

power.consumption <- fread("household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE)
power.consumption[,`:=`( Date = as.Date(Date, format="%d/%m/%Y") ),]
power.consumption <- power.consumption[Date >= "2007-02-01" & Date <= "2007-02-02",,]
power.consumption[,`:=`( Datetime = as.POSIXct(paste(Date, Time)) ),]

with(power.consumption, {
  hist(Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     col="Red")
})

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

rm(power.consumption)