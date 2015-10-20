## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
library(dplyr)
library(ggplot2)

# identify those SCC's in the 'Vehicle' EI sector for Baltimore
NEI2 <- filter(NEI, fips == "24510")
NEI2$IsVehicle <- NEI2$SCC %in% SCC$SCC[grepl("[Vv]ehicle", SCC$EI.Sector)]
NEI2 <- filter(NEI2, IsVehicle == TRUE)

vehiclePm <- summarise(group_by(NEI2, year), sum(Emissions))
names(vehiclePm) <- c("Year", "Emissions")

ggplot(data=vehiclePm, aes(factor(Year), Emissions, fill=Year)) + geom_bar(stat="identity", fill="green4") + labs(x="Year", y="PM2.5 Emissions (tons)", title="Baltimore City Vehicle PM2.5 Emissions")
ggsave(file="plot5.png")
