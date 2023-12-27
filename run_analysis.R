#### Load Package
library(tibble)
library(data.table)
library(dplyr)

#### Download the dataset ###
file <- "./practice_week4.zip"

# Create the file.
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, file, method="curl")


# Unzip file
unzip('practice_week4.zip')


# Assigning data frame
feat <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
head(feat)
act <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
head(act)
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
head(sub_test)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feat$functions)

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = feat$functions)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


## 1 . Merges the training and the test sets to create one data set.

X <- as_tibble(rbind(x_train, x_test))
Y <- as_tibble(rbind(y_train, y_test))
subject <- as_tibble(rbind(sub_train, sub_test))
merged_Dt <- as_tibble(cbind(subject, Y, X))


## 2 . Extracts only the measurements on the mean and standard deviation for each measurement.
tidy <- merged_Dt %>% select(subject, code, contains("mean"), contains("std"))


## 3. Uses descriptive activity names to name the activities in the data set
tidy$code <- gsub(1, 'WALKING',tidy$code)
tidy$code <- gsub(2, 'WALKING_UPSTAIRS',tidy$code)
tidy$code <- gsub(3, 'WALKING_DOWNSTAIRS',tidy$code)
tidy$code <- gsub(4, 'SITTING',tidy$code)
tidy$code <- gsub(5, 'STANDING',tidy$code)
tidy$code <- gsub(6, 'LAYING',tidy$code)

## 4. Appropriately labels the data set with descriptive variable names. 
names(tidy)[2] = 'activity'
names (tidy) <- gsub ('Acc', 'Accelerometer', names(tidy))
names (tidy) <- gsub ('Gyro', 'Gyroscope' , names(tidy))
names (tidy) <- gsub('BodyBody', 'Body', names(tidy))
names (tidy)<- gsub('Mag', 'Magnitude', names(tidy))
names (tidy)<-gsub("^t", "Time", names(tidy))
names (tidy)<-gsub("^f", "Frequency", names(tidy))
names (tidy)<-gsub("tBody", "TimeBody", names(tidy))
names (tidy)<-gsub("-mean()", "Mean", names(tidy), ignore.case = TRUE)
names (tidy)<-gsub("-std()", "STD", names(tidy), ignore.case = TRUE)
names (tidy)<-gsub("-freq()", "Frequency", names(tidy), ignore.case = TRUE)
names (tidy)<-gsub("angle", "Angle", names(tidy))
names (tidy)<-gsub("gravity", "Gravity", names(tidy))

## 5. Second tidy data with the average of each variable for each activity

Sec_tidy_data <- tidy %>% 
        group_by(subject, activity) %>%
        summarize_all(funs(mean))
write.table(Sec_tidy_data, "Sec_tidy_data.txt", row.name=FALSE)
