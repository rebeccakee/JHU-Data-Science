data <- data.frame(read.csv("/Users/RebeccaKee/Desktop/coursera data science/02_R Programming/Quizzes/Week 1_Quiz Data.csv", header=TRUE))

# Question 11. In the dataset provided for this Quiz, what are the column names of the dataset?

colnames(data)

# Question 12. Extract the first 2 rows of the data frame and print them to the console. What does the output look like?

data[1:2, ]

# Question 13. How many observations (i.e. rows) are in this data frame?
  
nrow(data)

# Question 14. Extract the last 2 rows of the data frame and print them to the console. What does the output look like?

tail(data, 2)

#Question 15. What is the value of Ozone in the 47th row?

data[47, ]

# Question 16. How many missing values are in the Ozone column of this data frame?

missing.ozone <- is.na(data$Ozone)

sum(missing.ozone)

# Question 17. What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.

complete.ozone <- data$Ozone[!missing.ozone]

mean(complete.ozone)

# Question 18.Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?

missing.solar <- is.na(data$Solar.R)

subset <- na.omit(data[data$Ozone>31 & data$Temp >90, ])

mean(subset$Solar.R) 

# Question 19. What is the mean of "Temp" when "Month" is equal to 6?

data.June <- data[data$Month == 6, ]

data.June

mean(data.June$Temp)

#Question 20. What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?

data.May <- data[data$Month == 5, ]

max(data.May$Ozone, na.rm=TRUE)
