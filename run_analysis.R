# run_analysis.R
# Author: Mark Stam
#
# --------------------------------------
# First run the getUCIData function:
# --------------------------------------

getUCIData <- function() {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  message('downloading dataset ...')
  download.file(fileUrl, destfile="dataset.zip", method="curl")
  dateDownloaded <- date()
  dateDownloaded
  unzip("dataset.zip")
}
# In case of a "nonzero exit status" warning (for example on Windows machines), you can try:
getUCIDataWin <- function() {
  fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  message('downloading dataset ...')
  download.file(fileUrl, destfile="dataset.zip")
  dateDownloaded <- date()
  dateDownloaded
  unzip("dataset.zip")
  file.rename("UCI HAR Dataset", "dataset")
}
# ------------------------------------------------------
# Once the dataset is available, execute run_analysis()
# ------------------------------------------------------
run_analysis <- function() {
  # Assignment: create one R script called run_analysis.R that does the following:
  # 1) Merges the training and the test sets to create one data set
  dataDir <- file.path('./dataset/')
  message('reading files into tables ...')
  # 3) Uses descriptive activity names to name the activities in the data set
  activity_labels <- read.table(paste0(dataDir,"activity_labels.txt"))
  features <- read.table(paste0(dataDir,"features.txt"))
  ## test folder
  subject_test <- read.table(paste0(dataDir,"test/subject_test.txt"))
  X_test <- read.table(paste0(dataDir,"test/X_test.txt"))
  y_test <- read.table(paste0(dataDir,"test/y_test.txt"))
  ## train folder
  subject_train <- read.table(paste0(dataDir,"train/subject_train.txt"))
  X_train <- read.table(paste0(dataDir,"train/X_train.txt"))
  y_train <- read.table(paste0(dataDir,"train/y_train.txt"))
  ## names
  names(X_train) <- features[,2]
  names(X_test) <- features[,2]
  ## labels
  y_train <- factor(y_train$V1,levels = activity_labels$V1, labels = activity_labels$V2)
  y_test <- factor(y_test$V1,levels = activity_labels$V1, labels = activity_labels$V2)
  ## create dataframe
  message('creating dataframe ...')
  train <- cbind(X_train, activity = y_train, subject = subject_train)
  test <- cbind(X_test, activity = y_test, subject = subject_test)
  DF <- rbind(train,test)
  # 2) Extracts only the measurements on the mean and the standard deviation for each measurement
  message('Using mean and standard deviation ...')
  measurement_mean <- grep('[Mm]ean',names(DF)) ## simple grep expression
  standard_deviation <- grep('[Ss]td',names(DF)) ## simple grep expression
  # 4) Appropriately labels the data set with descriptive variable names
  DFnames <- names(DF)
  DFnames <- gsub("tB","time_B",DFnames)
  DFnames <- gsub("tG","time_G",DFnames)
  DFnames <- gsub("fB","frequency_B",DFnames)
  DFnames <- gsub("Acc","Acceleration",DFnames)
  DFnames <- gsub("\\.+|-","_",DFnames)
  names(DF) <- DFnames
  DF <- DF[,c(measurement_mean,standard_deviation,562,563)]
  DF <- transform(DF,V1 = factor(V1))
  ### Generate a tidy data set
  message('generating tidy data set ...')
  write.csv(DF, file="./tidydata.txt",row.names=T)
  # 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject
  message('calculating averages ...')
  avgdata <- aggregate(.~activity,data=DF,FUN=mean)
  message('generating tidy data set with average values ...')
  write.csv(avgdata, file="./avgdata.txt",row.names=T)
  # print average values to screen
  avgdata
}