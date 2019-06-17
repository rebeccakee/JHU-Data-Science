#Write a function called rankall that takes two arguments: an outcome name (outcome) and a hospital ranking (num). 
#The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
#containing the hospital in each state that has the ranking specified in num. 
#For example the function call rankall("heart attack", "best") would return a data frame containing 
#the names of the hospitals that are the best in their respective states for 30-day heart attack death rates. 
#The function should return a value for every state (some may be NA). 
#The first column in the data frame is named hospital, which contains
#the hospital name, and the second column is named state, which contains the 2-character abbreviation for
#the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of
#hospitals when deciding the rankings. Ties should be broken by using the hospital name.
#The function should check the validity of its arguments. 
#If an invalid outcome value is passed to rankall, the function should throw an error 
#via the stop function with the exact message “invalid outcome”. 
#The num variable can take values “best”, “worst”, or an integer indicating the ranking (smaller numbers are better).
#If the number given by num is larger than the number of hospitals in that state, then the function should
#return NA.

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("/Users/RebeccaKee/Desktop/coursera_data_science/02_R_Programming/Data/ProgAssignment3_data/outcome-of-care-measures.csv", colClasses = "character")
  outcomes.df <- cbind.data.frame(data[, 2], #Hospital name
                         data[, 7], #State
                         as.numeric(data[, 11]), #30-day mortality, heart attack
                         as.numeric(data[, 17]), #30-day mortality, heart failure
                         as.numeric(data[, 23]), #30-day mortality, pneumonia
                         stringsAsFactors = FALSE)
  colnames(outcomes.df) <- c("Hospital", "State", "Heart attack", "Heart failure", "Pneumonia")
  
  ## Check that outcome is valid
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("invalid outcome")
  } 
  ## For each state, find the hospital of the given rank
  if (outcome == "heart attack") {
    col <- 3
  } 
  else if (outcome == "heart failure") {
    col <- 4
  } 
  else if (outcome == "pneumonia") {
    col <- 5
  }
  hosp.order <- outcomes.df[order(outcomes.df[, col], outcomes.df[, "Hospital"], decreasing = FALSE), ] #Order by outcome, then by hospital name to break ties
  hosp.order <- hosp.order[(!is.na(hosp.order[, col])), ] #Remove rows with NA  
  hosp.bystate <- split(hosp.order, hosp.order$State) #Split hospitals by state
  hosp.names <- data.frame(0,2) #Create empty data frame to store hospitals by state
  lapply(hosp.bystate, function(each.state, num) {
    if (num == "best") {
      rbind(hosp.names, each.state[1,1:2])
    }
    else if (num == "worst") {
      rbind(hosp.names, each.state[nrow(each.state),1:2])
    }
    else {
      rbind(hosp.names, each.state[num,1:2])
    }
  }, num)
  ## Return a data frame with the hospital names and the (abbreviated) state name
  colnames(hosp.names) <- c("hospital", "state")
  return(hosp.names)
}

head(rankall("heart attack", 20), 10)
