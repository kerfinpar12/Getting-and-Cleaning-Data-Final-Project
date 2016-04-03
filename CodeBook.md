---
title: "Final Project Code Book"
author: "Parker Finn"
date: "April 3, 2016"
output:
  html_document:
    keep_md: yes
---

## PROJECT DESCRIPTION
This project shows how I collected, worked with and cleaned data from accelerometers of a Samsung smart phone. The data includes readings from 30 individuals performing six different types of activities.

### DESIGN AND DATA PROCESSING
The main data for the 30 subjects were split into a test and training set. Additional data files were provided for types of activities (the six activities) and an extenstive list of features, or variables that were measured or calculated. These files were cleaned, combined and organzied to meet the requirements of the final set (steps described below).

### NOTES ON THE ORIGINAL DATA
The data comes from the Human Activity Recognition Using Smartphones Data Set at UCI.

I used most of the data files provided and made some assumptions to eliminate files.

--Activity labels - used
--features - used
--test files: subject_test, X_test, and y_test used
--train files: subject_test, X_test, and y_test used

Based on instructions, it did not appear that "Inertial Signals" files needed to be included. These were not used.

## CREATING THE TIDY DATA FILE

I created the file with the following steps, which can be observed in more detail in the "run_analysis.R" file.

### INITIAL READING OF DATA

Read features and activity lables into R 

Read training data into R along with activity codes and subject codes

Read test data into R along with activity codes and subject codes

### PART 1 - CREATE ONE DATA SET

For the test data, the "X_test" file (containing the acceleromter data) was combined with the subject file (indicating which participant) and the "y_test" file, indicating the activity.

This was repeated with the train files.

For each data set,the columns were named "subject", "activity", and the field names provided by the features file.

With both the train and test files organized and having the same column names, they were combined into one file by simply using the rbind function.

To further organized teh data, the subject field was changed to a factor.

The resulting data set is called "fullSet" in my R code.

### PART 2 - EXTRACT STD AND MEAN DATA
  
Working with full data set, extract only those data fields containing means and standard deviations

Creating a vector "meanStd", I used grep to identify remaining fields with mean or std in the field name.

meanStd <- grep("[Ss]td|[Mm]ean", names[,2])

I then apply the resulting indexed fields to the dataset to filter only the desired fields. I also keep fields 1 and 2, which represent the subject and activity.

  fullSetFilter <- fullSet[ ,c(1,2,(meanStd+2))]  

The resulting data is called "fullSetFilter". It contains 10299 observations and 88 variables.

### PART 3 - USE DESCRIPTIVE ACTIVITY NAMES

To meet the requirement of descriptive activity names, I changed activities from numeric to factor, then applied the "activities_labels" as the levels.

### PART 4 - LABEL DATA WITH DESCRIPTIVE NAMES
  
At this point, the provided feature names have already been applied as labels for the data.  
To simplify the names, I chose to remove "()' from the field names to make them more readable. I used gsub to clean the data names.

### PART 5 - CREATE AVERAGES BY SUBJECT AND ACTIVITY

Averages for each data field is calculated based on subject and activity. Given that there are 30 subjects and 6 activities, the resulting table contains 180 rows of data.

I used dplyr to group the data, "fullSetFilter", by activity and subject.

I then used dplyr's "summarise_each" function to find the mean of each column of data, by subject and by activity.  I saved this object as "results".

Viewing the "results" object will only provide a few lines. For ease of checking for proper categorization, I ran results as a data frame with all rows and the first five columns.
as.data.frame(results[1:180, 1:5])    

Manually checking my results, the averaging had worked out appropriately.

# FINAL DATA FILE

The final data file contains 180 rows (observations). There are 30 different subjects, each performing 6 different activities.  There are 88 variables. The first two columns are "subject" and "activity". The remaining are the data after filtering.  

The resulting fields are:
activity: factor with six levels - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING,STANDING, LAYING
subject: factor with 30 levels, 1-30

86 data fields, all numeric and normalized within a bound of -1 to 1.

Time series variables

