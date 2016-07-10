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


# open device
png(filename='plot1.png',width=480,height=480,units='px')

hist(data$Global_active_power,xlab="Global Active Power (kilowatts)",
col="orangered",main="Global Active Power")

dev.off()