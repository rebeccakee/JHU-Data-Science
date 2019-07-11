# Download and unzip file if it does not exist
zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipfile <- "exdata_data_NEI_data.zip"

if (!file.exists(zipfile)) {
  download.file(zipURL, zipfile, method = "curl")
}

dataset.name <- "NEI_data"
if (!file.exists(dataset.name)) {
  unzip(zipfile)
}

# Read data
NEI_data <- readRDS("summarySCC_PM25.rds") #PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds") #Source Classification Code Table

# Merge datasets based on SCC
NEI_data <- merge(NEI_data, SCC, by = "SCC")
# Drop irrelevant columns
NEI_data <- subset(NEI_data[ ,1:8])

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

# Sum PM2.5 emissions for each year
totalemissions <- NEI_data %>% 
  group_by(year) %>%
  summarize(sum(Emissions))
  colnames(totalemissions) = c("year", "emissions")
format(totalemissions$emissions, scientific = FALSE)

# Plot total emissions
png("plot1.png")
barplot(height = totalemissions$emissions, 
        names.arg = totalemissions$year, 
        xlab = "Year",
        ylab = expression('Total PM'[2.5]*' emission (tons)'),
        main = expression('Total PM'[2.5]*' emission by year'),
        ylim = range(pretty(c(0, totalemissions$emissions)))
        ) 
dev.off()
