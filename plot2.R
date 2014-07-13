plot2 <- function() {
  library(data.table)
  
  # download
  myUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  myZip <- "data.zip"
  download.file(url=myUrl, destfile=myZip)
  unzip(zipfile=myZip)
  
  # read and prepare data
  dataFile <- "household_power_consumption.txt"
  DT <- read.table(file=dataFile, header=FALSE, sep=";", na.strings="?",
                   skip=66637, nrows=2880, colClasses="character")
  setnames(DT, names(read.table(dataFile, header=TRUE, sep=";", nrows=1)))
  
  DT$dateTime <- strptime(paste(DT$Date, DT$Time), "%d/%m/%Y %H:%M:%S")
  DT$Global_active_power <- as.numeric(DT$Global_active_power)

  # plot
  png("plot2.png")
  with(DT, plot(x=dateTime, y=Global_active_power, type="l", xlab = "",
                ylab = "Global Active Power (kilowatts)"))
  dev.off()
}
