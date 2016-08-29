## Creates a directory, then downloads and extract the zip file. 

if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
}

## read in the data and change classes of the variables.

ECP <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
ECP$Date <- as.Date(ECP$Date, format="%d/%m/%Y")
x <- ECP[(ECP$Date == "2007-02-01") | (ECP$Date=="2007-02-02"),]
x$Global_active_power <- as.numeric((x$Global_active_power))


## plot in png
png(file = "plot1.png", width = 480, height = 480)
hist(x$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()