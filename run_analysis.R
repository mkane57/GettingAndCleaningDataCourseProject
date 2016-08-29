## run_analysis.R
## Author: Matt Kane
## for Coursera MOOC 'Getting and Cleaning Data Course Project'
## includes libraries reshape2

## This script will use data from the Samsung Galaxy S accelerometer that can be obtained at
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## This script assumes that the data is unzipped and in the working directory

## to set the working directory locally
## setwd("./GettingAndCleaningDataCourseProject/UCI HAR Dataset/")

## This script will complete the following requirements (albiet out of order)

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
##    of each variable for each activity and each subject.

## read all of the column names from the features file
col_names_table <- read.delim("features.txt", header = FALSE, sep = " ")
colnames(col_names_table) <- c("col_num", "col_name")
col_names <- col_names_table$col_name

## alter some of the column names before they become actual column names to make things easier later (per requirement #4)
col_names <- gsub("gravityMean", "gravityM", col_names) ## this is so that gravityMean won't show up later in my pattern for mean|std
col_names <- gsub("meanFreq", "mFreq", col_names) ## this is so that meanFreq won't show up later in my pattern for mean|std
col_names <- gsub("Mean\\,", "M_", col_names) ## this is so that mean in an angle won't show up later in my pattern for mean|std
col_names <- gsub("Mean\\)", "M_", col_names) ## this is so that mean in an angle won't show up later in my pattern for mean|std
col_names <- gsub("angle\\(", "angle_", col_names)
col_names <- gsub("\\,", "_", col_names)
col_names <- gsub("\\(", "", col_names)
col_names <- gsub("\\)", "", col_names)
col_names <- gsub("\\-", "_", col_names)

## store the labels
activity_labels <- data.frame(activity_label_id = 1:6, activity = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

## read the raw data for the test data 
x_test <- read.table("./test/X_test.txt", header = FALSE, col.names = col_names)
subject_test <- read.table("./test/subject_test.txt", header = FALSE, col.names = c("subject_id"))
y_test <- read.table("./test/y_test.txt", header = FALSE, col.names = c("activity_label_id"))

## add the activity labels to the label table (per requirement #3)
y_test_with_labels <- merge(y_test, activity_labels, by = "activity_label_id")

## remove all columns that don't have mean or std in them (per requirement #2)
## we only need to match on these words because we removed non mean values earlier from col_names
x_test_mean_std <- x_test[,grepl("mean|std", col_names)] 

## combine the columns of data into a single data frame
test_set <- cbind(subject_test, y_test_with_labels, x_test_mean_std)

## read the raw data for the train data 
x_train <- read.table("./train/X_train.txt", header = FALSE, col.names = col_names)
subject_train <- read.table("./train/subject_train.txt", header = FALSE, col.names = c("subject_id"))
y_train <- read.table("./train/y_train.txt", header = FALSE, col.names = c("activity_label_id"))

## add the activity labels to the label table (per requirement #3)
y_train_with_labels <- merge(y_train, activity_labels, by = "activity_label_id")

## remove all columns that don't have mean or std in them (per requirement #2)
## we only need to match on these words because we removed non mean values earlier from col_names
x_train_mean_std <- x_train[,grepl("mean|std", col_names)]

## combine the columns of data into a single data frame
train_set <- cbind(subject_train, y_train_with_labels, x_train_mean_std)

## now combine the test and train datasets (per requirement #1)
full_set <- rbind(test_set, train_set)

## and we are going to remove the column activity_label_id because it is redundant
full_set$activity_label_id <- NULL

## now we are going to change the rest of column names to be more readable (per requirement #4)
new_col_names <- colnames(full_set)
new_col_names <- sub("^t", "time_", new_col_names)
new_col_names <- sub("^f", "freq_", new_col_names)
new_col_names <- gsub("Body", "body_", new_col_names)
new_col_names <- sub("Gravity", "gravity_", new_col_names)
new_col_names <- sub("Acc", "accel_", new_col_names)
new_col_names <- sub("Gyro", "gyro_", new_col_names)
new_col_names <- sub("Mag", "magnitude_", new_col_names)
new_col_names <- sub("Jerk", "jerk_", new_col_names)
new_col_names <- sub("__", "_", new_col_names)
new_col_names <- tolower(new_col_names)
colnames(full_set) <- new_col_names

## *** at this point, full_set meets the requirements for #1 through #4

## for requirement #5, we are going to use the reshape2 packages
if (!("reshape2" %in% installed.packages())) {
  install.packages("reshape2")
}

## load the reshape2 package
library(reshape2)

## we first need to melt the dataset down so that we can reshape it.  To do that, we will be
## putting the first 3 variables (subject_id, activity_label_id, activity_label_desc) in the 
## 'id' variables, and the rest in the measurement variables
avg_set <- melt(full_set, id = new_col_names[1:2], measure.vars = new_col_names[3:length(new_col_names)])
## add a concatenated column of subject and activity, because that is what we will recast on
avg_set$subject_activity <- paste(avg_set$subject_id, avg_set$activity)
## recast the data set to average all of the values together, grouping by the new subject_activity
avg_set <- dcast(avg_set, subject_activity ~ variable, mean)
## now to make this dataset tidy, we need to split the subject_activity back up
beforeSpace <- function(x) { strsplit(x, " ")[[1]][1]}
afterSpace <-  function(x) { strsplit(x, " ")[[1]][2]}
avg_set$subject_id <- as.numeric(unlist(lapply(avg_set$subject_activity, beforeSpace)))
avg_set$activity <- as.factor(unlist(lapply(avg_set$subject_activity, afterSpace)))
## reorder to columns so subject and activity are at the front
col_count <- length(colnames(avg_set))
avg_set <- avg_set[,c(col_count-1, col_count, 2:col_count-2)]
## remove the subject_activity column, it's useless
avg_set$subject_activity <- NULL
## rename all of the columns except subject and activity to have an avg_ in front of them
col_names <- colnames(avg_set)
col_count <- length(col_names)
for (i in 3:col_count) {
  col_names[i] <- paste0("avg_", col_names[i])
}
colnames(avg_set) = col_names

write.table(avg_set, "output.txt", row.names = FALSE)


