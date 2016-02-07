##########################################################################################################

## Coursera Exploratory Data Analysis Course Project 1
## Calcifer Hawkins

# plot3.R File Description:

# This script performs the following steps on the data of UC Irvine Machine Learning Repository downloaded from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 1. Loads the data: reads and stores data of txt file, subsets the data by dates 2007-07-01 and 2007-07-02.
# 2. Makes plots: plots the data on Sub_metering datas ~ Times.

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

# stores data of Date as character and Sub_metering datas
GAP_data <- select(householdpower, c(1, 2, 7, 8, 9))
GAP_data$Date <- as.character(as.Date(GAP_data$Date, format = "%d/%m/%Y"))


# subsets data of 2007-02-01 and 2007-02-02
twodays_data <- filter(GAP_data, (Date == "2007-02-01") | (Date == "2007-02-02"))
twodays_data$Time <- strptime(paste(twodays_data$Date, twodays_data$Time), format = "%Y-%m-%d %H:%M:%S")

# setting locale to en_US for proper day in a week labels
locale_original <- Sys.getlocale( category = "LC_TIME" )
Sys.setlocale("LC_TIME", "English")


# 2. Makes plots: plots the data on Global Active Power(kilowatts) ~ Times.

png(file = "plot3.png", width = 480, height = 480)
par(bg = "transparent")
plot(twodays_data$Time, twodays_data$Sub_metering_1, 
     type="l", ylab="Energy sub metering", xlab = "", cex.lab=0.7)

lines(twodays_data$Time, twodays_data$Sub_metering_2, col="red")
lines(twodays_data$Time, twodays_data$Sub_metering_3, col="blue")

# annotate the plot with a legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","red", "blue"), cex=0.8)
#close the png device.
dev.off()

