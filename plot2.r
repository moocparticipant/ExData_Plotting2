#Exploratory Data Analysis Mini Project 2 Plot 1
library(plyr)

source("ass1.r")#contains readData function to read data from internet unzip and read to data frames


plot2 <- function (){
	newlist <- readData() # this list contains NEI, SCC
	plot2_1(newlist$NEI)
}

plot2_1 <- function (NEI){
	
	#we only want to see Baltimore city 
	Baltimore <- subset (NEI, fips == "24510")#this is the data for Baltimore city
	#using ddply summarise Emissions by year
	YearSums <- ddply(Baltimore, "year", summarise, sum = sum(Emissions))
	#rename columns
	colnames(YearSums) <- c("Year", "TotalEmissions")

	#write to file
	#launch graphic device PNG file
	png(file = "plot2.png", width = 480, height = 480, bg="white" )
	
	#now plot the result
	with(YearSums, plot(Year,TotalEmissions), xlab ="Year", ylab ="Total PM2.5 Emissions")
	title (main = "Total Emissions from PM2.5 in Baltimore 1999-2008")
	
	dev.off()
}
