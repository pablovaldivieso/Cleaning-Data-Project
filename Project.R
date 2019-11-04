#Project Getting Clean Data 

#Dowload the data
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
        download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
        unzip("UCI HAR Dataset.zip", exdir = getwd())
}

#Read Data 
features <- read.csv('./UCI HAR Dataset/features.txt',header = FALSE, sep =" ")
features <- as.character(features[,2])

train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
data_train <- data.frame(train_subject,train_y,train_x)
names(data_train) <- c(c("subject","activity"),features)

test_x <-read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <-read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
data_test <- data.frame(test_subject, test_y, test_x)
names(data_test) <- c(c("subject","activity"),features)

#Merge the training and the test sets to create one data set
combined_data <- rbind(data_train,data_test)

#Extract only the measurements on the mean and standard deviation for each measurement
mean_std_data <- grep('mean|std',features)
data_only_mean_std <- combined_data[,c(1,2,mean_std_data+2)]

#Use descriptive activity names to name the activities in the data set
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity_labels <- as.character(activity_labels[,2])
data_only_mean_std$activity <- activity_labels[data_only_mean_std$activity]

#Appropriately labels the data set with descriptive variable names.
name_new <- names(data_only_mean_std)
name_new <- gsub("[(][)]", "", name_new)
name_new <- gsub("^t", "TimeDomain_", name_new)
name_new <- gsub("^f", "FrequencyDomain_", name_new)
name_new <- gsub("Acc", "Accelerometer", name_new)
name_new <- gsub("Gyro", "Gyroscope", name_new)
name_new <- gsub("Mag", "Magnitude", name_new)
name_new <- gsub("-mean-", "_Mean_", name_new)
name_new <- gsub("-std-", "_StandardDeviation_", name_new)
name_new <- gsub("-", "_", name_new)
names(data_only_mean_std) <- name_new

#From the data set in step 4, creates a second, independent tidy data set with the average of 
#each variable for each activity and each subject.

data_tidy <- aggregate(data_only_mean_std[,3:81], by = list(activity = data_only_mean_std$activity, subject = data_only_mean_std$subject),FUN = mean)
write.table(x = data_tidy, file = "data_tidy.txt", row.names = FALSE)