# run_analysis.R
# Author: Mark Stam
#
# --------------------------------------
# First run the getUCIData function:
# --------------------------------------

getUCIData <- function() {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="dataset.zip", method="curl")
  dateDownloaded <- date()
  dateDownloaded
  unzip("dataset.zip")
}
# In case of a "nonzero exit status" warning (for example on Windows machines), you can try:
getUCIDataWin <- function() {
  fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="dataset.zip")
  dateDownloaded <- date()
  dateDownloaded
  unzip("dataset.zip")
  file.rename("UCI HAR Dataset", "dataset")
}
run_analysis <- function() {
  # dependencies
  require(plyr)
  # Assignment: create one R script called run_analysis.R that does the following:
  dataDir <- file.path('./dataset')
  # 1) Merges the training and the test sets to create one data set
  # 1a) create dataframe from files in test folders
  subj_test <- read.table(paste0(dataDir,"/test/subject_test.txt"))
  X_test <- read.table(paste0(dataDir,"/test/X_test.txt"))
  y_test <- read.table(paste0(dataDir,"/test/y_test.txt"))
  testDF <- cbind(subj_test,y_test,X_test)
  # 1b) create dataframe from files in test folders
  subj_train <- read.table(paste0(dataDir,"/train/subject_train.txt"))
  X_train <- read.table(paste0(dataDir,"/train/X_train.txt"))
  y_train <- read.table(paste0(dataDir,"/train/y_train.txt"))
  trainDF <- cbind(subj_train,y_train,X_train)
  # 1c) merge dataframes
  DF <<- rbind(trainDF,testDF)
  # 1d) get column names from features.txt
  features <- read.table(paste0(dataDir,"/features.txt"))
  columnNames <- c("Subject","Activity_Code",as.vector(features$V2))
  colnames(DF) <- columnNames
  # 2) Extracts only the measurements on the mean and the standard deviation for each measurement
  measurement_mean <- DF[grep(".*mean\\(\\)", names(DF),fixed=T)]
  standard_deviation <- DF[grep(".*std\\(\\)",names(DF),fixed=T)]
  DFsub <- DF[,1:2]
  # 3) Uses descriptive activity names to name the activities in the data set
  # 4) Appropriately labels the data set with descriptive variable names
  # Use activity_labels.txt to name the activities of the data frame
  activity_labels <- read.table(paste0(dataDir,"./activity_labels.txt"))
  colnames(activity_labels) <- c("Activity_Code","Activity_Name")
  DFsubnames <- join(DFsub,activity_labels)
  DFtotal <- cbind(DFsubnames,measurement_mean,standard_deviation)
  # Generate a tidy data set
  write.csv(DFtotal, file="./tidydata.txt",row.names=F)
  # 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject
  tidydata_avg <- aggregate(DFtotal, list(Subject = DFtotal[,1], Activity = DFtotal[,2]), mean)
  write.csv(tidydata_avg, file="./tidydata_avg.txt",row.names=F)
}
