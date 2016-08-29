## Creates a directory, then downloads and extract the zip file. 

if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
}

## read in the data and change the class of the variables.

ECP <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
ECP$Date <- as.Date(ECP$Date, format="%d/%m/%Y")
x <- ECP[(ECP$Date == "2007-02-01") | (ECP$Date=="2007-02-02"),]
x <- transform(x, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") 
x$Global_active_power <- as.numeric(x$Global_active_power)
x$Global_reactive_power <- as.numeric((x$Global_reactive_power))
x$Voltage <- as.numeric((x$Voltage))
x$Sub_metering_1 <- as.numeric((x$Sub_metering_1))
x$Sub_metering_2 <- as.numeric((x$Sub_metering_2))
x$Sub_metering_3 <- as.numeric((x$Sub_metering_3))

## plot in png
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
plot(x$timestamp,x$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(x$timestamp,x$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(x$timestamp,x$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x$timestamp,x$Sub_metering_2,col="red")
lines(x$timestamp,x$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1), bty = "n", cex = 0.75)
plot(x$timestamp,x$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")       
dev.off()