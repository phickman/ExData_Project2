## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
#    in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in 
#    motor vehicle emissions?
library(dplyr)
library(ggplot2)

# only interested in Baltimore and LA
NEI2 <- filter(NEI, fips == "24510" | fips == "06037")
# and vehicles
NEI2$IsVehicle <- NEI2$SCC %in% SCC$SCC[grepl("[Vv]ehicle", SCC$EI.Sector)]
NEI2 <- filter(NEI2, IsVehicle == TRUE)
# add a nice city name column
NEI2 <- mutate(NEI2, City = ifelse(fips == "24510", "Baltimore City", "Los Angeles County"))

vehiclePm <- summarise(group_by(NEI2, City, year), sum(Emissions))
names(vehiclePm) <- c("City", "Year", "Emissions")

ggplot(vehiclePm, aes(factor(Year), Emissions, fill=City)) + geom_bar(stat="identity") + facet_grid(.~City) + labs(x="Year", y="PM2.5 Emissions (tons)", title="Vehicle PM2.5 Emissions - Baltimore City v Los Angeles County")
ggsave(file="plot6.png")
