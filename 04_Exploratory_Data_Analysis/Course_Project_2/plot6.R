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
NEI_data <- merge(NEI_data, SCC, by = "SCC", no.dups = TRUE)
# Drop irrelevant columns
NEI_data <- subset(NEI_data[ ,1:8])

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips=="06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
library(dplyr)
library(ggplot2)

# Subset to Baltimore City and Los Angeles only
NEI_subset <- filter(NEI_data, fips %in% c("24510", "06037"))

# Subset to emissions from motor vehicle sources only
motorveh <- grepl("vehicles", NEI_subset$Short.Name, ignore.case = TRUE) #Look for motor vehicles
NEI_subset <- NEI_subset[motorveh, ]

# Sum PM2.5 emissions
totalemissions <- NEI_subset %>% 
  group_by(fips, year) %>%
  summarize(sum(Emissions))
colnames(totalemissions) = c("location", "year", "emissions")
format(totalemissions$emissions, scientific = FALSE)
totalemissions$location <- gsub("06037", "Los Angeles County", totalemissions$location)
totalemissions$location <- gsub("24510", "Baltimore City", totalemissions$location)

# Plot total emissions by year
png("plot6.png")
ggplot(totalemissions, aes(factor(year), emissions, fill = location)) + 
  geom_col(show.legend = FALSE) +
  facet_grid(. ~ location) +
  labs(x = "Year", 
       y = expression('Total PM'[2.5]*' emission (tons)'), 
       title = expression('Total PM'[2.5]*' emission from motor vehicle sources')
  ) +
  ylim(range(pretty(c(0, totalemissions$emissions)))) + 
  theme_bw()
dev.off()