#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# PROGRAM: Plot1.R
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
#   2. Creates a histogram of "Global Active Power".
#
#   3. Profit.
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


library(png)


# first, Load the file:
file_dir <- "/Users/rbower_lt/Documents/Ryan Docs/Coursera/Exploratory Data Analysis"
input_file <- paste(file_dir, "household_power_consumption.txt", sep="/")
power_consumption <- read.table(input_file, header=TRUE, sep=";",na.strings = "?")


# set the Date field to be a date type, and filter down to the data we need.
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")
power_consumption <- power_consumption[power_consumption$Date >= '2007-02-01' & 
                                         power_consumption$Date <= '2007-02-02',]

summary(power_consumption)
dplyr::glimpse(power_consumption)

# create a PNG file name and open up the plot
plot_name <- paste(file_dir, "plot1.png", sep="/")
png(plot_name, width=480, height=480, units="px")

# plot the histogram
hist(power_consumption$Global_active_power,
     main="Global Active Power",
     col="Red",
     xlab="Global Active Power (kilowatts)")
dev.off() # close the graphics object

