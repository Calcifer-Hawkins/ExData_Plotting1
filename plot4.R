##########################################################################################################

## Coursera Exploratory Data Analysis Course Project 1
## Calcifer Hawkins

# plot4.R File Description:

# This script performs the following steps on the data of UC Irvine Machine Learning Repository downloaded from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 1. Loads the data: reads and stores data of txt file, subsets the data by dates 2007-07-01 and 2007-07-02.
# 2. Makes plots: plots the data.

##########################################################################################################
# Cleans up the workspace
rm(list = ls())

# installs(if haven't installed) and loads the dplyr library
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

# 1. Loads the data: reads and stores data of txt file, subsets the data by dates 2007-07-01 and 2007-07-02.

#set working directory to the location where UCI HAR Dataset was unzipped
setwd("D:/R-3.2.3/coursera/exdata_data_household_power_consumption/")

# Reads and stores from txt file
householdpower <- read.table("./household_power_consumption.txt", header = TRUE, stringsAsFactors=FALSE, sep = ";", na.strings = "?")



# subsets data of 2007-02-01 and 2007-02-02
householdpower$Date <- as.character(as.Date(householdpower$Date, format = "%d/%m/%Y"))
twodays_data <- filter(householdpower, (Date == "2007-02-01") | (Date == "2007-02-02"))
twodays_data$Time <- strptime(paste(twodays_data$Date, twodays_data$Time), format = "%Y-%m-%d %H:%M:%S")

# setting locale to en_US for proper day in a week labels
locale_original <- Sys.getlocale( category = "LC_TIME" )
Sys.setlocale("LC_TIME", "English")


# 2. Makes plots: plots the data.
png(file = "plot4.png", width = 480, height = 480)
par(bg = "transparent", mfrow=c(2,2))

# plots top-left
with(twodays_data, plot(Time, Global_active_power, 
                         type="l",
                         xlab="", ylab="Global Active Power", 
                         cex.lab=0.7, cex.axis=0.8,
))

# plots top-right
with(twodays_data, plot(Time, Voltage, type="l",
                         xlab="datetime", ylab="Voltage", 
                         cex.lab=0.7, cex.axis=0.8,
))

# plots bottom-left
plot(twodays_data$Time, twodays_data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", cex.lab=0.7, cex.axis=0.8)
lines(twodays_data$Time, twodays_data$Sub_metering_2, col="red")
lines(twodays_data$Time, twodays_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black","red", "blue"), cex=0.7, bty="n")

# plots bottom-right
with(twodays_data, plot(Time, twodays_data$Global_reactive_power, type="l",lwd=0.5,
                         xlab="datetime", ylab="Global_reactive_power", 
                         cex.lab=0.7, cex.axis=0.8))

#close the png device.
dev.off()

