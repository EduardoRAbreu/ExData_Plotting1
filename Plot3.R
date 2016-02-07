## Exploratory Data Analysis Project 1 - Plot3.R
## Run code using source("Plot3.R")


## This piece checks to see if the file exists in the working directory
## If the file does not exist, it downloads the file and unzips it
filename <- "exdata-data-household_power_consumption.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename)
}

if (!file.exists("exdata-data-household_power_consumption")){
  unzip(filename)
}

filename2 <- "household_power_consumption.txt"

## Checks that data.table is installed, and installs otherwise

if(!require(data.table)) {
  install.packages("data.table")
  library(data.table)  
}

## This piece loads the necessary data into R
## Please note that sourcing the dates specified in the assignment is hardcoded

columns <- colnames(fread(filename2, nrows = 1))

powerconsumption <- fread(filename2, skip = "1/2/2007", nrows = 2880, sep = ";", header = FALSE, col.names = columns, na.strings = "?")

## Converts Date column from class character to class date

powerconsumption$Date <- as.Date(powerconsumption$Date, format = '%d/%m/%Y')
datetime <- paste(as.Date(powerconsumption$Date), powerconsumption$Time)
powerconsumption$DateTime <- as.POSIXct(datetime)

## Plot 3

par(mfrow = c(1,1))
plot(x = powerconsumption$DateTime, y = powerconsumption$Sub_metering_1,type = "n", ylab = "Energy sub metering", xlab = "")
points(x = powerconsumption$DateTime,  y = powerconsumption$Sub_metering_1, type = 'l', col = 'black')
points(x = powerconsumption$DateTime,  y = powerconsumption$Sub_metering_2, type = 'l', col = 'red')
points(x = powerconsumption$DateTime,  y = powerconsumption$Sub_metering_3, type = 'l', col = 'blue')
legend(x = "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col =c("black", "red", "blue"), lwd = "1", xjust = "0", pt.cex = 1, cex = .4)
dev.copy(png, "Plot3.png")
dev.off()