# Question 1. The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# How many properties are worth $1,000,000 or more?
library(data.table)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_1_Quiz_Q1_data.csv", method = "curl")
housing.data <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_1_Quiz_Q1_data.csv")
housing.dt <- data.table(housing.data)
housing.dt[, .N, by = VAL]

# Question 2. Use the data you loaded from Question 1. 
# Consider the variable FES in the code book. 
# Which of the "tidy data" principles does this variable violate?

#Ans: Tidy data has one variable per column.

# Question 3. Download the Excel spreadsheet on Natural Gas Aquisition Program here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
#Read rows 18-23 and columns 7-15 into R and assign the result to a variable called: dat
# What is the value of:sum(dat$Zip*dat$Ext,na.rm=T)

library(readxl)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL, destfile = "/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_1_Quiz_Q3_data.xlsx", method = "curl")
dat <- read_xlsx("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_1_Quiz_Q3_data.xlsx", 
                 col_names = TRUE, 
                 col_types = "numeric")[18:23, 7:15]
sum(dat$...7*dat$...12, na.rm=T)
  
# Question 4. Read the XML data on Baltimore restaurants from here:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml

# How many restaurants have zipcode 21231?

library(XML)
library(ReCurl)
fileURL <- getURL("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml")
doc <- xmlParse(fileURL)

# Question 5. The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# using the fread() command load the data into an R object "DT"
# The following are ways to calculate the average value of the variable "pwgtp15" 
# broken down by sex. Using the data.table package, which will deliver the fastest user time?

library(data.table)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = "/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_1_Quiz_Q5_data.csv", method = "curl")
DT <- fread("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_1_Quiz_Q5_data.csv")
system.time(DT[,mean(pwgtp15),by=SEX])
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
