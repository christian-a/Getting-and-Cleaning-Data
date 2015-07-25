##
## load subject

train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
# combines the training and the test subject
merged.subject <- rbind(train.subject, test.subject)
names(merged.subject) <- c("subject") # rename column for easier merge

##
## 1. Merges the training and the test sets to create one data set.

train.set <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
test.set <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

merged.set <- rbind(train.set, test.set) # combines the training and the test set

##
## 2. Extracts only the measurements on the mean and standard deviation for 
## each measurement.

# in features.txt the columns are described
features <- read.table("./data/UCI HAR Dataset/features.txt")

# extracts only the !!measurements!! on mean(): Mean value and std(): Standard deviation
# according to the features_info document all other mean() and std() values are calculated
mean.std <- grep("t.*((Acc)|(Gyro))-(mean|std)\\(\\)", features$V2)

data.set <- merged.set[, mean.std]

##
## 3. Uses descriptive activity names to name the activities in the data set

# load activity description
activity.labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

# load training lables
train.labels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
# load test labels
test.labels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

# combines the training and the test lables
merged.labels <- rbind(train.labels, test.labels)
names(merged.labels) <- c("idx") # rename column for easier merge
names(activity.labels) <- c("idx", "activity") # rename columns for easier merge

# combines the data set and lable set
data.set <- cbind(data.set, merged.labels, merged.subject)

# merges the data set with the activity description
# data.set <- merge(data.set, activity.labels)

# merges the data set with the activity description
# using plyr join in order to prevent reordering
data.set <- join(data.set, activity.labels, by = "idx")
data.set <- data.set[, -c(19)] # remove now unnecessary "idx" column

##
## 4. Appropriately labels the data set with descriptive variable names.
names(data.set)[1:18] <- as.character(features[mean.std,][, "V2"])

##
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.
molten.set <- melt(data.set, id.var = c("subject", "activity"))

# extract the acceleration signal
acc.sig <- regmatches(molten.set$variable, regexpr('Body|Gravity', molten.set$variable)) 
# extract the sensor
sensor <- regmatches(molten.set$variable, regexpr('Acc|Gyro', molten.set$variable))
# extract the measurement
measurement <- regmatches(molten.set$variable, regexpr('mean|std', molten.set$variable))
# extract the axis
axis <- regmatches(molten.set$variable, regexpr('[XYZ]$', molten.set$variable))

# bring all together
tidy.data.set <- cbind(molten.set, acc.sig, sensor, measurement, axis)
tidy.data.set <- tidy.data.set[, -c(3)] # remove old variable column
tidy.data.set <- tidy.data.set[, c(1, 2, 4, 5, 6, 7, 3)] # reorder the tidy data set

# calculate the average of each variable (acceleration signal, sensor, measurement 
# and axis) for each activity and each subject
tidy.data.set = dcast(tidy.data.set, subject + activity ~ 
						acc.sig + sensor + measurement + axis, mean)

# write to the file system
write.table(tidy.data.set, "./tidy_data_set.txt", row.name = F)