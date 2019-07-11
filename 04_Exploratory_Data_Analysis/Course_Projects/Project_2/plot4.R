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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(dplyr)
library(ggplot2)

# Subset to coal combustion-related sources only
coalsource <- grepl("coal", NEI_data$Short.Name, ignore.case = TRUE) #Look for coal sources
coal_NEI <- NEI_data[coalsource, ]

# Sum PM2.5 emissions
totalemissions <- coal_NEI %>% 
  group_by(year) %>%
  summarize(sum(Emissions))
colnames(totalemissions) = c("year", "emissions")
format(totalemissions$emissions, scientific = FALSE)

# Plot total emissions by year
png("plot4.png")
ggplot(totalemissions, aes(factor(year), emissions, fill = year)) + 
  geom_col(show.legend = FALSE) +
  labs(x = "Year", 
       y = expression('Total PM'[2.5]*' emission (tons)'), 
       title = expression('Total PM'[2.5]*' emission from coal combustion-related sources by year')
  ) +
  ylim(range(pretty(c(0, totalemissions$emissions)))) + 
  theme_bw()
dev.off()