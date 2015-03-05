## Script to load and make plots from household_power_consumption data
## Get the URL
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipdatafile <- "./datafile.zip" ## create zipdata file
download.file(fileURL, destfile = zipdatafile, mode = "wb") ## download the file
unzip(zipdatafile) ## unzip the file
## read the only the data from dates: 1/2/2007, 2/2/2007
hpcdata <- subset(read.csv("household_power_consumption.txt", sep = ";",
                            na.strings = "?", stringsAsFactors = FALSE), Date %in% c("1/2/2007", "2/2/2007"))
hpcdata$Date_Time <- paste(hpcdata$Date, hpcdata$Time) ## concatenate data and time
## transform date and time to date and time class
hpcdata$Date_Time <- strptime(hpcdata$Date_Time, format="%d/%m/%Y %H:%M:%S")
png("plot1.png") ## initiate png graphic device, the standard is 480x480px
## create histogram from data
hist(hpcdata$Global_active_power, main =  "Global Active Power",  xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()  ## Close the device (png)