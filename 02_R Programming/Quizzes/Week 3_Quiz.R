#Question 1. Take a look at the 'iris' dataset that comes with R.
#There will be an object called 'iris' in your workspace. 
#In this dataset, what is the mean of 'Sepal.Length' for the species virginica? 
#Please round your answer to the nearest whole number.

library(datasets)
data("iris")
species <- split(iris, iris$Species)
mean <- lapply(species, function(x) colMeans(x[, c("Sepal.Length", "Sepal.Width")]))
mean

#Question 2. Continuing with the 'iris' dataset from the previous Question, 
#what R code returns a vector of the means of the variables 
#'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?

apply(iris[ ,1:4],2,mean)

#Question 3. Load the 'mtcars' dataset in R. 
#There will be an object names 'mtcars' in your workspace.
#How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)? 

library(datasets)
data("mtcars")
sapply(split(mtcars$mpg, mtcars$cyl), mean)
tapply(mtcars$mpg, mtcars$cyl, mean)
with(mtcars, tapply(mpg, cyl, mean))

#Question 4. Continuing with the 'mtcars' dataset from the previous Question, 
#what is the absolute difference between the average horsepower of 
#4-cylinder cars and the average horsepower of 8-cylinder cars?
  
mean <- tapply(mtcars$hp, mtcars$cyl, mean)
difference <- abs(mean[[1]] - mean[[3]])
difference
