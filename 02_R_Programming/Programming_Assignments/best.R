#Write a function that takez two arguments: the 2-character abbreviated name of a state and an
#outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
#with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
#in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
#be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that do not have data on a particular
#outcome should be excluded from the set of hospitals when deciding the rankings.
#Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
#be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals “b”, “c”,
#and “f” are tied for best, then hospital “b” should be returned).
#The function should check the validity of its arguments. If an invalid state value is passed to best, the
#function should throw an error via the stop function with the exact message “invalid state”. If an invalid
#outcome value is passed to best, the function should throw an error via the stop function with the exact
#message “invalid outcome”.
best <- function(state, outcome) {
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
  ## Return hospital name in that state with lowest 30-day death rate
  else {
    state.subset <- subset(outcomes.df, state == outcomes.df$State) #Subset to state of interest only
    if (outcome == "heart attack") {
      col <- 3
    } 
    else if (outcome == "heart failure") {
      col <- 4
    } 
    else if (outcome == "pneumonia") {
      col <- 5
    }
    min <- min(state.subset[, col], na.rm = TRUE)
    min_row <- which(as.numeric(state.subset[, col]) == as.numeric(min))
    hospitals <- sort(state.subset[min_row,"Hospital"])
  }
  return(hospitals)
}