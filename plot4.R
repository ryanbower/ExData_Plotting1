#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# PROGRAM: Plot4.R
# VERSION: 1
#
# AUTHOR: RYAN BOWER 
#         www.ryanbower.net
#
# DATE: 8/7/2014
#
# DESCRIPTION: 
#   1. Loads the “Individual household electric power consumption 
#      Data Set” from the UC Irvine Machine Learning Repository.
#
#   2. Creates four distinct plots:
#       A. Global Active Power line-plot
#       B. Voltage line-plot
#       C. Energy sub-metering line plots
#       D. Global reactive power line-plot
#
#   3. Profit.
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# load the png library for creating the plots:
library(png)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1. LOAD THE DATA

# set up directories and file names:
file_dir <- "/Users/rbower_lt/Documents/Ryan Docs/Coursera/Exploratory Data Analysis"
input_file <- paste(file_dir, "household_power_consumption.txt", sep="/")
input_zip <- paste(file_dir, "household_power_consumption.zip", sep="/")

# if the file does not yet exist, download it:
if(!file.exists(input_file)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile=input_zip, , method="curl")
  unz(input_zip, filename=input_file)
}

# read the file:
power_consumption <- read.table(input_file, header=TRUE, sep=";",na.strings = "?")

# set the Date field to be a date type, and filter down to the data we need:
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")
power_consumption <- power_consumption[power_consumption$Date >= '2007-02-01' & 
                                         power_consumption$Date <= '2007-02-02',]

# create a date-time field for the line plots:
power_consumption$DateTime <- strptime(paste(power_consumption$Date, power_consumption$Time, sep=" "),
                                       format="%Y-%m-%d %H:%M:%S")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2. CREATE THE PLOTS:

# set up a png file:
plot_name <- paste(file_dir, "plot4.png", sep="/")
png(plot_name, width=480, height=480, units="px", bg="transparent")
par(mfrow=c(2,2))

# Plot A. Global Active Power line-plot
plot(power_consumption$Global_active_power, pch="",
     ylab="Global Active Power (kilowatts)",
     xlab="", xaxt='n')
# add the line representing Global Active Power:
lines(power_consumption$Global_active_power)
# and update the axis:
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))

# Plot B. Voltage line-plot
plot(power_consumption$Voltage, pch="",
     ylab="Voltage",
     xlab="datetime", xaxt='n')
# add the line representing Voltage:
lines(power_consumption$Voltage)
# and update the axis:
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))

# Plot C. Energy sub-metering line plots
plot(power_consumption$Sub_metering_1, pch="",
     ylab="Energy sub metering",
     xlab="", xaxt='n')
# add the lines representing sub-metering:
lines(power_consumption$Sub_metering_1, col="Black")
lines(power_consumption$Sub_metering_2, col="Red")
lines(power_consumption$Sub_metering_3, col="Blue")
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))
# add a legend to the plot:
legend("topright",pch="", col=c("Black", "Red", "Blue"), lty=c(1,1,1),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot D. Global reactive power line-plot
plot(power_consumption$Global_reactive_power, pch="",
     ylab="Global_reactive_power",
     xlab="datetime", xaxt='n')
# now add the line representing Global Active Power:
lines(power_consumption$Global_reactive_power)
# update the axis:
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))

dev.off() # close the graphics object
