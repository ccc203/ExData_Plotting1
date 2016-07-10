library(data.table)
library(magrittr)
library(dplyr)
library(lubridate)

setwd("~/R")

#download and save the file
if(!file.exists("./data")){dir.create("/data")}
url<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "./data/data.zip")

#unzip the file
unzip(zipfile = "./data/data.zip",exdir = "./data")


data<-fread(input=file.path("./data","household_power_consumption.txt"),
header=TRUE,colClasses=c("character","character","numeric","numeric",
"numeric","numeric","integer","integer","integer"),na.strings="?")

data$Date<-data$Date %>% dmy

data<-data %>% subset(Date>="2007-02-01" & Date<="2007-02-02")

#Reform column Date and Time
data$DateTime<-as.POSIXct(strptime(data$Date + hms(data$Time), 
                                   "%Y-%m-%d %H:%M:%S"))

# open device
png(filename='plot4.png',width=480,height=480,units='px')

par(mfrow=c(2,2))

#chart(1,1)
plot(data$DateTime,data$Global_active_power,xlab="",
     ylab="Global Active Power (kilowatts)",type='l')

#chart(1,2)
plot(data$DateTime,data$Voltage,xlab="datetime",
     ylab="Voltage",type='l')

#chart(2,1)
with(data,{
  plot(DateTime,Sub_metering_1,type='l',col="black", xlab="",
       ylab="Energy sub metering")
  lines(DateTime,Sub_metering_2,type='l',col="red")
  lines(DateTime,Sub_metering_3,type='l',col="blue")
  
  legend('topright',legend=c("Sub_metering_1","Sub_metering_2",
  "Sub_metering_3"),col=c("black","red","blue"),lty="solid")
})


#chart(2,2)
plot(data$DateTime,data$Global_reactive_power,xlab="datetime",
     ylab="Global_reactive_power",type='l')

dev.off()