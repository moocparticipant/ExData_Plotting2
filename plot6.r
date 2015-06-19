#Exploratory Data Analysis Mini Project 2 Plot 1
library(plyr)
library(dplyr)
library (ggplot2)

source("ass1.r")#contains readData function to read data from internet unzip and read to data frames


plot6 <- function (){
	newlist <- readData() # this list contains NEI, SCC
	NEI <- newlist$NEI
	SCC <- newlist$SCC
	plot6_1(NEI, SCC)
}

plot6_1 <- function (NEI, SCC){
	#we want to see Baltimore city 
	Baltimore <- subset (NEI, fips == "24510")#this is the data for Baltimore city 
	#we want to see LA city 
	LA <- subset (NEI, fips == "06037")#this is the data for LA 
	
	#we only want emissions from motor vehicles
	OnRoad <- subset (SCC, Data.Category == "Onroad")
		
	#now with these SCC find the rows in Baltimore and LA
	ID_SCC <- OnRoad$SCC	
	OnRoadEmissionsBaltimore <- subset(Baltimore, Baltimore$SCC %in% ID_SCC)
	OnRoadEmissionsLA <- subset(LA, LA$SCC %in% ID_SCC)
	# summarise Emissions by year
	BaltimoreSummary <-summarize(group_by(OnRoadEmissionsBaltimore, year), sum(Emissions))
	LASummary <-summarize(group_by(OnRoadEmissionsLA, year), sum(Emissions))
	#rename columns
	colnames(BaltimoreSummary) <- c("Year", "TotalEmissions")
	colnames(LASummary) <- c("Year", "TotalEmissions")
	
	Summary <- BaltimoreSummary
	#add column to summary so that it says Baltimore
	Summary$City <- factor("Baltimore")
	LASummary$City <- factor ("LA")
	
	Summary <-rbind(Summary,LASummary)
	#now our data source looks like this
	#		Year TotalEmissions      City
	#	1 1999      346.82000 Baltimore
	#	2 2002      134.30882 Baltimore
	#	3 2005      130.43038 Baltimore
	#	4 2008       88.27546 Baltimore
	#	5 1999     3931.12000        LA
	#	6 2002     4274.03020        LA
	#	7 2005     4601.41493        LA
	#	8 2008     4101.32100        LA

	g <- qplot(Year,TotalEmissions,data=Summary, color=City, xlab = "Year", geom = c("point","smooth"), method="lm",
	         ylab="Total Emissions", main="Vehicle Emissions Baltimore Vs LA", color = City)
	
	#write to file
	ggsave(filename = "plot6.png", plot= g, width = 4, height = 4, bg="white" ) #8inches by 8inches
	
}

 