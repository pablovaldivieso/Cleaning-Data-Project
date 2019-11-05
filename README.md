# Cleaning-Data-Project

## Step 1: Download the data from the website provided.
Fileurl -> Variable used to download the UCI HAR Dataset

## Step 2: Read the data
features -> This variale has the column 2 data from the features text file. 
train_x -> This variable has the data from the train_x text file. 
train_y -> This variable has the data from the train_y text file (activities).
train_subject -> This variable has the data from the subject_train text file. 
data_train -> merges the data from train_x, train_y, and train_subject. 
names(data_train) -> Gives names of "Subject" to column 1 (train_subject), "Activity" to column 2 (train_y), and uses all the names from the features variable

test_x -> This variable has the data from the test_x text file. 
test_y -> This variable has the data from the test_y text file (activities).
test_subject -> This variable has the data from the subject_test text file. 
data_test -> merges the data from test_x, test_y, and test_subject. 
names(data_test) -> Gives names of "Subject" to column 1 (test_subject), "Activity" to column 2 (test_y), and uses all the names from the features variable

## Step 3: Merge the training and the test sets to create one data set
The "rbind" function combined the data_train and data_set data sets into one data set called combined_data

## Step 4: Extract only the measurements on the mean and standard deviation for each measurement
mean_std_data -> using the "grep" function to match "mean" and "std" words in the features variable
data_only_mean -> "subsetted" only the mean and standard deviation variables from the combined_data data set. The first two columns remained the same. Columns 2+ include only mean and std values. 

## Step 5 Use descriptive activity names to name the activities in the data set
activity_labels -> the name of each activity are in the second column of the activity_label text 
data_only_mean_std$activity -> here the activities stored in "activity_labels" matches the code displayed on train/test_y data (i.e., 1 became walking). 

## Step 6 Appropriately labels the data set with descriptive variable names.
names_new -> used the gsub function combined with regular expressions to replace namess to more appropiate names. For instance, the title that started with "t" became "TimeDomain" and that reasoning applied to all the tiles in the data_only_mean_std data set. 

## Step 7 From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
The "aggregate" function splits the data into subsets and calculates the mean for each data subset. Only columns 3-81 are applicable. 

