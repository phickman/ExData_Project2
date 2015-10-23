## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these
#    four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in 
#    emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)

png(file = "plot3.png", width=720, height=480)

# aggregate/summarise by year, sum emissions (stat=identity) for Baltimore City (fips=24510)
print(qplot(
  factor(year), 
  Emissions, 
  data = NEI[NEI$fips=="24510",],
  fill = type,
  geom = "bar",
  stat = "identity", 
  xlab = "Year", 
  ylab = "PM2.5 Emissions (tons)", 
  main = "PM2.5 Emissions for Baltimore City by Source Type"
  ) + facet_grid(.~type))

dev.off()
