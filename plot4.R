##Read relevent data
ini <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE,nrows = 1)
start <- paste (ini$Date, ini$Time)
start <- strptime(start, "%d/%m/%Y %H:%M:%S") 
end <- "2007-02-01 00:00:00"
end <- strptime(end, "%Y-%m-%d %H:%M:%S")
skip <- as.numeric(end - start) * 24 * 60 +1
nrows <- 2 * 24 *60

data <- read.table("household_power_consumption.txt", sep = ";", header = FALSE, stringsAsFactors = FALSE,skip = skip, nrows = nrows)
names(data) <- names(ini)

##Convert to date and time class
data$datetime <- paste(data$Date,data$Time)
data$datetime <- strptime(data$datetime,"%d/%m/%Y %H:%M:%S")

##Plot chart
png("plot4.png")
par(mfcol=c(2,2))

#panel1
with(data, plot(datetime,Global_active_power, type= "l", xlab="", ylab="Global Active Power"))

#panel2
with(data, plot(datetime, Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering"))
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", cex = 0.9, col=c("black", "red","blue"))

#panel3
with(data, plot(datetime,Voltage, type= "l"))

#panel4
with(data, plot(datetime,Global_reactive_power, type= "l"))

dev.off()