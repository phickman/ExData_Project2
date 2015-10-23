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
# add a nice city name column
NEI2 <- mutate(NEI2, City = ifelse(fips == "24510", "Baltimore City", "Los Angeles County"))

png(file = "plot6.png", width=720, height=480)

# aggregate/summarise by year, sum emissions (stat=identity) where SCC contains 'vehicles' for the data (BC & LA)
print(qplot(
    factor(year), 
    Emissions, 
    data = NEI2[NEI2$SCC %in% SCC$SCC[grepl("[Vv]ehicles", SCC$SCC.Level.Two)],], 
    xlab = "Year", 
    ylab = "PM2.5 Emissions (tons)", 
    main = "Vehicle PM2.5 Emissions - Baltimore City v Los Angeles County"
) + facet_grid(.~City) + geom_bar(stat = "identity", aes(fill=City)))

dev.off()
