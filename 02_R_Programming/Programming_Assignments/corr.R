#Write a function that takes a directory of data files and a threshold 
#for complete cases and calculates the correlation between sulfate and nitrate 
#for monitor locations where the number of completely observed cases (on all variables) 
#is greater than the threshold. The function should return a vector of correlations 
#for the monitors that meet the threshold requirement. 
#If no monitors meet the threshold requirement, 
#then the function should return a numeric vector of length 0. 

#NOTE: use RNGkind(sample.kind = "Rounding") before setting seed to produce correct output

corr <- function(directory, threshold = 0) {
  files <- list.files(directory, full.names = TRUE)
  result <- vector(mode = "numeric", length = 0)
  
  for (i in 1:length(files)) {
    data <- read.csv(files[i], header = TRUE)
    completedata <- na.omit(data)
    completecount <- nrow(completedata)
      if (completecount > threshold) {
        correlation <- cor(completedata$sulfate, completedata$nitrate)
        result <- c(result, correlation)
      }
  } 
  
  return(result)
}
   
