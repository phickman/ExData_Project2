## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
#    Use the base plotting system to make a plot answering this question.
library(dplyr)
baltPm <- filter(NEI, fips == "24510")
baltPm <- summarise(group_by(baltPm, year), sum(Emissions))
names(totalPm) <- c("Year", "Emissions")

png("plot2.png", height=480, width=480)
barplot(baltPm$`sum(Emissions)`, names.arg = baltPm$year, xlab = "Year", ylab = "PM2.5 Emissions (tons)", main = "Total Baltimore City PM2.5 Emissions")
dev.off()
