## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
library(ggplot2)

# aggregate/summarise by year, sum emissions (stat=identity) where SCC contains 'coal' for Baltimore City (fips=24510)
qplot(
    factor(year), 
    Emissions, 
    data = NEI[NEI$fips == "24510" & NEI$SCC %in% SCC$SCC[grepl("[Vv]ehicle", SCC$SCC.Level.Two)],], 
    geom = "bar",
    stat = "identity", 
    xlab = "Year", 
    ylab = "PM2.5 Emissions (tons)", 
    main = "Baltimore City Vehicle PM2.5 Emissions"
)

ggsave(file="plot5.png")