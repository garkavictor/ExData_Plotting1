plot4 <- function() {
  library(data.table)
  
  # download
  myUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  myZip <- "data.zip"
  #download.file(url=myUrl, destfile=myZip)
  #unzip(zipfile=myZip)

  # read and prepare data
  dataFile <- "household_power_consumption.txt"
  DT <- read.table(file=dataFile, header=FALSE, sep=";", na.strings="?",
                   skip=66637, nrows=2880,
                   colClasses=c(rep("character", 2), rep("numeric", 7)))
  setnames(DT, names(read.table(dataFile, header=TRUE, sep=";", nrows=1)))
  
  DT$datetime <- strptime(paste(DT$Date, DT$Time), "%d/%m/%Y %H:%M:%S")  

  # plot
  png("plot4.png")
  par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
  with(DT, {
    plot(Global_active_power, type='l', xlab='', ylab='Global Active Power')

    plot(x=datetime, y=Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(x=datetime, y=Sub_metering_2, col="red")
    lines(x=datetime, y=Sub_metering_3, col="blue")
    legend("topright", lty=c(1,1,1), col=c("black","red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    plot(x=datetime, y=Voltage, type="l")
    plot(x=datetime, y=Global_reactive_power, type="l")
  })
  dev.off()
}
