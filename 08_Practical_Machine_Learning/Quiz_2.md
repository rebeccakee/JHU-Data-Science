---
author: "Rebecca Kee"
date: "8/16/2019"
output: 
    html_document: 
        keep_md: true
---



# Practical Machine Learning Quiz 2 

Q1. Load the Alzheimer's disease data using the commands:

```r
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
```

Which of the following commands will create non-overlapping training and test sets with about 50% of the observations assigned to each?

```r
# Answer: 
adData = data.frame(diagnosis,predictors)
testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]
```


Q2. Load the cement data using the commands:

```r
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
```
Make a plot of the outcome (CompressiveStrength) versus the index of the samples. Color by each of the variables in the data set (you may find the cut2() function in the Hmisc package useful for turning continuous covariates into factors). What do you notice in these plots?

```r
library(GGally)
```

```
## Registered S3 method overwritten by 'GGally':
##   method from   
##   +.gg   ggplot2
```

```r
library(ggplot2)
library(Hmisc)
```

```
## Loading required package: survival
```

```
## 
## Attaching package: 'survival'
```

```
## The following object is masked from 'package:caret':
## 
##     cluster
```

```
## Loading required package: Formula
```

```
## 
## Attaching package: 'Hmisc'
```

```
## The following objects are masked from 'package:base':
## 
##     format.pval, units
```

```r
library(cowplot)
```

```
## 
## ********************************************************
```

```
## Note: As of version 1.0.0, cowplot does not change the
```

```
##   default ggplot2 theme anymore. To recover the previous
```

```
##   behavior, execute:
##   theme_set(theme_cowplot())
```

```
## ********************************************************
```

```r
# Create index and factorize CompressiveStrength
index <- seq_along(1:nrow(training))
training$CompressiveStrength <- cut2(training$CompressiveStrength, g = 10)

# Plot graph
p1 <- ggplot(data = training, aes(y = CompressiveStrength, x = index, color = FlyAsh)) +
  geom_point() +
  labs(x = "Compressive Strength",
       y = "Index") +
    theme_bw() 

p2 <- ggplot(data = training, aes(y = CompressiveStrength, x = index, color = BlastFurnaceSlag)) +
  geom_point() +
  labs(x = "Compressive Strength",
       y = "Index") +
    theme_bw() 

p3 <- ggplot(data = training, aes(y = CompressiveStrength, x = index, color = Water)) +
  geom_point() +
  labs(x = "Compressive Strength",
       y = "Index") +
    theme_bw() 

p4 <- ggplot(data = training, aes(y = CompressiveStrength, x = index, color = Superplasticizer)) +
  geom_point() +
  labs(x = "Compressive Strength",
       y = "Index") +
    theme_bw() 

p5 <- ggplot(data = training, aes(y = CompressiveStrength, x = index, color = CoarseAggregate)) +
  geom_point() +
  labs(x = "Compressive Strength",
       y = "Index") +
    theme_bw() 

p6 <- ggplot(data = training, aes(y = CompressiveStrength, x = index, color = FineAggregate)) +
  geom_point() +
  labs(x = "Compressive Strength",
       y = "Index") +
    theme_bw() 

p7 <- ggplot(data = training, aes(y = CompressiveStrength, x = index, color = Age)) +
  geom_point() +
  labs(x = "Compressive Strength",
       y = "Index") +
    theme_bw() 

p8 <- ggplot(data = training, aes(y = CompressiveStrength, x = index, color = Cement)) +
  geom_point() +
  labs(x = "Compressive Strength",
       y = "Index") +
    theme_bw() 

plot_grid(p1, p2, p3, p4, align = "h", nrow = 2, ncol = 2)
```

![](Quiz_2_files/figure-html/unnamed-chunk-4-1.png)<!-- -->


```r
plot_grid(p5, p6, p7, p8, align = "v", nrow = 2, ncol = 2)
```

