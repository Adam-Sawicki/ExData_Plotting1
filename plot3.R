#Load data
if (!file.exists("household_power_consumption.txt")){
  if (!file.exists("household_power_consumption.zip")){
    data_url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url=data_url, destfile="household_power_consumption.zip", mode="wb")
  }
  unzip(zipfile="household_power_consumption.zip")
}

#read txt file into data frame
hpc <- read.table("household_power_consumption.txt", sep=";", header=T,
                  dec=".", na.strings="?")

#subset large data frame. Use only data from the dates 2007-02-01 and 2007-02-02
sub_hpc=hpc[hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007",]

#join Date and time features
dateTime=paste(as.Date(sub_hpc$Date, "%d/%m/%Y"), sub_hpc$Time)
dateTime=strptime(dateTime, format="%Y-%m-%d %H:%M:%S")

#compute maximal y-axis value
y_max=max(c(max(sub_hpc$Sub_metering_1), max(sub_hpc$Sub_metering_2), max(sub_hpc$Sub_metering_3)))

#Initiate png graphic device
png(filename = "plot3.png",width = 480, height = 480, units = "px")

#draw plot 3
plot(dateTime, sub_hpc$Sub_metering_1, type="l", ylim=c(0, y_max),
     xlab="", ylab="Energy sub metering", main="" )
points(dateTime, sub_hpc$Sub_metering_2, type="l", col="red")
points(dateTime, sub_hpc$Sub_metering_3, type="l", col="blue")
legend("topright",lwd=2, col=c("black","red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Close png graphic device
dev.off()
