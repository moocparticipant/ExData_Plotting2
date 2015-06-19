#Exploratory Data Analysis Mini Project 2 Plot 1
library(plyr)
library(dplyr)
library (ggplot2)

source("ass1.r")#contains readData function to read data from internet unzip and read to data frames

plot5 <- function (){
	newlist <- readData() # this list contains NEI, SCC
	NEI <- newlist$NEI
	SCC <- newlist$SCC
	plot5_1(NEI, SCC)
}

plot5_1 <- function (NEI, SCC){
	#we only want to see Baltimore city 
	Baltimore <- subset (NEI, fips == "24510")#this is the data for Baltimore city 
	
	#we only want emissions from motor vehicles
	OnRoad <- subset (SCC, Data.Category == "Onroad")
		
	#now with these SCC find the rows in NEI 
	ID_SCC <- OnRoad$SCC	
	OnRoadEmissionsBaltimore <- subset(Baltimore, Baltimore$SCC %in% ID_SCC)
	
	# summarise Emissions by year
	YearSumsEmissions <-summarize(group_by(OnRoadEmissionsBaltimore, year), sum(Emissions))
	#rename columns
	colnames(YearSumsEmissions) <- c("Year", "TotalEmissions")
	
	g <- qplot(Year,TotalEmissions,data=YearSumsEmissions, xlab = "Year", geom = c("point","line"), method="lm",
	          ylab="Total Emissions", main="Motor Vehicle Emissions in Baltimore 1999-2008")
	
	#write to file
	ggsave(filename = "plot5.png", plot= g, width = 8, height = 8, bg="white" ) #8inches by 8inches
	
}

 