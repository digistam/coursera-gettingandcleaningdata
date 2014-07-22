# run_analysis.R
# Author: Mark Stam
#
# --------------------------------------
# First run the getUCIData function:
# --------------------------------------

getUCIData <- function() {
  if (!file.exists("dataset") ) {
    dir.create("dataset")
  }
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="dataset.zip", method="curl")
  dateDownloaded <- date()
  unzip("dataset.zip",exdir = "./dataset")
}
# In case of a "nonzero exit status" warning (for example on Windows machines), you can try:
getUCIDataWin <- function() {
  if (!file.exists("dataset") ) {
    dir.create("dataset")
  }
  fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="dataset.zip")
  dateDownloaded <- date()
  unzip("dataset.zip",exdir = "./dataset")
}

