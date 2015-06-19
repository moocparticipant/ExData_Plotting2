#Exploratory Data Analysis Mini Project 2 Plot 1
library(plyr)
library(dplyr)
library (ggplot2)

source("ass1.r")#contains readData function to read data from internet unzip and read to data frames


plot4 <- function (){
	newlist <- readData() # this list contains NEI, SCC
	NEI <- newlist$NEI
	SCC <- newlist$SCC
	plot4_1(NEI, SCC)
}

plot4_1 <- function (NEI, SCC){
	
	l1 <- grepl("Coal", SCC$Short.Name)#get a logical vector where Coal is found
	l2 <- grepl("Coal", SCC$Short.Name)#get a logical vector where Coal is found
	
	SCC$l1 <- l1
	SCC$l2 <- l2
	
	Coal <- subset(SCC, l1 == TRUE & l2 == TRUE) #returns 230 lines
	
	#now with these SCC find the rows in NEI 
	ID_SCC <- Coal$SCC	
	CoalEmissions <- subset(NEI, NEI$SCC %in% ID_SCC)
	
	# summarise Emissions by year
	YearSumsCoalEmissions <-summarize(group_by(CoalEmissions, year), sum(Emissions))
	#rename columns
	colnames(YearSumsCoalEmissions) <- c("Year", "TotalEmissions")
	
	g <- qplot(Year,TotalEmissions,data=YearSumsCoalEmissions, xlab = "Year", geom = c("point","smooth"), method="lm",
	          ylab="Total Emissions", main="Coal related Emissions in the US 1999-2008")
	
	#write to file
	#ggsave(filename = "plot4.png", plot= g, width = 4, height = 4, bg="white" ) #8inches by 8inches
	png(file = "plot4.png",width = 480, height = 480, bg="white")
	print(g)
	dev.off()
}

 