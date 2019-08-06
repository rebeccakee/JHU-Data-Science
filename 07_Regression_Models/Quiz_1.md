---
author: "Rebecca Kee"
date: "8/5/2019"
output: 
    html_document: 
        keep_md: true
---



# Regression Models Quiz 1 

Q1. Consider the data set (x) and weights (w) given below:

```r
x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)
```

Give the value of $μ$ that minimizes the least squares equation.

```r
# Calculate weighted average, which is the solution that minimizes the least squares equation
sum(x * w) / sum(w)
```

```
## [1] 0.1471429
```

Q2. Consider the following data set

```r
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
```

Fit the regression through the origin and get the slope treating y as the outcome and x as the regressor. (Hint, do not center the data since we want regression through the origin, not through the means of the data.)

```r
lm(y ~ x - 1) # Adding -1 plots the regression through the origin
```

```
## 
## Call:
## lm(formula = y ~ x - 1)
## 
## Coefficients:
##      x  
## 0.8263
```

Q3. Do  from the datasets package and fit the regression model with mpg as the outcome and weight as the predictor. Give the slope coefficient.

```r
data("mtcars")
lm(mtcars$mpg ~ mtcars$wt)
```

```
## 
## Call:
## lm(formula = mtcars$mpg ~ mtcars$wt)
## 
## Coefficients:
## (Intercept)    mtcars$wt  
##      37.285       -5.344
```

Q4. Consider data with an outcome (Y) and a predictor (X). The standard deviation of the predictor is one half that of the outcome. The correlation between the two variables is .5. What value would the slope coefficient for the regression model with YY as the outcome and XX as the predictor?

```r
# The slope of the regression line is cor(Y, X) * sd(y)/sd(x)
0.5 * (1 / 0.5)
```

```
## [1] 1
```

Q5. Students were given two hard tests and scores were normalized to have empirical mean 0 and variance 1. The correlation between the scores on the two tests was 0.4. What would be the expected score on Quiz 2 for a student who had a normalized score of 1.5 on Quiz 1?

```r
1.5 * 0.4
```

```
## [1] 0.6
```

Q6. Consider the data given by the following:

```r
x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
```

What is the value of the first measurement if x were normalized (to have mean 0 and variance 1)?

```r
mean <- mean(x)
sd <- sd(x)
# Normalize data
(x - mean) / sd
```

```
## [1] -0.9718658  1.5310215 -0.3993969  0.4393366 -0.5990954
```

Q7. Consider the following data set (used above as well). What is the intercept for fitting the model with x as the predictor and y as the outcome?

```r
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

# Fit linear model
lm(y ~ x)
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Coefficients:
## (Intercept)            x  
##       1.567       -1.713
```

Q8. You know that both the predictor and response have mean 0. What can be said about the intercept when you fit a linear regression?

Answer: It must be identically 0.

Q9. Consider the data given by:

```r
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
```

What value minimizes the sum of the squared distances between these points and itself?

```r
# This basically asks for the the minimizer of the least squares, which is the mean.
mean(x)
```

```
## [1] 0.573
```

Q10. Let the slope having fit Y as the outcome and X as the predictor be denoted as $β_1$. Let the slope from fitting X as the outcome and Y as the predictor be denoted as $γ_1$. Suppose that you divide $β_1$ by $γ_1$; in other words consider $β_1$/$γ_1$. What is this ratio always equal to?

Answer: Var(Y)/Var(X)
