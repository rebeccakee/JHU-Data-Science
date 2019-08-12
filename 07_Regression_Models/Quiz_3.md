---
author: "Rebecca Kee"
date: "8/10/2019"
output: 
    html_document: 
        keep_md: true
---



# Regression Models Quiz 3 

Q1. Consider the mtcars data set. Fit a model with mpg as the outcome that includes number of cylinders as a factor variable and weight as confounder. Give the adjusted estimate for the expected change in mpg comparing 8 cylinders to 4.

```r
data(mtcars)
fit <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
summary(fit)$coefficients
```

```
##               Estimate Std. Error   t value     Pr(>|t|)
## (Intercept)  33.990794  1.8877934 18.005569 6.257246e-17
## factor(cyl)6 -4.255582  1.3860728 -3.070244 4.717834e-03
## factor(cyl)8 -6.070860  1.6522878 -3.674214 9.991893e-04
## wt           -3.205613  0.7538957 -4.252065 2.130435e-04
```
The adjusted estimate is -6.071. 


Q2. Consider the mtcars data set. Fit a model with mpg as the outcome that includes number of cylinders as a factor variable and weight as a possible confounding variable. Compare the effect of 8 versus 4 cylinders on mpg for the adjusted and unadjusted by weight models. Here, adjusted means including the weight variable as a term in the regression model and unadjusted means the model without weight included. What can be said about the effect comparing 8 and 4 cylinders after looking at models with and without weight included?

```r
# Fit model without adjusting for weight and obtain coefficient comparing 8 and 4 cylinders
fit2 <- lm(mpg ~ factor(cyl), data = mtcars)
summary(fit2)$coefficient[3]
```

```
## [1] -11.56364
```

```r
# Retrieve coefficient comparing 8 an 4 cylinders from the first adjusted model
summary(fit)$coefficient[3]
```

```
## [1] -6.07086
```
Answer: Holding weight constant, cylinder appears to have less of an impact on mpg than if weight is disregarded.

Q3. Consider the mtcars data set. Fit a model with mpg as the outcome that considers number of cylinders as a factor variable and weight as confounder. Now fit a second model with mpg as the outcome model that considers the interaction between number of cylinders (as a factor variable) and weight. Give the P-value for the likelihood ratio test comparing the two models and suggest a model using 0.05 as a type I error rate significance benchmark.

```r
# Fit adjusted model, no interation 
fit <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
summary(fit)
```

```
## 
## Call:
## lm(formula = mpg ~ factor(cyl) + wt, data = mtcars)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -4.5890 -1.2357 -0.5159  1.3845  5.7915 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   33.9908     1.8878  18.006  < 2e-16 ***
## factor(cyl)6  -4.2556     1.3861  -3.070 0.004718 ** 
## factor(cyl)8  -6.0709     1.6523  -3.674 0.000999 ***
## wt            -3.2056     0.7539  -4.252 0.000213 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.557 on 28 degrees of freedom
## Multiple R-squared:  0.8374,	Adjusted R-squared:   0.82 
## F-statistic: 48.08 on 3 and 28 DF,  p-value: 3.594e-11
```

```r
# Fit adjusted model, with interation 
fit3 <- lm(mpg ~ factor(cyl) * wt, data = mtcars)
summary(fit3)
```

```
## 
## Call:
## lm(formula = mpg ~ factor(cyl) * wt, data = mtcars)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -4.1513 -1.3798 -0.6389  1.4938  5.2523 
## 
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)    
## (Intercept)       39.571      3.194  12.389 2.06e-12 ***
## factor(cyl)6     -11.162      9.355  -1.193 0.243584    
## factor(cyl)8     -15.703      4.839  -3.245 0.003223 ** 
## wt                -5.647      1.359  -4.154 0.000313 ***
## factor(cyl)6:wt    2.867      3.117   0.920 0.366199    
## factor(cyl)8:wt    3.455      1.627   2.123 0.043440 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.449 on 26 degrees of freedom
## Multiple R-squared:  0.8616,	Adjusted R-squared:  0.8349 
## F-statistic: 32.36 on 5 and 26 DF,  p-value: 2.258e-10
```

```r
# Compare both models
anova(fit, fit3)
```

```
## Analysis of Variance Table
## 
## Model 1: mpg ~ factor(cyl) + wt
## Model 2: mpg ~ factor(cyl) * wt
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1     28 183.06                           
## 2     26 155.89  2     27.17 2.2658 0.1239
```
Answer: The P-value is larger than 0.05. So, according to our criterion, we would fail to reject, which suggests that the interaction terms may not be necessary.

Q4.Consider the mtcars data set. Fit a model with mpg as the outcome that includes number of cylinders as a factor variable and weight inlcuded in the model as 

```r
fit4 <- lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
summary(fit4)
```

```
## 
## Call:
## lm(formula = mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -4.5890 -1.2357 -0.5159  1.3845  5.7915 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)    33.991      1.888  18.006  < 2e-16 ***
## I(wt * 0.5)    -6.411      1.508  -4.252 0.000213 ***
## factor(cyl)6   -4.256      1.386  -3.070 0.004718 ** 
## factor(cyl)8   -6.071      1.652  -3.674 0.000999 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.557 on 28 degrees of freedom
## Multiple R-squared:  0.8374,	Adjusted R-squared:   0.82 
## F-statistic: 48.08 on 3 and 28 DF,  p-value: 3.594e-11
```
How is the wt coefficient interpreted?

Answer: The estimated expected change in MPG per one ton increase in weight for a specific number of cylinders (4, 6, 8).

Q5. Consider the following data set

```r
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
```

Give the hat diagonal for the most influential point

```r
fit5 <- lm(y ~ x)
hatvalues(fit5)
```

```
##         1         2         3         4         5 
## 0.2286650 0.2438146 0.2525027 0.2804443 0.9945734
```
The hat value for the most influential point is 0.9946. 

Q6. Consider the following data set

```r
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

# Note: This is the exact same data set used in Q5.
```

Give the slope dfbeta for the point with the highest hat value.

```r
dfbetas(fit5)
```

```
##   (Intercept)             x
## 1  1.06212391   -0.37811633
## 2  0.06748037   -0.02861769
## 3 -0.01735756    0.00791512
## 4 -1.24958248    0.67253246
## 5  0.20432010 -133.82261293
```
The dfbeta for the point with highest hat value is -134.

Q7. Consider a regression relationship between Y and X with and without adjustment for a third variable Z. Which of the following is true about comparing the regression coefficient between Y and X with and without adjustment for Z.

Answer: It is possible for the coefficient to reverse sign after adjustment. For example, it can be strongly significant and positive before adjustment and strongly significant and negative after adjustment.
