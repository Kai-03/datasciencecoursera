# Course Project: Getting and Cleaning Data
## 1. INTRODUCTION
The goal of this project is to prepare tidy data that can be used for later analysis. 
I have included a Code Book, **CodeBook.md** which further describes the functions, variables, the data, and transformations performed to clean up the data.

## 2. SCRIPT
The R script **run_analysis.R** contains a series of functions that does the following:
  1. Merge the training and the test sets to create one data set.
  2. Extract only the measurements on the mean and standard deviation for each measurement. 
  3. Use descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  6. Writes two (2) files:
    - 'cleandata.txt': contains the tidy data set in Step 4.
    - 'cleandata_mean.txt': contains independent tidy data set with the average values in Step 5.

## 3. HOW TO USE
1. The *UCI HAR Dataset* should be in the current working directory.
2. Source the R script *run_analysis.R* then run the command **main()** in the console.

## 4. RAW DATA
The Data set used for this project can be obtained from:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
