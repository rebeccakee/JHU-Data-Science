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
NEI_data <- merge(NEI_data, SCC, by = "SCC", no.dups = FALSE)
# Drop irrelevant columns
NEI_data <- subset(NEI_data[ ,1:8])

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
  
library(dplyr)
library(ggplot2)

# Subset to Baltimore City only
NEI_subset <- filter(NEI_data, fips=="24510")

# Subset to emissions from motor vehicle sources only
motorveh <- grepl("vehicle", NEI_subset$Short.Name, ignore.case = TRUE) #Look for motor vehicles
NEI_subset <- NEI_subset[motorveh, ]

# Sum PM2.5 emissions
totalemissions <- NEI_subset %>% 
  group_by(year) %>%
  summarize(sum(Emissions))
colnames(totalemissions) = c("year", "emissions")
format(totalemissions$emissions, scientific = FALSE)

# Plot total emissions by year
png("plot5.png")
ggplot(totalemissions, aes(factor(year), emissions, fill = year)) + 
  geom_col(show.legend = FALSE) +
  labs(x = "Year", 
       y = expression('Total PM'[2.5]*' emission (tons)'), 
       title = expression('Total PM'[2.5]*' emission from motor vehicles in Baltimore City by year')
  ) +
  ylim(range(pretty(c(0, totalemissions$emissions)))) + 
  theme_bw()
dev.off()