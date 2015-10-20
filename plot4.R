## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
library(dplyr)
library(ggplot2)

# identify those SCC's in the 'Coal' EI sector
NEI2 <- NEI
NEI2$IsCoal <- NEI$SCC %in% SCC$SCC[grepl("[Cc]oal", SCC$EI.Sector)]
NEI2 <- filter(NEI2, IsCoal == TRUE)

# sum the emissions for each year
coalPm <- summarise(group_by(NEI2, year), sum(Emissions))
names(coalPm) <- c("Year", "Emissions")

# reduce the magnitude of the emissions so the Y axis is neater
coalPm$Emissions <- coalPm$Emissions/1000

ggplot(data=coalPm, aes(factor(Year), Emissions, fill=Year)) + geom_bar(stat="identity", fill="green4") + labs(x="Year", y="PM2.5 Emissions (1000's tons)", title="USA Total Coal Combustion-Related PM2.5 Emissions")
ggsave(file="plot4.png")