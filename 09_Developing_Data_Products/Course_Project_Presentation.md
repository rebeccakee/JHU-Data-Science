
Developing Data Products Course Project
========================================================
author: Rebecca Kee
date: 9/4/2019

Introduction
========================================================
- This presentation introduces an app which predicts the price of a diamond based on its characteristics.
- The app and this presentation fulfil the course project for the Developing Data Products course on Coursera, which is part of the Data Science Specialization. 

About the app
========================================================
- The [Diamond Price Predictor](https://rebecca-kee.shinyapps.io/Developing_Data_Products_Course_Project/) app predicts the price of a diamond based on the cut, color, clarity, and carat selected by the user. 
- Predictions are made with the diamonds dataset in the ggplot2 package, using a general linear model. 

Using the app
========================================================
- Customize your diamond by selecting the cut, color, clarity, and carat. 
- The general linear model predicts the price of the diamond based on selected inputs, and displays it at the bottom of the main panel. 

```r
predict(model.fit, newdata = data.frame(carat = input$carat))
```
- The app also plots a regression of the diamonds data subset, and displays the user's customized diamond in red on the plot. 

Try it out!
========================================================
- Use the app [here](https://rebecca-kee.shinyapps.io/Developing_Data_Products_Course_Project/).
- View the underlying code for the app [here](https://github.com/rebeccakee/datasciencecoursera/tree/master/09_Developing_Data_Products/Course_Project). 
