# Code Book
The experiments have been carried out with a group of 30 volunteers within an age bracket 
of 19-48 years. Each person performed six activities 
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and 
gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a 
constant rate of 50Hz.

## Input data
The script asumes that the 
[Human Activity Recognition Using Smartphones Data Set](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
data is in the current working directory beneath ./data (i.e. ./data/UCI HAR Dataset).

Only the following features from the original data set are considered, as only these 
features are the mean and standard deviation of measurements :


tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, tBodyAcc-std()-X, 
tBodyAcc-std()-Y, tBodyAcc-std()-Z, tGravityAcc-mean()-X, tGravityAcc-mean()-Y, 
tGravityAcc-mean()-Z, tGravityAcc-std()-X, tGravityAcc-std()-Y, tGravityAcc-std()-Z, 
tBodyGyro-mean()-X, tBodyGyro-mean()-Y, tBodyGyro-mean()-Z, tBodyGyro-std()-X, 
tBodyGyro-std()-Y and tBodyGyro-std()-Z

## Output data
The output is a the tidy data set which was created by the five task:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject.

The tidy data set consists of seven columns (activity, subject, acc.sig, sensor, measurement, axis
and average) which are described next:

* activity

   This is the activity which was performed by the persons. There are also six activities
   (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) like in the
   original data set.

* subject

	*subject* identifies a single volunteer. There were 30 persons in the group of 
	volunteers. The *subject* column contain a number between 1 and 30.

* acc.sig

	According to the README.txt of the original data set, the acceleration signal was 
	separated into body and gravity acceleration signals. In order to identify the 
	acceleration signal the column *acc.sig* can contain the value *Body* for the body 
	acceleration signals or *Gravity* for the gravity acceleration signals.

* sensor

   The used smartphone has an embedded accelerometer and gyroscope. The column *sensor* 
   denote which senson was responsible for the measurement. Acc stands for accelerometer 
   while Gyro stands for gyroscope.

* measurement

	The column *measurement* contains the measurement which was uses to calculate the 
	average for each activity and each subject. As the task was to use only the mean and
	standard deviation for the calculation, there are only two values *mean()* for the 
	mean or *std()* for the standard deviation.

* axis

   The signals were used to estimate variables of the feature vector. The values *X*, *Y* 
   and *Z* are used to denote 3-axial signals in the X, Y and Z directions.

* average

   The column *average* contains the average of each variable for each activity and each 
   subject. These are the average of the mean or standard deviation of a time domain 
   signals from the smartphone sensors which were captured at a constant rate of 50 Hz.