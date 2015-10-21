## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
library(ggplot2)

# aggregate/summarise by year, sum emissions (stat=identity) where SCC contains 'coal'
qplot(
    factor(year), 
    Emissions/1000, 
    data = NEI[NEI$SCC %in% SCC$SCC[grepl("[Cc]oal", SCC$EI.Sector)],], 
    geom = "bar",
    stat = "identity", 
    xlab = "Year", 
    ylab = "PM2.5 Emissions (1000's tons)", 
    main = "USA Total Coal Combustion-Related PM2.5 Emissions"
)

ggsave(file="plot4.png")