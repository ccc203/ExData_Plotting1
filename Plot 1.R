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
"numeric","numeric","integer","integer","integer"),na.strings="?",
skip=68076,nrows=2880,col.names = c("Date","Time","Global_active_power",
"Global_reactive_power","Voltage","Global_intensity","Sub_metering_1",
"Sub_metering_2","Sub_metering_3"))


# open device
png(filename='plot1.png',width=480,height=480,units='px')

hist(data$Global_active_power,xlab="Global Active Power (kilowatts)",
col="orangered",main="Global Active Power")

dev.off()