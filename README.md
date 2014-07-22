Getting and Cleaning Data Peer Assignment
=========================================
## Introduction
One of the most exciting areas in all of data science right now is wearable computing. The purpose of this project is to analyze data collected from accelerometers from the Samsung Galaxy S smartphone. The data is available [here (zip file)](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A full description [is available](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) at the site where the data was obtained.
## Requirements
This project does not require any additional packages. It has been tested with R version 3.0.2 (2013-09-25), platform i386-w64-mingw32/i386 (32-bit).
## Scripts
There is one script: __run_analysis.R__. Download the script from this repo.
## Dataset
The functions within run_analysis.R download the 
[dataset (zip file)](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extract the files into a subfolder named "__dataset__". 
## Analysis
__run_analysis.R__ and the "__dataset__" folder are stored in the project directory. Set this project directory as "__working directory__" in R Gui / RStudio and __source run_analysis.R__. After sourcing run_analysis.R the following __functions__ are available:
* _getUCIData()_
* _getUCIDataWin()_

Run *__getUCIData()__* to download the dataset and unzip the files in the dataset folder. In case of a *"nonzero exit status"* warning (for example on Windows machines), you can use the *__getUCIDataWin()__* function in order to download and unzip the dataset.
## Result
The result of the analysis is a space-separated data file named __results.txt__ in the project directory. Read it into R with:
> read.table('results.txt', header = TRUE)

Fields are explained in __codeBook.md__.
