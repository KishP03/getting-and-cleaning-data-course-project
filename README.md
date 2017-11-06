# getting-and-cleaning-data-course-project

You must first download and unzip the UCI HAR DATASET and set the unzipped file as your working directory.

Link to download data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Link to full description of the data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script, run_analysis.R, does the following:
1.	Reads in all the files from activity type, features, test, and train data
2.	Creates and assigns column names to the data imported
3.	Combines the data sets from test and train into a final data set
4.	Extracts only the measurements on the mean and standard deviation for each measurement.
5.	Uses descriptive activity names to name the activities in the data set
6.	Appropriately labels the data set with descriptive variable names.
7.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
