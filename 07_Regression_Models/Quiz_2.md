---
author: "Rebecca Kee"
date: "8/6/2019"
output: 
    html_document: 
        keep_md: true
---



# Regression Models Quiz 2 

Q1. Consider the following data with x as the predictor and y as as the outcome.

```r
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
```

Give a P-value for the two sided hypothesis test of whether $β_1$ from a linear regression model is 0 or not.

```r
summary(lm(y ~ x,))
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.27636 -0.18807  0.01364  0.16595  0.27143 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)  
## (Intercept)   0.1885     0.2061   0.914    0.391  
## x             0.7224     0.3107   2.325    0.053 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.223 on 7 degrees of freedom
## Multiple R-squared:  0.4358,	Adjusted R-squared:  0.3552 
## F-statistic: 5.408 on 1 and 7 DF,  p-value: 0.05296
```
The P-value is 0.05296.

Q2. Consider the previous problem, give the estimate of the residual standard deviation.

```r
summary(lm(y ~ x,))
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.27636 -0.18807  0.01364  0.16595  0.27143 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)  
## (Intercept)   0.1885     0.2061   0.914    0.391  
## x             0.7224     0.3107   2.325    0.053 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.223 on 7 degrees of freedom
## Multiple R-squared:  0.4358,	Adjusted R-squared:  0.3552 
## F-statistic: 5.408 on 1 and 7 DF,  p-value: 0.05296
```
The residual standard deviation (i.e. residual standard error) is 0.223.

Q3. In the mtcars data set, fit a linear regression model of weight (predictor) on mpg (outcome). Get a 95% confidence interval for the expected mpg at the average weight. What is the lower endpoint?

```r
data("mtcars")
y <- mtcars$mpg
x <- mtcars$wt
fit <- lm(y ~ x)
predict(fit, newdata = data.frame(x = mean(x)), interval = ("confidence"))
```

```
##        fit      lwr      upr
## 1 20.09062 18.99098 21.19027
```

Q4. Refer to the previous question. Read the help file for mtcars. What is the weight coefficient interpreted as?

```r
help("mtcars")
```
Answer: Given that the weight is in per 1000 lbs, the weight coefficient can be interpreted as the estimated expected change in mpg per 1,000 lb increase in weight.

Q5. Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (1,000 lbs). A new car is coming weighing 3000 pounds. Construct a 95% prediction interval for its mpg. What is the upper endpoint?

```r
predict(fit, newdata = data.frame(x = 3), interval = ("prediction"))
```

```
##        fit      lwr      upr
## 1 21.25171 14.92987 27.57355
```
The upper bound is 27.57. 

Q6. Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (in 1,000 lbs). A “short” ton is defined as 2,000 lbs. Construct a 95% confidence interval for the expected change in mpg per 1 short ton increase in weight. Give the lower endpoint.

```r
# Since the unit for weight is doubled, we will divide the predictor (weight) by 2. 
fit2 <- lm(mtcars$mpg ~ I(mtcars$wt/2))
confint(fit2)
```

```
##                    2.5 %   97.5 %
## (Intercept)     33.45050 41.11975
## I(mtcars$wt/2) -12.97262 -8.40527
```
The lower endpoint is -12.973.

Q7. If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to the slope coefficient?

Answer: It would get multiplied by 100.

Q8. I have an outcome, $Y$, and a predictor, $X$ and fit a linear regression model with $Y=β_0+β_1X+ϵ$ to obtain $β^0$ and $β^1$. What would be the consequence to the subsequent slope and intercept if I were to refit the model with a new regressor, $X + cX+c$ for some constant, $c$?

Answer: The new intercept would be $β^0−cβ^1$

Q9. Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor. About what is the ratio of the the sum of the squared errors, $∑^n_{i=1}(Yi−Ŷ i)^2$ when comparing a model with just an intercept (denominator) to the model with the intercept and slope (numerator)?

```r
fit3 <- lm(mtcars$mpg ~ mtcars$wt)
fit4 <- lm(mtcars$mpg ~ 1)

num <- sum((predict(fit3) - mtcars$mpg)^2)
den <- sum((predict(fit4) - mtcars$mpg)^2)
num/den
```

```
## [1] 0.2471672
```


Q10. Do the residuals always have to sum to 0 in linear regression?

Answer: If an intercept is included, then they will sum to 0.
