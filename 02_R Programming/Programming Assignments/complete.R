#Write a function that reads a directory full of files and 
#reports the number of completely observed cases in each data file. 
#The function should return a data frame where the first column is the 
#name of the file and the second column is the number of complete cases. 

complete <- function(directory, id = 1:323) {
  files <- list.files(directory, full.names = TRUE)
  data <- data.frame()
  for (i in id) {
    totalobs <- sum(complete.cases(read.csv(files[i], header = TRUE)))
    data <- rbind(data, data.frame(i, totalobs))
  } 
return(data)
}

complete("/Users/RebeccaKee/Desktop/coursera data science/02_R Programming/Data/specdata", 30:25)

