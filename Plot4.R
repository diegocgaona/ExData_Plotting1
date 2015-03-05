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
hpcdata$Date_Time <- strptime(hpcdata$Date_Time, format="%d/%m/%Y %H:%M:%S") ## Transform 
png("plot4.png") ## initiate png graphic device, the standard is 480x480px
par(mfrow = c(2,2)) ## set to plot using 2 rows and 2 columns
## plot the 4 graphs
with(hpcdata, {
      plot(Date_Time, Global_active_power, ylab = "Global Active Power", xlab = ",", type = "l")
      plot(Date_Time, Voltage, ylab = "voltage", xlab = "datetime", type = "l")
      plot(hpcdata$Date_Time, hpcdata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type="l")
      lines(hpcdata$Date_Time, hpcdata$Sub_metering_2, col = "red", type = "S") ## color the lines from the plot above
      lines(hpcdata$Date_Time, hpcdata$Sub_metering_3, col = "blue", type = "S")
      legend("topright", lty = 1, col = c("black", "blue", "red"), ## create the legends for the plot above
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Date_Time, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l", yaxt = "n")
      axis(2, at=c(0.0,0.1,0.2,0.3,0.4,0.5),tick = 5) ## certify the axis ticks are showed right.
})
dev.off() ## Close the device (png)