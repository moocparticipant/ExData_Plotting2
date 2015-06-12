library(lubridate)
library(sqldf)

readData <- function(){
#================================================
#This function returns data required for plotting
#================================================ 
  #download data from URL
  print ("file is going to be downloaded")
  dataFileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  #https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
  #I am using Windows so https is removed and replaced with http curl does not work in my machine
  if (!file.exists(".\\data")){dir.create(".\\data")}#if there is no directory called data create one
  #now store downloaded file in data directory
  download.file(dataFileURL, destfile = ".\\data\\data.zip", mode ="wb")#mode set to "wb" because this is binary data
  unzip (".\\data\\data.zip")
  
    
  #if we come here that means the folder exists that means unzip has worked :)
  ##     fips      SCC Pollutant Emissions  type year
  ## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
  ## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
  ## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
  ## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
  ## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
  ## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
    				
  ### READING data This code was provided in the assignment 
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  #read data selectively
  #sqlquery <- "select * from file where Date in ('1/2/2007','2/2/2007')"
  #feb_data <- read.csv.sql(".\\household_power_consumption.txt", sep = ";", sql = sqlquery, header = TRUE) 
  #closeAllConnections()
  newlist <- list ("NEI" = NEI, "SCC" = SCC)
  newlist
 }