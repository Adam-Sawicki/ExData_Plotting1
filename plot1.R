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


#Initiate png graphic device
png(filename = "plot1.png",width = 480, height = 480, units = "px")

#draw plot 1
hist(sub_hpc$Global_active_power, col="red", xlab="Global Active power (kilowatts)", main="Global Active Power")

#Close png graphic device
dev.off()
