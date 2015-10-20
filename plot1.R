## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting 
#    system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)
totalPm <- summarise(group_by(NEI, year), sum(Emissions))
names(totalPm) <- c("Year", "Emissions")

# reduce the magnitude of the emissions so the Y axis is neater
totalPm$Emissions <- totalPm$Emissions/1000

png("plot1.png", height=480, width=480)
barplot(totalPm$Emissions, names.arg = totalPm$Year, xlab = "Year", ylab = "PM2.5 Emissions (1000's tons)", main = "Total USA PM2.5 Emissions")
dev.off()
