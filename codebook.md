---
title: "code book for the project"
author: "Jerry"
date: "`r Sys.Date()`"
output: html_document
---

## **This is the code book for the project for getting and cleaning data** 

The script run_analysis.R prepares the data and then executes the different steps described in the course.


## **Data source**

The data for this project have been downloaded from this link. So you need to download it and unzip it.

The source data are from the Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

About R script


## **THE DIFFERENT STEPS**

1. Dowload the dataset from the link
2. Assigned each data to variables
        *feat <- features.txt 
        *act <- activity_labels.txt
        *sub_test <- subject_test.txt
        *x_test <-X_test.txt
        *y_test <- y_test.txt
        *sub_train <- subject_train.txt
        *x_train <- X_train.txt
        *y_train <- y_train.txt

3. Merges the training and the test sets to create one data
   *Merge the following data using rbind()*
        *x_test with x_train
        *y_test with y_train
        *sub_test with sub_train
        
   *After merge all data with cbin() to create one data*

4. Extract the measurments of the means and standard deviation
5. Uses descriptive activity names to names the activities in data set

Entire numbers in code column of the 'tidy' replaced with corresponding activity taken from second column of the activities variable

6. Appropriately labels the data set

7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
        * groupe by subject and activity 
        * summarize with the mean


