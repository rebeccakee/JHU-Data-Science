#Write a function called rankhospital that takes three arguments: 
#the 2-character abbreviated name of a state (state), an outcome (outcome), 
#and the ranking of a hospital in that state for that outcome (num).
#The function reads the outcome-of-care-measures.csv file and 
#returns a character vector with the name of the hospital that has the ranking specified by the num argument.
#The num argument can take values “best”, “worst”, or an integer indicating the ranking
#(smaller numbers are better). If the number given by num is larger than the number of hospitals in that
#state, then the function should return NA. Hospitals that do not have data on a particular outcome should
#be excluded from the set of hospitals when deciding the rankings. Ties should be broken by using the hospital name.
#The function should check the validity of its arguments. If an invalid state value is passed to rankhospital,
#the function should throw an error via the stop function with the exact message “invalid state”. If an invalid
#outcome value is passed to rankhospital, the function should throw an error via the stop function with
#the exact message “invalid outcome”.

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/02_R_Programming/Data/ProgAssignment3_data/outcome-of-care-measures.csv", colClasses = "character")
  outcomes.df <- cbind.data.frame(data[, 2], #Hospital name
                         data[, 7], #State
                         as.numeric(data[, 11]), #30-day mortality, heart attack
                         as.numeric(data[, 17]), #30-day mortality, heart failure
                         as.numeric(data[, 23]), #30-day mortality, pneumonia
                         stringsAsFactors = FALSE)
  colnames(outcomes.df) <- c("Hospital", "State", "Heart attack", "Heart failure", "Pneumonia")
  
  ## Check that state and outcome are valid
  if (!state %in% outcomes.df[, "State"]) {
    stop("invalid state")
  } 
  else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("invalid outcome")
  } 
  ## Return hospital name in that state with the given rank for 30-day mortality rate
  state.subset <- subset(outcomes.df, state == df$State) #Subset to state of interest only
  if (outcome == "heart attack") {
      col <- 3
  } 
  else if (outcome == "heart failure") {
      col <- 4
  } 
  else if (outcome == "pneumonia") {
      col <- 5
  }
  hospitals.order <- state.subset[order(state.subset[, col], state.subset[, "Hospital"], decreasing = FALSE), ] #Order by outcome, then by hospital name to break ties
  hospitals.order <- hospitals.order[(!is.na(hospitals.order[, col])), ] #Remove rows with NA
  if (num == "best") {
    num <- 1
  }
  else if (num == "worst") {
    num <- nrow(hospitals.order)
  } 
  return(hospitals.order[num,"Hospital"])
}