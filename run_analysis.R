setwd("~/Desktop/Coursera/Getting and Cleaning Data/Final Project/UCI HAR Dataset")

# INITIAL READING OF DATA

# Read features and activity lables into R 

names <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

# Read training data into R along with activity codes and subject codes

X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt") # code for type of activity
sub_train <- read.table("train/subject_train.txt") # subjects in this set

# Read test data into R along with activity codes and subject codes

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt") # code for type of activity 
sub_test <- read.table("test/subject_test.txt") # subjects in this set

# PART 1 - CREATE ONE DATA SET

# Combine test data files into one set with subject, type of activity, and data

test <- cbind(sub_test, y_test, X_test)
# name columns for subject, activity, and field names provided by features file.
names(test) <- c("subject", "activity", as.character(names[,2]))

# Combine training data files into one set with subject, type of activity, and data

train <- cbind(sub_train, y_train, X_train)
# name columns for subject, activity, and field names provided by features file.
names(train) <- c("subject", "activity", as.character(names[,2]))

# Combine both test and train data sets into a full set
  
fullSet <- rbind(test, train)

# change subjects from numeric to factor
fullSet[,1] <- as.factor(fullSet[,1])
  
# PART 2 - EXTRACT STD AND MEAN DATA
  
# Working with full data set, extract only those data fields containing means and standard deviations

  # Use grep to find mean and std fields, whether lower case or capitalized
  # This method is not conservative and is finding all remaining mean and std related fields
  meanStd <- grep("[Ss]td|[Mm]ean", names[,2])
  
  # Using column indexes provided by grep, filter fullSet for these fields
  # Also keep columns 1 and 2, which show subject and activity
  fullSetFilter <- fullSet[ ,c(1,2,(meanStd+2))] 

# PART 3 - USE DESCRIPTIVE ACTIVITY NAMES

  # change activity from numeric to factor and assign levels based on activity names
  fullSetFilter[,2] <- as.factor(fullSetFilter[,2])
  levels(fullSetFilter[,2]) <- activities[,2]
  
# PART 4 - LABEL DATA WITH DESCRIPTIVE NAMES
  
  # Labels have already been applied to fields
  # To clarify labels, will remove '()' from each field using gsub
  
  names(fullSetFilter) <- gsub("\\()", "", names(fullSetFilter))
  
# PART 5 - CREATE AVERAGES BY SUBJECT AND ACTIVITY
  
  # Use dplyr to group data by subject and activity
  
  library(dplyr)
  
  bySubject <- group_by(fullSetFilter, activity, subject)
  
  # Use "summarise_each" in dplyr to calculate a mean for each field in each grouping
  
  results <- summarise_each(bySubject,
                            funs(mean)
  )
  
  

  