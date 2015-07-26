# Getting-and-Cleaning-Data

## Purpose
The purpose of the run_analysis.R script is to create a tidy data set from the
[Human Activity Recognition Using Smartphones Data Set](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), 
which contains the average of each variable for each activity and each subject.

Therefor the following steps are executed by the script:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

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