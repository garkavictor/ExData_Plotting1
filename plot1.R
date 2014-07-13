plot1 <- function() {
  library(data.table)
  
  # download
  myUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  myZip <- "data.zip"
  download.file(url=myUrl, destfile=myZip)
  unzip(zipfile=myZip)
  
  # read and prepare data
  dataFile <- "household_power_consumption.txt"
  DT <- fread(input=dataFile, header=FALSE, sep=";", na.strings="?",
              skip="1/2/2007", nrows=2880)
  setnames(DT, names(read.table(dataFile, header=TRUE, sep=";",nrows=1)))
  
  # plot
  png("plot1.png")
  hist(DT$Global_active_power, col='red',
       xlab='Global Active Power (kilowatts)', main='Global Active Power')
  dev.off()
}