Mean and SD of boody acceleration variables along x, y and z

* tBodyAcc-mean-X 
* tBodyAcc-mean-Y
* tBodyAcc-mean-Z
* tBodyAcc-std-X
* tBodyAcc-std-Y
* tBodyAcc-std-Z

Mean and SD of gravity acceleration variables along x, y and z

* tGravityAcc-mean-X
* tGravityAcc-mean-Y
* tGravityAcc-mean-Z
* tGravityAcc-std-X
* tGravityAcc-std-Y
* tGravityAcc-std-Z

Mean and SD of acceleration jerk variables along x, y and z

* tBodyAccJerk-mean-X
* tBodyAccJerk-mean-Y
* tBodyAccJerk-mean-Z
* tBodyAccJerk-std-X
* tBodyAccJerk-std-Y
* tBodyAccJerk-std-Z

Mean and SD of boody gyro variables along x, y and z

* tBodyGyro-mean-X
* tBodyGyro-mean-Y
* tBodyGyro-mean-Z
* tBodyGyro-std-X
* tBodyGyro-std-Y
* tBodyGyro-std-Z

Mean and SD of boody gyro jerk variables along x, y and z

* tBodyGyroJerk-mean-X
* tBodyGyroJerk-mean-Y
* tBodyGyroJerk-mean-Z
* tBodyGyroJerk-std-X
* tBodyGyroJerk-std-Y
* tBodyGyroJerk-std-Z

* tBodyAccMag-mean
* tBodyAccMag-std
* tGravityAccMag-mean
* tGravityAccMag-std
* tBodyAccJerkMag-mean
* tBodyAccJerkMag-std
* tBodyGyroMag-mean
* tBodyGyroMag-std
* tBodyGyroJerkMag-mean
* tBodyGyroJerkMag-std

Fourier transform variables

Mean and SD of boody acceleration variables along x, y and z

* fBodyAcc-mean-X
* fBodyAcc-mean-Y
* fBodyAcc-mean-Z
* fBodyAcc-std-X
* fBodyAcc-std-Y
* fBodyAcc-std-Z
* fBodyAcc-meanFreq-X
* fBodyAcc-meanFreq-Y
* fBodyAcc-meanFreq-Z

Mean and SD of boody acceleration jerk variables along x, y and z

* fBodyAccJerk-mean-X
* fBodyAccJerk-mean-Y
* fBodyAccJerk-mean-Z
* fBodyAccJerk-std-X
* fBodyAccJerk-std-Y
* fBodyAccJerk-std-Z
* fBodyAccJerk-meanFreq-X
* fBodyAccJerk-meanFreq-Y
* fBodyAccJerk-meanFreq-Z

Mean and SD of boody gyro variables along x, y and z

* fBodyGyro-mean-X
* fBodyGyro-mean-Y
* fBodyGyro-mean-Z
* fBodyGyro-std-X
* fBodyGyro-std-Y
* fBodyGyro-std-Z
* fBodyGyro-meanFreq-X
* fBodyGyro-meanFreq-Y
* fBodyGyro-meanFreq-Z

Mean and SD of boody acceleration Mag variables along x, y and z

* fBodyAccMag-mean
* fBodyAccMag-std
* fBodyAccMag-meanFreq
* fBodyBodyAccJerkMag-mean
* fBodyBodyAccJerkMag-std
* fBodyBodyAccJerkMag-meanFreq
* fBodyBodyGyroMag-mean
* fBodyBodyGyroMag-std
* fBodyBodyGyroMag-meanFreq
* fBodyBodyGyroJerkMag-mean
* fBodyBodyGyroJerkMag-std
* fBodyBodyGyroJerkMag-meanFreq

Angle variables

* angle(tBodyAccMean,gravity)
* angle(tBodyAccJerkMean),gravityMean)
* angle(tBodyGyroMean,gravityMean)
* angle(tBodyGyroJerkMean,gravityMean)
* angle(X,gravityMean)
* angle(Y,gravityMean)
* angle(Z,gravityMean)
