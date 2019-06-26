# Question 1. The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?
  
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_4_Quiz_Q1_data.csv", method = "curl")
acs <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_4_Quiz_Q1_data.csv")
split.acs <- strsplit(names(acs), "wgtp")
split.acs[[123]]

# Question 2. Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. 
# What is the average?

GDP <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q3_GDPdata.csv", header = TRUE, skip = 4, nrows = 190, col.names = c("CountryCode", "GDPRank", "X.2", "countryNames", "GDPmillions", "X.5", "X.6", "X.7", "X.8", "X.9"))
GDP <- subset(GDP[,1:5]) #Drop empty columns
GDP$GDPmillions <- as.numeric(gsub(",", "", GDP$GDPmillions))
mean(GDP$GDPmillions, na.rm = T)

# Question 3. In the data set from Question 2 what is a regular expression 
# that would allow you to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United?

grep("^United", GDP$countryNames, value = TRUE)

# Question 4. Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. 
# Of the countries for which the end of the fiscal year is available, how many end in June?

GDP <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q3_GDPdata.csv", header = TRUE, skip = 4, nrows = 190, col.names = c("CountryCode", "GDPRank", "X.2", "countryNames", "GDPmillions", "X.5", "X.6", "X.7", "X.8", "X.9"))
GDP <- subset(GDP[,1:5]) #Drop empty columns
edu <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q3_edudata.csv", header = TRUE)
merged.GDP.edu <- merge(GDP, edu, by.x = "CountryCode", by.y = "CountryCode", all = FALSE)
merged.GDP.edu <- arrange(merged.GDP.edu, GDPRank)
table(grepl("^Fiscal year end: June", merged.GDP.edu$Special.Notes))

# Question 5. You can use the quantmod (http://www.quantmod.com/) package 
# to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. 
# Use the following code to download data on Amazon's stock price 
# and get the times the data was sampled.
# How many values were collected in 2012? How many values were collected on Mondays in 2012?

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
table(grepl("^2012", sampleTimes))
sampleTimes.reformat <- format(sampleTimes, "%a %Y")
table(grepl("Mon 2012", sampleTimes.reformat))
