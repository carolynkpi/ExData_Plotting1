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
png("plot2.png")
with(data, plot(datetime,Global_active_power, type= "l", xlab="", ylab="Global Active Power (kilowatts)"))

dev.off()