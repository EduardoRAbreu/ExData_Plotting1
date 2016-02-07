## Exploratory Data Analysis Project 1 - Plot2.R
## Run code using source("Plot2.R")


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

powerconsumption <- fread(filename2, skip = "1/2/2007", nrows = 2880, sep = ";", header = TRUE, col.names = columns, na.strings = "?")

## Converts Date column from class character to class date

powerconsumption$Date <- as.Date(powerconsumption$Date, format = '%d/%m/%Y')
datetime <- paste(as.Date(powerconsumption$Date), powerconsumption$Time)
powerconsumption$DateTime <- as.POSIXct(datetime)

## Plot 2.
par(mfrow = c(1,1))
plot(x = powerconsumption$DateTime, y = powerconsumption$Global_active_power, xlab = "", 
     ylab = "Global Active Power(kilowatts)", type = "l")
dev.copy(png, "Plot2.png")
dev.off()