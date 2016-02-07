##########################################################################################################

## Coursera Exploratory Data Analysis Course Project 1
## Calcifer Hawkins

# plot2.R File Description:

# This script performs the following steps on the data of UC Irvine Machine Learning Repository downloaded from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 1. Loads the data: reads and stores data of txt file, subsets the data by dates 2007-07-01 and 2007-07-02.
# 2. Makes plots: plots the data on Global Active Power(kilowatts) ~ Times.

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

# stores data of Date as character and Global Active Power
GAP_data <- select(householdpower, c(1, 2, 3))
GAP_data$Date <- as.character(as.Date(GAP_data$Date, format = "%d/%m/%Y"))


# subsets data of 2007-02-01 and 2007-02-02
twodays_data <- filter(GAP_data, (Date == "2007-02-01") | (Date == "2007-02-02"))
twodays_data$Time <- strptime(paste(twodays_data$Date, twodays_data$Time), format = "%Y-%m-%d %H:%M:%S")

# setting locale to en_US for proper day in a week labels
locale_original <- Sys.getlocale( category = "LC_TIME" )
Sys.setlocale("LC_TIME", "English")


# 2. Makes plots: plots the data on Global Active Power(kilowatts) ~ Times.

png(file = "plot2.png", width = 480, height = 480)
par(bg = "transparent")
with(twodays_data, plot(Time, Global_active_power, 
                         type="l",
                         xlab="",
                         ylab="Global Active Power (in kilowatts)",
                         cex.lab=0.7, cex.axis=0.8))
#close the png device.
dev.off()

