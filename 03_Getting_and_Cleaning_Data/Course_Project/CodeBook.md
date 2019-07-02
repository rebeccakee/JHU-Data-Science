CodeBook for *Getting and Cleaning Data Course Project*
-------------------------------------------------------

This codebook describes in detail the dataset used in this project, its
variables, as well as the transformations applied to produce a tidy
dataset, titled `tidy_data.csv` located in the same directory.

### Background information on the original dataset

The raw dataset used in this project was obtained from the [Human
Activity Recognition Using Smartphones Data
Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones),
which contains data collected from the accelerometers from the Samsung
Galaxy S smartphone. Specifically, the data is described as follows:

> The experiments have been carried out with a group of 30 volunteers
> within an age bracket of 19-48 years. Each person performed six
> activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING,
> STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
> waist. Using its embedded accelerometer and gyroscope, we captured
> 3-axial linear acceleration and 3-axial angular velocity at a constant
> rate of 50Hz. The experiments have been video-recorded to label the
> data manually. The obtained dataset has been randomly partitioned into
> two sets, where 70% of the volunteers was selected for generating the
> training data and 30% the test data.

> The sensor signals (accelerometer and gyroscope) were pre-processed by
> applying noise filters and then sampled in fixed-width sliding windows
> of 2.56 sec and 50% overlap (128 readings/window). The sensor
> acceleration signal, which has gravitational and body motion
> components, was separated using a Butterworth low-pass filter into
> body acceleration and gravity. The gravitational force is assumed to
> have only low frequency components, therefore a filter with 0.3 Hz
> cutoff frequency was used. From each window, a vector of features was
> obtained by calculating variables from the time and frequency domain.

### Tidy data

The original dataset was cleaned to produce a tidy dataset,
`tidy_data.csv`.  
It contains a header row with variable names, while the following rows
contain the values of these variables. Each row contains the mean of 79
signal measurements, for each subject and activity. Variables are
described in detail below.

### Variables

-   `subject` – an integer from 1 to 30 that identifies the subject  
-   `activity` – a factor with 6 levels:
    -   `WALKING` – indicates subject was walking  
    -   `WALKING_UPSTAIRS` – indicates subject was walking upstairs  
    -   `WALKING_DOWNSTAIRS` – indicates subject was walking
        downstairs  
    -   `SITTING` – indicates subject was sitting  
    -   `STANDING` – indicates subject was standing  
    -   `LAYING` – indicates subject was laying

#### Time domain variables

Time domain signals come from the accelerometer and gyroscope, captured
at constant rate of 50 Hz. All time domain variables are of numeric
class.

##### Mean and standard deviation of body acceleration in X, Y and Z dimensions

-   `timeBodyAccelerometerMeanX`  
-   `timeBodyAccelerometerMeanY`  
-   `timeBodyAccelerometerMeanZ`  
-   `timeBodyAccelerometerStandardDeviationX`  
-   `timeBodyAccelerometerStandardDeviationY`  
-   `timeBodyAccelerometerStandardDeviationZ`

##### Mean and standard deviation of gravity acceleration in X, Y and Z dimensions

-   `timeGravityAccelerometerMeanX`
-   `timeGravityAccelerometerMeanY`
-   `timeGravityAccelerometerMeanZ`
-   `timeGravityAccelerometerStandardDeviationX`
-   `timeGravityAccelerometerStandardDeviationY`
-   `timeGravityAccelerometerStandardDeviationZ`

##### Mean and standard deviation of body acceleration jerk in X, Y and Z dimensions

Jerk signals were a derivation of the acceleration in time

-   `timeBodyAccelerometerJerkMeanX`
-   `timeBodyAccelerometerJerkMeanY`
-   `timeBodyAccelerometerJerkMeanZ`
-   `timeBodyAccelerometerJerkStandardDeviationX`
-   `timeBodyAccelerometerJerkStandardDeviationY`
-   `timeBodyAccelerometerJerkStandardDeviationZ`

##### Mean and standard deviation of body angular velocity in X, Y and Z dimensions

-   `timeBodyGyroscopeMeanX`
-   `timeBodyGyroscopeMeanY`
-   `timeBodyGyroscopeMeanZ`
-   `timeBodyGyroscopeStandardDeviationX`
-   `timeBodyGyroscopeStandardDeviationY`
-   `timeBodyGyroscopeStandardDeviationZ`

##### Mean and standard deviation of body angular velocity jerk in X, Y and Z dimensions

Jerk signals were a derivation of the angular velocity in time

-   `timeBodyGyroscopeJerkMeanX`  
-   `timeBodyGyroscopeJerkMeanY`  
-   `timeBodyGyroscopeJerkMeanZ`  
-   `timeBodyGyroscopeJerkStandardDeviationX`  
-   `timeBodyGyroscopeJerkStandardDeviationY`  
-   `timeBodyGyroscopeJerkStandardDeviationZ`

##### Mean and standard deviation of body acceleration magnitude

The magnitude was calculated using the Euclidean norm

-   `timeBodyAccelerometerMagnitudeMean`  
-   `timeBodyAccelerometerMagnitudeStandardDeviation`

##### Mean and standard deviation of gravity acceleration magnitude

The magnitude was calculated using the Euclidean norm

-   `timeGravityAccelerometerMagnitudeMean`  
-   `timeGravityAccelerometerMagnitudeStandardDeviation`

