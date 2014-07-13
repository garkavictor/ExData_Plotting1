plot3 <- function() {
  # download
  myUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  myZip <- "data.zip"
  download.file(url=myUrl, destfile=myZip)
  unzip(zipfile=myZip)
  
  # read and prepare data
  dataFile <- "household_power_consumption.txt"
  DT <- read.table(file=dataFile, header=FALSE, sep=";", na.strings="?",
                   skip=66637, nrows=2880,
                   colClasses=c(rep("character", 6), rep("numeric", 3)))
  setnames(DT, names(read.table(dataFile, header=TRUE, sep=";", nrows=1)))
  
  DT$dateTime <- strptime(paste(DT$Date, DT$Time), "%d/%m/%Y %H:%M:%S")  
  
  # plot
  png("plot3.png")
  with(DT, plot(x=dateTime, y=Sub_metering_1, type="l", xlab="",
                ylab="Energy sub metering"))
  with(DT, lines(x=dateTime, y=Sub_metering_2, col="red"))
  with(DT, lines(x=dateTime, y=Sub_metering_3, col="blue"))
  legend("topright", lty=c(1,1,1), col=c("black","red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}
