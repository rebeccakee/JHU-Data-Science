# Instructions
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 
# This project utilizes data collected from the accelerometers from the Samsung Galaxy S smartphone.
# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Load required packages
library(dplyr) 

# Download data -----------------------------------------------------------

zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCI HAR Dataset.zip"

if (!file.exists(zipfile)) {
  download.file(zipURL, zipfile, method = "curl")
}

dataset.name <- "UCI HAR Dataset"
if (!file.exists(dataset.name)) {
  unzip(zipfile)
}

# Read data ---------------------------------------------------------------

# Read features
features <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE, col.names = c("n", "feature"))

# Read activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Read training data 
train.subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity code")
train.data <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)

# Read test data
test.subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity code")
test.data <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)


# Merge data --------------------------------------------------------------

merged.train <- cbind(train.subjects, train.activity, train.data)
merged.test <- cbind(test.subjects, test.activity, test.data)
merged.all <- rbind(merged.train, merged.test)

# Assign column names 
colnames(merged.all) <- c("subject", "activity", features$feature)

# Remove temp data tables to reduce memory
rm(train.subjects, train.activity, train.data, test.subjects, test.activity, test.data, merged.train, merged.test)

# Extract only the measurements on the mean and standard deviation --------

# Identify columns with subject, activity, and measurements on mean and SD
wanted.columns <- grepl("subject|activity|mean|std", colnames(merged.all))

# Subset to only relevant columns
merged.all <- merged.all[, wanted.columns]

# Use descriptive activity names to name the activities in the data --------
merged.all$activity <- factor(merged.all$activity, levels = activities$code, labels = activities$activity)

# Label the dataset with descriptive variable names ------------------------

#Create variable for new column names 
new.colnames <- colnames(merged.all)

# First remove special characters and typos
new.colnames <- gsub("[()-]", "", new.colnames)
new.colnames <- gsub("BodyBody", "Body", new.colnames)

# Spell out abbreviations
new.colnames <- gsub("^t", "time", new.colnames)
new.colnames <- gsub("^f", "frequency", new.colnames)
new.colnames <- gsub("Acc", "Accelerometer", new.colnames)
new.colnames <- gsub("Gyro", "Gyroscope", new.colnames)
new.colnames <- gsub("Mag", "Magnitude", new.colnames)
new.colnames <- gsub("Freq", "Frequency", new.colnames)
new.colnames <- gsub("mean", "Mean", new.colnames)
new.colnames <- gsub("std", "StandardDeviation", new.colnames)

#Assign new column names to dataset
colnames(merged.all) <- new.colnames


# Calculate means for each variable by subject and activity ---------------
merged.means <- merged.all %>% 
  group_by(subject, activity) %>%
  summarize_all(list(mean))

# Create new tidy dataset -------------------------------------------------
write.table(merged.means, file = "tidy_data.txt", quote = FALSE, row.names = FALSE)

