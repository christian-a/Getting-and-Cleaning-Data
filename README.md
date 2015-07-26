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
which contains the tidy data set with the average of each variables for each activity 
and each subject. After the execution there is a new variable **tidy.data.set** in your 
R environment, which also contains the data set.

### Points of interest
Most of the R script is straight forward: 

Loading data into R, merging and subsetting the data set and renaming columns

Beyond this, there are some point of interest in the script. As described at measurements 
the features.txt is parsed and only the measurements are extracted from this data set:
```R
# in features.txt the columns are described
features <- read.table("./data/UCI HAR Dataset/features.txt")

# extracts only the !!measurements!! on mean(): Mean value and std(): Standard deviation
# according to the features_info document all other mean() and std() values are calculated
mean.std <- grep("t.*((Acc)|(Gyro))-(mean|std)\\(\\)", features$V2)

data.set <- merged.set[, mean.std]
```

After the data set is prepared, a molten data set is created. This molten data set is used
to calculate the average of each variable for each activity and each subject. 
But the resulting data set is not a tidy data set, as there are variables stored in the 
column names. Therefor these variables are extracted from the data set and a tidy data 
set is created, where the variables are stored in separate columns. For this purpose 
the regmatches and regexpr functions are used. The result of this part of the script is 
a tidy data set which contains new columns for the acceleration signal (*acc.sig*), the 
sensor (*sensor*), the measurement (*measurement*) and the axis (*axis*). The prefix t 
(denote time) from the feature name was omitted by purpose, as all measurements start 
with t, so it is a constant and does not belong to the tidy data set.

```R
# calculate the average of each variable for each activity and each subject
tidy.data.set = dcast(molten.set, activity + subject ~ variable, mean)

# create a new molten data set of the average data set
molten.set <- melt(tidy.data.set, id.var = c("subject", "activity"))
						
# extract the acceleration signal
acc.sig <- regmatches(molten.set$variable, regexpr('Body|Gravity', molten.set$variable)) 
# extract the sensor
sensor <- regmatches(molten.set$variable, regexpr('Acc|Gyro', molten.set$variable))
# extract the measurement
measurement <- regmatches(molten.set$variable, regexpr('mean\\(\\)|std\\(\\)', molten.set$variable))
# extract the axis
axis <- regmatches(molten.set$variable, regexpr('[XYZ]$', molten.set$variable))

# bring all together
tidy.data.set <- cbind(molten.set, acc.sig, sensor, measurement, axis)
tidy.data.set <- tidy.data.set[, -c(3)] # remove old variable column
tidy.data.set <- tidy.data.set[, c(2, 1, 4, 5, 6, 7, 3)] # reorder the tidy data set
```

In the last step the tidy data set is written to a file.
```R
write.table(tidy.data.set, "./tidy_data_set.txt", row.name = F)
```