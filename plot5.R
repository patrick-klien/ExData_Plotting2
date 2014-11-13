## This script will result in a plot to answer question 5 for project 2 of the Exploratory Data Analysis course of Coursera.

## This script assumes that there is a directory called "exdata-data-NEI_data" with the data in it.

plot5 <- function(){
  ## Read the data into R
  data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  vari <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
  
  ## Merge the data to work with 1 data frame
  mergeData = merge(data, vari, by.x = "SCC", by.y = "SCC")
  
  ## Subset the data so that we only have data for vehicles.
  data_final <- mergeData[grep("Vehicle", mergeData$EI.Sector),]
  
  ## Subset Baltimore data
  data_final <- subset(data_final, fips == 24510)
  
  ## Sum up all emissions by year and save into a second variable
  year_sum <- aggregate(data_final$Emissions, by = list(data_final$year), FUN = sum)
  
  ## Average all the variables and save into specific variable.
  year_avg <- aggregate(data_final$Emissions, by = list(data_final$year), FUN = mean)
  
  ## Create a PNG file for this graph
  png(filename = "plot5.png", width = 960, height = 480)
  
  ## Create the Graph
  par(mfrow = c(1,2))
  
  plot(year_sum$Group.1, year_sum$x, type = "b", ylab = expression(PM[2.5]), xlab = "Years", xaxp = c(1999,2008,3), lwd = 4, main = expression("Total Baltimore Vehicle emissions: PM"[2.5]))
  plot(year_avg$Group.1, year_avg$x, type = "b", ylab = expression(PM[2.5]), xlab = "Years", xaxp = c(1999,2008,3), lwd = 4, main = expression("Average Baltimore Vehicle emissions: PM"[2.5]))
  mtext("Coal combustion", outer = TRUE)
  
  ## Close and write the file
  dev.off()
}