![](Quiz_2_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

Answer: There is a non-random pattern in the plot of the outcome versus index that does not appear to be perfectly explained by any predictor suggesting a variable may be missing.

Q3. Load the cement data using the commands:

```r
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
```

Make a histogram and confirm the SuperPlasticizer variable is skewed. Normally you might use the log transform to try to make the data more symmetric. Why would that be a poor choice for this variable?

```r
hist(concrete$Superplasticizer, 
     breaks = 5, 
     xlab = "Superplasticizer",
     ylim = range(0, 500),
     col = "light blue")
```

![](Quiz_2_files/figure-html/unnamed-chunk-7-1.png)<!-- -->
Answer: There are a large number of values that are the same and even if you took the log(SuperPlasticizer + 1) they would still all be identical so the distribution would not be symmetric.

Q4. Load the Alzheimer's disease data using the commands:

```r
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433, kind = "Mersenne-Twister", normal.kind = "Inversion")
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```

Find all the predictor variables in the training set that begin with IL. Perform principal components on these variables with the preProcess() function from the caret package. Calculate the number of principal components needed to capture 90% of the variance. How many are there?

```r
trainIL <- training[, grep("^IL", names(training))]
PCA.train <- preProcess(trainIL, method = "pca", thresh = 0.90)
PCA.train
```

```
## Created from 251 samples and 12 variables
## 
## Pre-processing:
##   - centered (12)
##   - ignored (0)
##   - principal component signal extraction (12)
##   - scaled (12)
## 
## PCA needed 9 components to capture 90 percent of the variance
```

Q5. Load the Alzheimer's disease data using the commands:

```r
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433, sample.kind = "Rounding")
```

```
## Warning in set.seed(3433, sample.kind = "Rounding"): non-uniform 'Rounding'
## sampler used
```

```r
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```

Create a training data set consisting of only the predictors with variable names beginning with IL and the diagnosis. Build two predictive models, one using the predictors as they are and one using PCA with principal components explaining 80% of the variance in the predictors. Use method="glm" in the train function.

```r
# Create training set with IL variables and diagnosis only
trainIL <- training[, grep("^IL|diagnosis", names(training))]
testIL <- testing[, grep("^IL|diagnosis", names(testing))]

# Model without PCA
fit.noPCA <- train(diagnosis ~ ., data = trainIL, method = "glm")
prediction.noPCA <- predict(fit.noPCA, newdata = testIL)
confusionMatrix(prediction.noPCA, testIL$diagnosis)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Impaired Control
##   Impaired        2       9
##   Control        20      51
##                                          
##                Accuracy : 0.6463         
##                  95% CI : (0.533, 0.7488)
##     No Information Rate : 0.7317         
##     P-Value [Acc > NIR] : 0.96637        
##                                          
##                   Kappa : -0.0702        
##                                          
##  Mcnemar's Test P-Value : 0.06332        
##                                          
##             Sensitivity : 0.09091        
##             Specificity : 0.85000        
##          Pos Pred Value : 0.18182        
##          Neg Pred Value : 0.71831        
##              Prevalence : 0.26829        
##          Detection Rate : 0.02439        
##    Detection Prevalence : 0.13415        
##       Balanced Accuracy : 0.47045        
##                                          
##        'Positive' Class : Impaired       
## 
```


```r
# Model with PCA
fit.PCA <- train(diagnosis ~ ., 
                 data = trainIL, 
                 method = "glm", 
                 preProcess = "pca", 
                 trControl = trainControl(preProcOptions = list(thresh=0.8)))
prediction.PCA <- predict(fit.PCA, newdata = testIL)
confusionMatrix(prediction.PCA, testIL$diagnosis)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Impaired Control
##   Impaired        3       4
##   Control        19      56
##                                           
##                Accuracy : 0.7195          
##                  95% CI : (0.6094, 0.8132)
##     No Information Rate : 0.7317          
##     P-Value [Acc > NIR] : 0.651780        
##                                           
##                   Kappa : 0.0889          
##                                           
##  Mcnemar's Test P-Value : 0.003509        
##                                           
##             Sensitivity : 0.13636         
##             Specificity : 0.93333         
##          Pos Pred Value : 0.42857         
##          Neg Pred Value : 0.74667         
##              Prevalence : 0.26829         
##          Detection Rate : 0.03659         
##    Detection Prevalence : 0.08537         
##       Balanced Accuracy : 0.53485         
##                                           
##        'Positive' Class : Impaired        
## 
```