##### Mean and standard deviation of body acceleration jerk magnitude

The magnitude was calculated using the Euclidean norm

-   `timeBodyAccelerometerJerkMagnitudeMean`  
-   `timeBodyAccelerometerJerkMagnitudeStandardDeviation`

##### Mean and standard deviation of body angular velocity magnitude

The magnitude was calculated using the Euclidean norm

-   `timeBodyGyroscopeMagnitudeMean`  
-   `timeBodyGyroscopeMagnitudeStandardDeviation`

##### Mean and standard deviation of body angular velocity jerk magnitude

The magnitude was calculated using the Euclidean norm

-   `timeBodyGyroscopeJerkMagnitudeMean`  
-   `timeBodyGyroscopeJerkMagnitudeStandardDeviation`

#### Frequency domain variables

Frequency domain signals were calculated by applying a Fast Fourier
Transform to the time domain signals. All frequency domain variables are
of numeric class.

##### Mean and stndard deviation of body acceleration in X, Y and Z dimensions

-   `frequencyBodyAccelerometerMeanX`  
-   `frequencyBodyAccelerometerMeanY`  
-   `frequencyBodyAccelerometerMeanZ`  
-   `frequencyBodyAccelerometerStandardDeviationX`  
-   `frequencyBodyAccelerometerStandardDeviationY`  
-   `frequencyBodyAccelerometerStandardDeviationZ`

##### Weighted average of the frequency of body acceleration in X, Y and Z dimensions

-   `frequencyBodyAccelerometerMeanFrequencyX`  
-   `frequencyBodyAccelerometerMeanFrequencyY`  
-   `frequencyBodyAccelerometerMeanFrequencyZ`

##### Mean and standard deviation of body acceleration jerk in X, Y and Z dimensions

-   `frequencyBodyAccelerometerJerkMeanX`  
-   `frequencyBodyAccelerometerJerkMeanY`  
-   `frequencyBodyAccelerometerJerkMeanZ`  
-   `frequencyBodyAccelerometerJerkStandardDeviationX`  
-   `frequencyBodyAccelerometerJerkStandardDeviationY`  
-   `frequencyBodyAccelerometerJerkStandardDeviationZ`

##### Weighted average of the frequency of body acceleration jerk in X, Y and Z dimensions

-   `frequencyBodyAccelerometerJerkMeanFrequencyX`  
-   `frequencyBodyAccelerometerJerkMeanFrequencyY`  
-   `frequencyBodyAccelerometerJerkMeanFrequencyZ`

##### Mean and standard deviation of body angular velocity in X, Y and Z dimensions

-   `frequencyBodyGyroscopeMeanX`  
-   `frequencyBodyGyroscopeMeanY`  
-   `frequencyBodyGyroscopeMeanZ`  
-   `frequencyBodyGyroscopeStandardDeviationX`
-   `frequencyBodyGyroscopeStandardDeviationY`  
-   `frequencyBodyGyroscopeStandardDeviationZ`

##### Weighted average of the frequency of body angular velocity in X, Y and Z dimensions

-   `frequencyBodyGyroscopeMeanFrequencyX`  
-   `frequencyBodyGyroscopeMeanFrequencyY`  
-   `frequencyBodyGyroscopeMeanFrequencyZ`

##### Mean, standard deviation, and weighted average of the frequency of body acceleration magnitude

-   `frequencyBodyAccelerometerMagnitudeMean`  
-   `frequencyBodyAccelerometerMagnitudeStandardDeviation`  
-   `frequencyBodyAccelerometerMagnitudeMeanFrequency`

##### Mean, standard deviation, and weighted average of the frequency of body acceleration jerk magnitude

-   `frequencyBodyAccelerometerJerkMagnitudeMean`  
-   `frequencyBodyAccelerometerJerkMagnitudeStandardDeviation`  
-   `frequencyBodyAccelerometerJerkMagnitudeMeanFrequency`

##### Mean, standard deviation, and weighted average of the frequency of body angular velocity magnitude

-   `frequencyBodyGyroscopeMagnitudeMean`  
-   `frequencyBodyGyroscopeMagnitudeStandardDeviation`  
-   `frequencyBodyGyroscopeMagnitudeMeanFrequency`

##### Mean, standard deviation, and weighted average of the frequency of body angular velocity jerk magnitude

-   `frequencyBodyGyroscopeJerkMagnitudeMean`  
-   `frequencyBodyGyroscopeJerkMagnitudeStandardDeviation`  
-   `frequencyBodyGyroscopeJerkMagnitudeMeanFrequency`

### Transformations

`run_analysis.R` details the steps taken to clean the original dataset:
1. The [source
data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
is downloaded and unzipped if it does not exist.

1.  Data is read.

2.  Training and test sets are merged to create one dataset.

3.  Only the measurements containing mean and standard deviation are
    kept.

4.  Activity variables in the dataset are renamed descriptively.

5.  All other variable names are renamed so that special characters and
    typos are removed, and abbreviations are spelled out,

6.  The mean of each variable is calculated for each subject and
    activity, which is written to a new tidy dataset, called
    `tidy_data.csv`.

The tidy dataset was created using R version 3.6.0 (2019-04-26) on MacOS
Version 10.14.5. `dplyr` package (Version 0.8.1) is required.
