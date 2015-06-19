#Exploratory Data Analysis Mini Project 2 Plot 1
library(plyr)

source("ass1.r")#contains readData function to read data from internet unzip and read to data frames

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008
#plot Emissions Vs year when the data set is passed

plot1 <- function (){
	newlist <- readData() # this list contains NEI, SCC
	plot1_1(newlist$NEI)
}

plot1_1 <- function (NEI){
	
	#using ddply summarise Emissions by year
	YearSums <- ddply(NEI, "year", summarise, sum = sum(Emissions))
	#rename columns
	colnames(YearSums) <- c("Year", "TotalEmissions")

	#write to file
	#launch graphic device PNG file
	png(file = "plot1.png", width = 480, height = 480, bg="white")
	
	#now plot the result
	with(YearSums, plot(Year,TotalEmissions), xlab ="Year", ylab ="Total PM2.5 Emissions")
	model <- lm (TotalEmissions  ~ Year, YearSums)
	abline(model, lwd = 2)
	title (main = "Total Emissions from PM2.5 in the US 1999-2008")
	
	dev.off()
}
