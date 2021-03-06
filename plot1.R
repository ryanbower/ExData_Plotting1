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

# create a PNG file name and open up the plot
plot_name <- paste(file_dir, "plot1.png", sep="/")
png(plot_name, width=480, height=480, units="px", bg="transparent")

# plot the histogram
hist(power_consumption$Global_active_power,
     main="Global Active Power",
     col="Red",
     xlab="Global Active Power (kilowatts)")
dev.off() # close the graphics object

