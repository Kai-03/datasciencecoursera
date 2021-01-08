# Code Book
## 1. INTRODUCTION
This code book describes the functions, variables, data and the pipeline used in this project.
Analysis was performed on Training and Test sets.

## 2. DATASET
The Dataset was sourced from the *Human Activity Recognition Using Smartphones Dataset Version 1.0* available at:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

File list:
-  'features_info.txt': Shows information about the variables used on the feature vector.
-  'features.txt': List of all features (561).
-  'activity_labels.txt': Links the class labels with their activity name (6).
-  'train/X_train.txt': Training data set.
-  'train/y_train.txt': Training data labels.
-  'test/X_test.txt': Test data set.
-  'test/y_test.txt': Test data labels.
-  'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## 3. FEATURE SELECTION
To learn more about the feature selection, please refer to the README, features.txt and features_info.txt included in the original dataset.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

## 4. FEATURE VARIABLES

### 4.1 Time signals

-  tBodyAcc-XYZ
-  tGravityAcc-XYZ
-  tBodyAccJerk-XYZ
-  tBodyGyro-XYZ
-  tBodyGyroJerk-XYZ
-  tBodyAccMag
-  tGravityAccMag
-  tBodyAccJerkMag
-  tBodyGyroMag
-  tBodyGyroJerkMag

### 4.2 Frequency domain signals

-  fBodyAcc-XYZ
-  fBodyAccJerk-XYZ
-  fBodyGyro-XYZ
-  fBodyAccMag
-  fBodyAccJerkMag
-  fBodyGyroMag
-  fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

-  mean: Mean value
-  std: Standard deviation

The resulting variable names uses the following format: tbodyacc-xyz-mean which corresponds to the mean of tBodyAcc-XYZ.
The complete list of variables of each feature vector is available in 'features.txt'

## 5. FUNCTIONS
**merge()**
  
  Read and merges training and test sets into one data set. Assign feature labels to each column. Returns a data frame.
  
**meansd(data)**
   
   Extracts only the measurements on the mean and standard deviation for each measurement. 
   Takes a data frame as an argument and extracts columns with 'mean' and 'sd' labels. Includes subjectID and activityLabels to the data set. Returns a data frame.
  
**setdesc(data)**
  
  Uses descriptive activity names to name the activities in the data set. Appropriately labels the data set with descriptive variable names.
  Takes a data frame as an argument, adds column containing assigned activity names based on activityLabels, removes activityLabels column, converts column names to lowercase and removes '()' substring. 

**setmean(data)**
  
  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  Takes a data frame as an argument, groups data by two (2) columns: subjectid & activity, obtains the mean value of each variable. Returns a data frame.

**main()**
  
  Starts the Main Process with the following functions: merge(), meansd(), setdesc(), setmean() then writes the output to "cleandata.txt" and "cleandata_mean.txt". Returns the dataframe from setmean().
  
## 6. ANALYSIS PIPELINE
### Main Process: main()
  1. **merge()** Merge the training and the test sets to create one data set.
  2. **meansd(data)** Extract only the measurements on the mean and standard deviation for each measurement. 
  3. **setdesc(data)** Use descriptive activity names to name the activities in the data set and labels the data set with descriptive variable names. 
  5. **setmean(data)** Creates a second, independent tidy data set with the average of each variable for each activity and each subject using *dplyr* package.
  6. Export data to "cleandata.txt" and "cleandata_mean.txt"

## 7. REFERENCES
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
