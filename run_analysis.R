####################################################################
# Peer-graded Assignment Getting and Cleaning Data:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of
#   each variable for each activity and each subject.

####################################################################
# 0. Download and Unzip the ZIP-file:

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "Data.zip"

if (!file.exists(fileName)) {
    download.file(fileUrl, destfile=fileName)
    unzip(fileName)
}

####################################################################
# 1. Merges the training and the test sets to create one data set.

# Function for loading data into R.
load_data_into_R <- function(type="train") {
    
    rootFolder <- "UCI HAR Dataset"
    features <- read.table(file.path(rootFolder,"features.txt"))

    data <- read.table(file.path(rootFolder,type,paste0("X_",type,".txt")))
    colnames(data) <- features[,2]
    
    activity <- read.table(file.path(rootFolder,type,paste0("y_",type,".txt")))
    colnames(activity) <- "activity"
    
    subject <- read.table(file.path(rootFolder,type,paste0("subject_",type,".txt")))
    colnames(subject) <- "subject"
    
    data_out <- cbind(subject,activity,data)
}

# Load training and test data sets:
train_data <- load_data_into_R("train")
test_data <- load_data_into_R("test")

# Merge training and test data sets:
full_data <- rbind(train_data, test_data)

####################################################################
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
feature_extract <- grep("(-mean|-std)\\(\\)", names(full_data), value=TRUE)
extract_data <- full_data[,c("activity","subject",feature_extract)]

####################################################################
#3. Uses descriptive activity names to name the activities in the data set
rootFolder <- "UCI HAR Dataset"

activity_names <- read.table(file.path(rootFolder,"activity_labels.txt"))
extract_data$activity <- activity_names[extract_data[,"activity"],2]

#4.Appropriately labels the data set with descriptive variable names.
new_colNames <- gsub("^t","Time",names(extract_data))     # Subsitute prefix t by Time.
new_colNames <- gsub("^f","Frequency",new_colNames)       # Subsitute prefix f by Frequency.
new_colNames <- gsub("\\(\\)","",new_colNames)              # Remove parenthess.

colnames(extract_data) <- new_colNames

####################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of
# each variable for each activity and each subject.
library(reshape2)

# Retrieve the measure variables from the variables (all except subject and activity):
measure_vars <- names(extract_data)[!(names(extract_data) %in% c("subject","activity"))] 

# Create a long table by transposing the measure variables from the columns to the rows:
dataMelt <- melt(extract_data,id=c("subject","activity"), measure.vars=measure_vars)

# Calculate the mean for each variable, grouped by Subject and activity.
dataCast <- dcast(dataMelt, subject + activity ~ variable, mean)

####################################################################
# 6. Write output file:
write.table(x=dataCast, file="tidy_data_set.txt", row.names=FALSE, quote=FALSE)
