## Creates a directory, then downloads and extract the zip file. 

if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
}

## read in the data, change the classes of the variables and subset.

ECP <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
ECP$Date <- as.Date(ECP$Date, format="%d/%m/%Y")
x <- ECP[(ECP$Date == "2007-02-01") | (ECP$Date=="2007-02-02"),]
x <- transform(x, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
x$Sub_metering_1 <- as.numeric((x$Sub_metering_1))
x$Sub_metering_2 <- as.numeric((x$Sub_metering_2))
x$Sub_metering_3 <- as.numeric((x$Sub_metering_3))


## plot in png

png("plot3.png", width=480, height=480)
plot(x$timestamp, x$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x$timestamp,x$Sub_metering_2,col="red")
lines(x$timestamp,x$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1), lwd=c(1,1))
dev.off()