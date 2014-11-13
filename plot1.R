## This script will result in a plot to answer question 1 for project 2 of the Exploratory Data Analysis course of Coursera.

## This script assumes that there is a directory called "exdata-data-NEI_data" with the data in it.

plot1 <- function(){
  ## Read the data into R
  data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  
  ## Sum up all emissions by year and save into a second variable
  year_sum <- aggregate(data$Emissions, by = list(data$year), FUN = sum)
  
  ## Create a PNG file for this graph
  png(filename = "plot1.png")
  
  ## Create the Graph
  with(year_sum, plot(Group.1, x, type = "b", ylab = expression(PM[2.5]), xlab = "Years", xaxp = c(1999,2008,3), lwd = 4, main = expression("Total emissions: PM"[2.5])))
  ## axis(1, at = c(1998,2002,2005,2008))
  
  ## Close and write the file
  dev.off()
}