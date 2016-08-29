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
x$Global_active_power <- as.numeric(x$Global_active_power)

## plot in png

png("plot2.png", width=480, height=480)
plot(x$timestamp, x$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()