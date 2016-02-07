##########################################################################################################

## Coursera Exploratory Data Analysis Course Project 1
## Calcifer Hawkins

# plot1.R File Description:

# This script performs the following steps on the data of UC Irvine Machine Learning Repository downloaded from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 1. Loads the data: reads and stores data of txt file, subsets the data by dates 2007-07-01 and 2007-07-02.
# 2. Makes plots: plots a histogram of the data on Global Active Power(kilowatts).

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
householdpower <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# stores data of Date as character and Global Active Power
GAP_data <- select(householdpower, c(1, 3))
GAP_data$Date <- as.character(as.Date(GAP_data$Date, "%d/%m/%Y"))
GAP_data$Global_active_power <- as.numeric(as.character((GAP_data$Global_active_power)))

# subsets data of 2007-02-01 and 2007-02-02
#twodays <- c("2007-02-01", "2007-02-02")
twodays_data <- filter(GAP_data, (Date == "2007-02-01") | (Date == "2007-02-02"))

# 2. Makes plots: plots a histogram of the data on Global Active Power(kilowatts), stores it in png file.

png(file = "plot1.png", width = 480, height = 480)
par(bg = "transparent")
hist(twodays_data$Global_active_power, col = "red", bg = "transparent", xlab = "Global Active Power(kilowatts)", main = ("Global Active Power"))

#close the png device.
dev.off()

