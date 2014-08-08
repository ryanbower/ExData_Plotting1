#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# PROGRAM: Plot3.R
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
#   2. Create line plots of Energy sub-metering by sub-metering readings (1-3).
#
#   3. Profit.
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


library(png)

if(!file.exists(downloadedFile)){
  download.file("linkForDownloading", "destFile.txt")
}

# first, Load the file:
file_dir <- "/Users/rbower_lt/Documents/Ryan Docs/Coursera/Exploratory Data Analysis"
input_file <- paste(file_dir, "household_power_consumption.txt", sep="/")
power_consumption <- read.table(input_file, header=TRUE, sep=";",na.strings = "?")


# set the Date field to be a date type, and filter down to the data we need.
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")
power_consumption <- power_consumption[power_consumption$Date >= '2007-02-01' & 
                                         power_consumption$Date <= '2007-02-02',]

power_consumption$DateTime <- strptime(paste(power_consumption$Date, power_consumption$Time, sep=" "),
                                       format="%Y-%m-%d %H:%M:%S")
summary(power_consumption)
dplyr::glimpse(power_consumption)

# create a PNG file name and open up the plot
plot_name <- paste(file_dir, "plot3.png", sep="/")
png(plot_name, width=480, height=480, units="px")

# create an empty plot object (without an x-axis)
plot(power_consumption$Sub_metering_1, pch="",
     ylab="Energy sub metering",
     xlab="", xaxt='n')
# now add the line representing Global Active Power
lines(power_consumption$Sub_metering_1, col="Black")
lines(power_consumption$Sub_metering_2, col="Red")
lines(power_consumption$Sub_metering_3, col="Blue")

# and update the axis:
axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri", "Sat"))
legend("topright",pch="", col=c("Black", "Red", "Blue"), lty=c(1,1,1),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off() # close the graphics object

