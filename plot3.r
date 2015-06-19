#Exploratory Data Analysis Mini Project 2 Plot 1
library(plyr)
library(dplyr)
library (ggplot2)

source("ass1.r")#contains readData function to read data from internet unzip and read to data frames


plot3 <- function (){
	newlist <- readData() # this list contains NEI, SCC
	NEI <- newlist$NEI
	plot3_1(NEI)
}

plot3_1 <- function (NEI){
	
	#we only want to see Baltimore city 
	Baltimore <- subset (NEI, fips == "24510")#this is the data for Baltimore city 
	Baltimore$type <- as.factor(Baltimore$type)#now typeAsFactor is a factor column	
	#now using dplyr summarise the data and store in Summary table yearly sum emissions by type
	BaltimoreSummary <- summarize(group_by(Baltimore, type, year), sum(Emissions))
	colnames(BaltimoreSummary) <- c("Type", "Year", "TotalEmissions")
	
	png(file= "plot3.png", width = 480, height = 480, bg="white")
	#create the plot g
	g <- qplot(Year,TotalEmissions,data=BaltimoreSummary, facets = .~Type, geom = c("point","smooth"), method="lm",
			ylab= "Total Emissions", main = "Emissions by Type in Baltimore(1999-2008)")
	print (g)
	#write to file
	#ggsave(filename = "plot3.png", plot= g, bg="white" ) #8inches by 8inches
	
	dev.off()
}

 