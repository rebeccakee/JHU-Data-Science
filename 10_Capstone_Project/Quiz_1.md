---
author: "Rebecca Kee"
date: "10/14/2019"
output: 
    html_document:
        keep_md: true
---



# Capstone Project: Quiz 1

## Data processing

```r
# Load packages
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
# Download and unzip file if it does not exist
zipURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
zipfile <- "SwiftKey_data.zip"

if (!file.exists(zipfile)) {
  download.file(zipURL, zipfile, method = "curl")
}

folder.name <- "final"
if (!file.exists(folder.name)) {
  unzip(zipfile)
}

twitter.filepath <- paste(folder.name, "en_US/en_US.twitter.txt", sep = "/")
blogs.filepath <- paste(folder.name, "en_US/en_US.blogs.txt", sep = "/")
news.filepath <- paste(folder.name, "en_US/en_US.news.txt", sep = "/")
```

## Questions
1. The `en_US.blogs.txt` file is how many megabytes?

```r
file.info(blogs.filepath)
```

```
##                                  size isdir mode               mtime
## final/en_US/en_US.blogs.txt 210160014 FALSE  644 2019-10-14 21:46:52
##                                           ctime               atime uid
## final/en_US/en_US.blogs.txt 2019-10-14 21:57:32 2019-10-15 21:50:15 501
##                             gid      uname grname
## final/en_US/en_US.blogs.txt  20 RebeccaKee  staff
```
Answer: 200 mb

2. The `en_US.twitter.txt` has how many lines of text?

```r
length(readLines(twitter.filepath, warn = FALSE))
```

```
## [1] 2360148
```
Answer: Over 2 millon

3. What is the length of the longest line seen in any of the three en_US data sets?

```r
max(nchar(readLines(twitter.filepath, warn = FALSE)))
```

```
## [1] 140
```

```r
max(nchar(readLines(blogs.filepath, warn = FALSE)))
```

```
## [1] 40833
```

```r
max(nchar(readLines(news.filepath, warn = FALSE)))
```

```
## [1] 11384
```
Answer: Over 40 thousand in the blogs data set.

4. In the en_US twitter data set, if you divide the number of lines where the word "love" (all lowercase) occurs by the number of lines the word "hate" (all lowercase) occurs, about what do you get?

```r
n.love <- grepl(".love.", readLines(twitter.filepath, warn = FALSE))
n.hate <- grepl(".hate.", readLines(twitter.filepath, warn = FALSE))
sum(n.love) / sum(n.hate)
```

```
## [1] 3.964942
```
Answer: 4

5. The one tweet in the en_US twitter data set that matches the word "biostats" says what?

```r
twitter.file <- readLines(twitter.filepath, warn = FALSE)
twitter.file[grepl(".biostats.", twitter.file) == TRUE]
```

```
## [1] "i know how you feel.. i have biostats on tuesday and i have yet to study =/"
```
Answer: They haven't studied for their biostats exam. 

6. How many tweets have the exact characters "A computer once beat me at chess, but it was no match for me at kickboxing". (I.e. the line matches those characters exactly.)

```r
sum(grepl("A computer once beat me at chess, but it was no match for me at kickboxing", twitter.file))
```

```
## [1] 3
```

