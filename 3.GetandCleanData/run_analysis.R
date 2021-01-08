## ========================================================================== ##
## Script: run_analysis.R
## Version: 1.00
## Author: Kai-03
## Date: 2021-1-07
## Description: 
##  The script does the following:
" 1. Merge the training and the test sets to create one data set.
  2. Extract only the measurements on the mean and standard deviation for each measurement. 
  3. Use descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with
    the average of each variable for each activity and each subject."        
## -------------------------------------------------------------------------- ##

# ---------------------------------------------------------------------------- #
## Function: merge()
##    Merges the training and the test sets to create one data set.
# ---------------------------------------------------------------------------- #
merge <- function() {
  
  # Read data: Label [int], Name [string]
  features <- read.table("./UCI HAR Dataset/features.txt", sep=" ", col.names = c("featureLabel","featureName"))
  
  # Read data: Test Subjects' IDs [int]
  #   Each row identifies the subject who performed the activity for each window 
  #   sample. Its range is from 1 to 30. 
  subjtest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subjectID"))
  
  # Read data: Test set (2947 samples with 561 values each row [int])
  xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
  
  # Read data: Test labels (2947 items with single values [int])
  ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
  
  # Assign column names
  colnames(xtest) <- features$featureName
  colnames(ytest) <- c('activityLabels')
  
  # Merge Test data
  test_dat <- cbind(subjtest, xtest, ytest)

  # Read data: Training Data
  subjtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subjectID"))
  xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
  ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
  
  # Assign column names
  colnames(xtrain) <- features$featureName
  colnames(ytrain) <- c('activityLabels')
  train_dat <- cbind(subjtrain, xtrain, ytrain)
  
  # Combine test and training data
  all_dat <- rbind(train_dat, test_dat)
  
  # Return All Data
  all_dat
}

# ---------------------------------------------------------------------------- #
## Function: meansd(data)
##    Extracts only the measurements on the mean and standard deviation for each
##  measurement.
# ---------------------------------------------------------------------------- #

meansd <- function(data) {
  # Extract Data Column Names with substrings: [subjectID, mean, std, activityLabels]
  meanSdData <- data[, grep(pattern = 'subjectid|mean\\(\\)|std\\(\\)|activitylabels', lapply(names(data), tolower))]
  meanSdData
}

# ---------------------------------------------------------------------------- #
## Function: setdesc(data)
##    Uses descriptive activity names to name the activities in the data set.
##    Appropriately labels the data set with descriptive variable names.
# ---------------------------------------------------------------------------- #

setdesc <- function(data) {
  # Read data: Activity Labels & Add Factors to Subject ID
  actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ", col.names=c("activityLabel","activityName"))
  data$subjectID <- as.factor(data$subjectID)
  
  # Add activity (description) column to data set and remove activityLabels 
  data$activity <- factor(data$activityLabels, levels = actlabels$activityLabel, labels = actlabels$activityName)
  
  # Remove column "activitylabel"
  data <- data[,-grep("activityLabel", names(data))]
  # Remove '()' from column names
  colnames(data) <- tolower(gsub("\\(\\)","",names(data)))
  
  data
}

# ---------------------------------------------------------------------------- #
## Function: setmean(data)
##    Creates a second, independent tidy data set with the average of each 
##  variable for Each Activity and Each Subject.
# ---------------------------------------------------------------------------- #
setmean <- function(data) {
  # Group by subjectid & activity using dplyr package
  require(dplyr)
  gr <- group_by(data, subjectid, activity)
  meandata <- summarise_all(gr, funs(mean))
  
  # Return mean data set
  meandata <- as.data.frame(meandata)
  meandata
}

# ---------------------------------------------------------------------------- #
## Function: main()
##    Start the main process.
# ---------------------------------------------------------------------------- #
main <- function() {
  # Start Process
  data <- merge()
  data <- meansd(data)
  cleandata <- setdesc(data)
  meandata <- setmean(cleandata)
  
  # Write Data
  write.table(cleandata, file = "cleandata.txt", row.names = F)
  write.table(meandata, file = "cleandata_mean.txt", row.names = F)
  meandata
}
