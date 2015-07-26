# Getting-and-Cleaning-Data

## Purpose
The purpose of the run_analysis.R script is to create a tidy data set from the
[Human Activity Recognition Using Smartphones Data Set](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
data set, which contains the average of each variable for each activity and each subject.
Therefor

Therefor the 

## Requirements
* The 
[Human Activity Recognition Using Smartphones Data Set](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
data must be in the current working directory beneath ./data (i.e. ./data/UCI HAR Dataset)
* The libraries reshape2 and plyr must be available in R  
   library(reshape2)  
   library(plyr)

## Execution
The R script has only to be sourced. All steps are executed automatically:
```R
source('./run_analysis.R')
```
The script creates a new text file **tidy_data_set.txt** in the current working directory, 
which contains the tidy data set with the average of each variables for each activity and each subject.
After the execution there is a new variable **tidy.data.set** in your R environment, which also contains the data set.