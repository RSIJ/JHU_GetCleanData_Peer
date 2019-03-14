#  Getting and Cleaning Data Course Project

The purpose of this project is to create a clean dataset, and the corresponding components like the codebook and the exact recipe. The initial raw dataset in taken from the following website: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Goal of the project is to create a R-script, called run_analysis.R, which does take the following steps:

0. Download and Unzip the ZIP-file.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6. Write output file.

# Repository Files:
 - README.md: This file.
 - CodeBook.md : Description of the variables in the file tidy_data_set.txt.
 - run_analysis_R: The script, or recipe, used for converting the raw data to an tidy data set.
 - tidy_data_set.txt: The tidy data set, which is the output of the R script run_analysis.R
