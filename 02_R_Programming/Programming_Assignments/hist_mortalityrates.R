outcome <- read.csv("/Users/RebeccaKee/Desktop/coursera data science/02_R Programming/Data/ProgAssignment3_data/outcome-of-care-measures.csv", colClasses = "character")
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11], 
     main = "Histogram of 30-day mortality rates from heart attack",
     xlab = "Mortality rate",
     ylab = "Number of hospitals")