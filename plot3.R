## This script will result in a plot to answer question 3 for project 2 of the Exploratory Data Analysis course of Coursera.

## This script assumes that there is a directory called "exdata-data-NEI_data" with the data in it.

plot3 <- function(){
  ## Read the data into R
  data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  
  ## Subset the data so that we only have Baltimore (fips = "24510") data.
  data <- subset(data, fips == 24510, select = c("year", "type", "Emissions"))
  
  ## Load the reshape2 ad ggplot2 libraries
  library(reshape2)
  library(ggplot2)
  
  ## Melt and recast the data applying the sum function
  data <- melt(data, id.vars = c("year", "type"))
  data <- dcast(data, year + type ~ variable, sum)
  
  ## Recategorize variables year and type as factor variables
  data$type <- as.factor(data$type)
  data$year <- as.factor(data$year)
  
  ## Create the Graph
  qplot(year, Emissions, data = data, facets = . ~ type) + geom_point() + geom_smooth(aes(group = 1), method = "lm")
  
  graph = qplot(year, Emissions, data = data, facets = . ~ type) + geom_point() + geom_smooth(aes(group = 1), method = "lm")
  
  ## Write the graph to file
  ggsave(file = "plot3.png", plot = graph)
}