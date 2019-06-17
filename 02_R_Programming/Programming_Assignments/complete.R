#Write a function that reads a directory full of files and 
#reports the number of completely observed cases in each data file. 
#The function should return a data frame where the first column is the 
#name of the file and the second column is the number of complete cases. 

complete <- function(directory, id = 1:332) {
  files <- list.files(directory, full.names = TRUE)
  result <- data.frame()
  for (i in id) {
    data <- read.csv(files[i], header = TRUE)
    data <- na.omit(data)
    nobs <- nrow(data)
    result <- rbind(result, data.frame(i, nobs))
  } 
return(result)
}