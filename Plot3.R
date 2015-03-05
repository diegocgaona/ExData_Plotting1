## Script to load and make plots from household_power_consumption data
## Get the URL
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipdatafile <- "./datafile.zip" ## create zipdata file
download.file(fileURL, destfile = zipdatafile, mode = "wb") ## download the file
unzip(zipdatafile) ## unzip the file
Sys.setlocale("LC_TIME", "English") # set local time to english to show the graphs correct
## read the only the data from dates: 1/2/2007, 2/2/2007
hpcdata <- subset(read.csv("household_power_consumption.txt", sep = ";",
                           na.strings = "?", stringsAsFactors = FALSE), Date %in% c("1/2/2007", "2/2/2007"))
hpcdata$Date_Time <- paste(hpcdata$Date, hpcdata$Time) ## concatenate data and time
## transform date and time to date and time class
hpcdata$Date_Time <- strptime(hpcdata$Date_Time, format="%d/%m/%Y %H:%M:%S")
png("plot3.png") ## initiate png graphic device, the standard is 480x480px
## make the plot from data
plot(hpcdata$Date_Time, hpcdata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type="l")
lines(hpcdata$Date_Time, hpcdata$Sub_metering_2, col = "red", type = "S") ## color the lines from the plot
lines(hpcdata$Date_Time, hpcdata$Sub_metering_3, col = "blue", type = "S")
legend("topright", lty = 1, col = c("black", "blue", "red"), ## create the legends for the plot above
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() ## Close the device (png)