# Getting-and-Cleaning-Data

## Purpose
The purpose of the run_analysis.R script is to create a tidy data set from the
[Human Activity Recognition Using Smartphones Data Set](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), 
which contains the average of each variable for each activity and each subject.

Therefor the following steps are executed by the script:

1. Merges the training and the test sets to create one data set.
2. Extracts only the **measurements** on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject.

### Data Set Information
The data set contains multiple files with different data. More information about the data 
set can be found in the README.txt which is part of the data set.

#### measurements
In step two only the measurements on the mean and standard deviation should be extracted
from the data set. According to the features_info.txt, which contains a description of 
all features which are part of the data set, only the features which start with t and 
contain the string Acc or Gyro are measurements. All other feature are calculated (e.g.
by applying the Fast Fourier Transform (FFT)). 
* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tGravityAcc-mean()-X
* tGravityAcc-mean()-Y
* tGravityAcc-mean()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z


## Requirements
* The 
[Human Activity Recognition Using Smartphones Data Set](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
data must be in the current working directory beneath ./data (i.e. ./data/UCI HAR Dataset)
* The libraries reshape2 and plyr must be available in R  

   ```R
   library(reshape2);
   library(plyr);
   ```

## Execution
The R script has only to be sourced. All steps are executed automatically:
```R
source('./run_analysis.R')
```
The script creates a new text file **tidy_data_set.txt** in the current working directory, 
which contains the tidy data set with the average of each variables for each activity and each subject.
After the execution there is a new variable **tidy.data.set** in your R environment, which also contains the data set.

### At first the subjects are loaded into R ann are merged together
```R
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
# combines the training and the test subject
merged.subject <- rbind(train.subject, test.subject)
names(merged.subject) <- c("subject") # rename column for easier merge
```

### Merges the training and the test sets to create one data set.
```R
train.set <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
test.set <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

merged.set <- rbind(train.set, test.set) # combines the training and the test set
```