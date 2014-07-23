Getting and Cleaning Data Peer Assignment
=========================================
## Introduction
One of the most exciting areas in all of data science right now is wearable computing. The purpose of this project is to analyze data collected from accelerometers from the Samsung Galaxy S smartphone. The data is available [here (zip file)](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A full description [is available](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) at the site where the data was obtained.
## Requirements
This project does not require any additional packages. It has been tested with R version 3.0.2 (2013-09-25), platform i386-w64-mingw32/i386 (32-bit).
## Scripts
There is one script: __run_analysis.R__. Download the script from this repo. You can [source the script](http://www.dummies.com/how-to/content/how-to-source-a-script-in-r.html), after which the following functions are available within your R environment.
* _getUCIData()_
* _getUCIDataWin()_
* _run_analysis()_

## Dataset
Execute the function __getUCIData()__ in order to download the 
[dataset (zip file)](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and have the files extracted into a subfolder named "__dataset__". 
In case of a *"nonzero exit status"* warning (for example on Windows machines), you can use the *__getUCIDataWin()__* function in order to download and unzip the dataset.

## Analysis
__run_analysis.R__ and the "__dataset__" folder have to be stored in the same directory. Set this directory as "__working directory__" in R Gui / RStudio. After the dataset is available, execute the run_analysis() function to do the actual analysis.

## Result
The analysis results in two comma separated files in the working directory:
* __tidydata.txt__ (all values, 10MB)
* __avgdata.txt__ (average values, 12kb)

Read 'm into R with:

> dataset1 <- read.csv("./tidydata.txt"); dataset2 <- read.csv("./avgdata.txt")

Dataset labels are explained in __codeBook.md__.
