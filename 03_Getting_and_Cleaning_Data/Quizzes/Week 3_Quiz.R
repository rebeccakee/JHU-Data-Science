# Question 1. The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#and load the data into R. The code book, describing the variable names is here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. 
#Assign that logical vector to the variable agricultureLogical. 
#Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
#which(agricultureLogical)
#What are the first 3 values that result?

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q1_data.csv", method = "curl")
acs <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q1_data.csv")
str(acs)
agricultureLogical <- acs$ACR == 3 & acs$AGS == 6
which(agricultureLogical)

# Question 2. Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
#Use the parameter native=TRUE. 
#What are the 30th and 80th quantiles of the resulting data? 
#(some Linux systems may produce an answer 638 different for the 30th quantile)

library(jpeg)
fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileURL, destfile = "/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q2_data.jpg", method = "curl")
jpg <- readJPEG("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q2_data.jpg", native = TRUE)
quantile(jpg, probs = c(0.3, 0.8), na.rm = TRUE)

# Question 3. Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. 
# How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?

library(dplyr)
GDP.fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
edu.fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(GDP.fileURL, destfile = "/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q3_GDPdata.csv", method = "curl")
download.file(edu.fileURL, destfile = "/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q3_edudata.csv", method = "curl")
GDP <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q3_GDPdata.csv", header = TRUE, skip = 4, nrows = 190, col.names = c("CountryCode", "GDPRank", "X.2", "countryNames", "GDPmillions", "X.5", "X.6", "X.7", "X.8", "X.9"))
GDP <- subset(GDP[,1:5]) #Drop empty columns
edu <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_3_Quiz_Q3_edudata.csv", header = TRUE)
merged.GDP.edu <- merge(GDP, edu, by.x = "CountryCode", by.y = "CountryCode", all = FALSE)
merged.GDP.edu <- arrange(merged.GDP.edu, desc(GDPRank))
merged.GDP.edu[13,"Long.Name.x"]

# Question 4. What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
high.OECD <- filter(merged.GDP.edu, Income.Group == "High income: OECD")
high.nonOECD <- filter(merged.GDP.edu, Income.Group == "High income: nonOECD")
mean(high.OECD$GDPRank, na.rm = TRUE)
mean(high.nonOECD$GDPRank, na.rm = TRUE)

# Question 5. Cut the GDP ranking into 5 separate quantile groups. 
# Make a table versus Income.Group. How many countries are Lower middle income 
# but among the 38 nations with highest GDP?

library(Hmisc)
merged.GDP.edu$GDP.Group <- cut2(merged.GDP.edu$GDPRank, g = 5)
table(merged.GDP.edu$GDP.Group, merged.GDP.edu$Income.Group)

help(merge)
