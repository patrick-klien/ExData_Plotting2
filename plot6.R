## This script will result in a plot to answer question 6 for project 2 of the Exploratory Data Analysis course of Coursera.

## This script assumes that there is a directory called "exdata-data-NEI_data" with the data in it.

plot6 <- function(){
  ## Read the data into R
  data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  vari <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
  
  ## Merge the data to work with 1 data frame
  mergeData = merge(data, vari, by.x = "SCC", by.y = "SCC")
  
  ## Subset the data so that we only have data for vehicles.
  data_final <- mergeData[grep("Vehicle", mergeData$EI.Sector),]
  
  ## Subset Baltimore data
  data_final_balt <- subset(data_final, fips == "24510")
  
  ## Subset Los Angeles County data
  data_final_lac <- subset(data_final, fips == "06037")
  
  ## Sum up all emissions by year and save into a second variable for Baltiemore
  year_sum_balt <- aggregate(data_final_balt$Emissions, by = list(data_final_balt$year), FUN = sum)
  
  ## Average all the variables and save into specific variable for Baltimore
  year_avg_balt <- aggregate(data_final_balt$Emissions, by = list(data_final_balt$year), FUN = mean)
  
  ## Sum up all emissions by year and save into a second variable for Los Angeles
  year_sum_lac <- aggregate(data_final_lac$Emissions, by = list(data_final_lac$year), FUN = sum)
  
  ## Average all the variables and save into specific variable for Los Angeles
  year_avg_lac <- aggregate(data_final_lac$Emissions, by = list(data_final_lac$year), FUN = mean)
  
  
  
  ## Create a PNG file for this graph
  png(filename = "plot6.png", width = 960, height = 960)
  
  ## Create the Graph
  par(mfrow = c(2,2))
  
  plot(year_sum_balt$Group.1, year_sum_balt$x, type = "b", ylab = expression(PM[2.5]), xlab = "Years", xaxp = c(1999,2008,3), lwd = 4, main = expression("Total Baltimore Vehicle emissions: PM"[2.5]))
  plot(year_avg_balt$Group.1, year_avg_balt$x, type = "b", ylab = expression(PM[2.5]), xlab = "Years", xaxp = c(1999,2008,3), lwd = 4, main = expression("Average Baltimore Vehicle emissions: PM"[2.5]))
  plot(year_sum_lac$Group.1, year_sum_lac$x, type = "b", ylab = expression(PM[2.5]), xlab = "Years", xaxp = c(1999,2008,3), lwd = 4, main = expression("Total Los Angeles Vehicle emissions: PM"[2.5]))
  plot(year_avg_lac$Group.1, year_avg_lac$x, type = "b", ylab = expression(PM[2.5]), xlab = "Years", xaxp = c(1999,2008,3), lwd = 4, main = expression("Average Los Angeles Vehicle emissions: PM"[2.5]))
  
  ## Close and write the file
  dev.off()
}