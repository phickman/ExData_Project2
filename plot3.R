## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these
#    four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in 
#    emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)

qplot(
  factor(year), 
  Emissions, 
  data = NEI[NEI$fips=="24510",], 
  geom="bar",
  stat = "identity", 
  xlab = "Year", 
  laby = "PM2.5 Emissions (tons)", 
  main = "PM2.5 Emissions for Baltimore City by Source"
  )

ggsave(file="plot3.png")