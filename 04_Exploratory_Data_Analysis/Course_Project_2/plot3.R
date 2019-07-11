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

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

# Subset to Baltimore City only
bc_NEI <- filter(NEI_data, fips=="24510")

# Sum PM2.5 emissions by source type for each year
totalemissions <- bc_NEI %>% 
  group_by(year, type) %>%
  summarize(sum(Emissions))
totalemissions$type <- factor(totalemissions$type, levels = c("POINT", "NONPOINT","ON-ROAD", "NON-ROAD"))
colnames(totalemissions) = c("year", "type", "emissions")
format(totalemissions$emissions, scientific = FALSE)

# Plot total emissions by source type and year
png("plot3.png")
ggplot(totalemissions, aes(factor(year), emissions, fill = type)) + 
  geom_col(show.legend = FALSE) +
  facet_grid(. ~ type) +
  labs(x = "Year", 
       y = expression('Total PM'[2.5]*' emission (tons)'), 
       title = expression('Total PM'[2.5]*' emission in Baltimore City by source and year')
       ) +
  ylim(range(pretty(c(0, totalemissions$emissions)))) + 
  theme_bw()
dev.off()