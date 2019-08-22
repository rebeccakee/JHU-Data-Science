---
author: "Rebecca Kee"
date: "8/21/2019"
output: 
    html_document:
        keep_md: true
---



# Practical Machine Learning Course Project

## Background
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. 

This project uses data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website [here](http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har). (See the section on the Weight Lifting Exercise Dataset).

The training data for this project are available [here](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv).
The test data are available [here](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv).

## Instructions
The goal of this project is to predict the manner in which the participants did the exercise. This is the "classe" variable in the training set. You may use any of the other variables to predict with. You should describe how you built your model, how you used cross validation, what you think the expected out of sample error is, and why you made the choices you did. You will also use your prediction model to predict 20 different test cases.

## Data Processing

### Load data

```r
# Load packages
library(caret)
```

```
## Loading required package: lattice
```

```
## Loading required package: ggplot2
```

```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
# Download data
train.URL <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
train.filename <- "pml-training.csv"
test.URL <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
test.filename <- "pml-testing.csv"

if (!file.exists(train.filename)) {
  download.file(train.URL, train.filename, method = "curl")
}

if (!file.exists(test.filename)) {
  download.file(test.URL, test.filename, method = "curl")
}
# Read data
training <- read.csv(train.filename, na.strings = c("NA", ""))
testing <- read.csv(test.filename, na.strings = c("NA", ""))
```

### Data cleaning and splitting

```r
# Drop columns with NAs; they can't be used as predictors 
training <- select_if(training, colSums(is.na(training)) == 0)
testing <- select_if(testing, colSums(is.na(testing)) == 0)

# Drop first 7 columns; these are participant ids, names, and timestamps that would not be good predictors. 
training <- training[, -c(1:7)]
testing <- testing[, -c(1:7)]

# Split training data into training set and validation set
set.seed(12345)
train.part <- createDataPartition(training$classe, p = 0.7, list = FALSE)
training.sub <- training[train.part, ]
validation <- training[-train.part, ]
```

## Model fitting and prediction with validation set
We will compare predictions with 2 models, gradient boosting (gbm) and random forests (rf). For each model fit, we will also conduct k-fold cross validation with 5 folds. 

### Gradient boosting

```r
# Fit model 
gbm.fit <- train(classe ~ ., 
                 data = training.sub,
                 method = "gbm",
                 trControl = trainControl(method = "cv", number = 5),
                 verbose = FALSE)
print(gbm.fit)
```

```
## Stochastic Gradient Boosting 
## 
## 13737 samples
##    52 predictor
##     5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Cross-Validated (5 fold) 
## Summary of sample sizes: 10987, 10990, 10990, 10991, 10990 
## Resampling results across tuning parameters:
## 
##   interaction.depth  n.trees  Accuracy   Kappa    
##   1                   50      0.7512519  0.6846488
##   1                  100      0.8210643  0.7734705
##   1                  150      0.8551333  0.8167032
##   2                   50      0.8546219  0.8157628
##   2                  100      0.9080566  0.8836855
##   2                  150      0.9324431  0.9145176
##   3                   50      0.8994658  0.8727338
##   3                  100      0.9419081  0.9265025
##   3                  150      0.9613446  0.9511022
## 
## Tuning parameter 'shrinkage' was held constant at a value of 0.1
## 
## Tuning parameter 'n.minobsinnode' was held constant at a value of 10
## Accuracy was used to select the optimal model using the largest value.
## The final values used for the model were n.trees = 150,
##  interaction.depth = 3, shrinkage = 0.1 and n.minobsinnode = 10.
```

Now, we predict with the validation set. 

```r
predict.gbm <- predict(gbm.fit, newdata = validation)

# Calculate out-of-sample accuracy 
confusionMatrix(predict.gbm, validation$classe)$overall["Accuracy"]
```

```
##  Accuracy 
## 0.9590484
```
Since accuracy is about 88%, the out-of-sample error is about 12%. Not bad, but let's see if random forests does better. 

### Random forests

```r
# Fit model 
rf.fit <- train(classe ~ ., 
                 data = training.sub,
                 method = "rf",
                 trControl = trainControl(method = "cv", number = 5),
                 verbose = FALSE)
print(rf.fit)
```

```
## Random Forest 
## 
## 13737 samples
##    52 predictor
##     5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Cross-Validated (5 fold) 
## Summary of sample sizes: 10990, 10989, 10990, 10989, 10990 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy   Kappa    
##    2    0.9919924  0.9898702
##   27    0.9917014  0.9895020
##   52    0.9856592  0.9818581
## 
## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was mtry = 2.
```

Now, we predict with the validation set. 

```r
predict.rf <- predict(rf.fit, newdata = validation)

# Calculate out-of-sample accuracy 
confusionMatrix(predict.rf, validation$classe)$overall["Accuracy"]
```

```
##  Accuracy 
## 0.9940527
```
The accuracy with random forests is about 98%, which means out-of-sample error is about 2%. This will be the chosen model, since it has a higher accuracy than gradient boosting.

### Prediction with test set 

Now, let's predict with the actual test set using the random forests model.

```r
predict.test <- predict(rf.fit, newdata = testing)
predict.test
```

```
##  [1] B A B A A E D B A A B C B A E E A B B B
## Levels: A B C D E
```
