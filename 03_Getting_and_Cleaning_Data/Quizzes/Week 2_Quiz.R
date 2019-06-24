# Question 1. Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories 
#(hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. What time was it created?

library(jsonlite)
library(httpuv)
library(httr)

oauth_endpoints("github") #Find OAuth settings for github

myapp <- oauth_app(appname = "getting-cleaning-data-week2", 
                   key = "aa8e124c14b16d965320",
                   secret = "5be5445448a58e423513679a565d4246e3c22782") #Start authorization process

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp) #Get OAuth credentials

gtoken <- config(token = github_token) #Use API
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json1 <- content(req)

gitDF <- jsonlite::fromJSON(jsonlite::toJSON(json1)) #Convert to data.frame

gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] #Subset data.frame

# Question 2. The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.
# Download the American Community Survey data and load it into an R object called "acs".
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

library(sqldf)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = "/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_2_Quiz_Q2_data.csv", method = "curl")
acs <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/03_Getting_and_Cleaning_Data/Quizzes/Week_2_Quiz_Q2_data.csv")

#Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

sqldf("select pwgtp1 from acs where AGEP < 50")

# Question 3. Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

sqldf("select distinct AGEP from acs")

# Question 4. How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

# http://biostat.jhsph.edu/~jleek/contact.html

# (Hint: the nchar() function in R may be helpful)

con <- url("http://biostat.jhsph.edu/~jleek/contact.html") #Open connection to URL
htmlCode <- readLines(con) #Read content of source page
nchar(htmlCode[10]) #Get number of characters in specific lines
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])
close(con) #Close connection

# Question 5.Read this data set into R and report the 
# sum of the numbers in the fourth of the nine columns.
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
noaa.data <- read.fwf(fileURL, skip = 4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
sum(noaa.data[,4])