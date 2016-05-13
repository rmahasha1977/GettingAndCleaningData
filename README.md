# GettingAndCleaningData Course Project - JHU


This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset if it does not already exist in the working directory. The data set is downloaded from -
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. The file is unzipped and the activity and feature information is extracted.

3. The activity labels and features are then read from the unzipped files.

4. The training and test datasets are then loaded, and only those columns are kept which
   reflect a mean or standard deviation.

5. The activity and subject data for each dataset are loaded and a merge is performed based on feature names.

6. The activity and subject columns are converted into factors.

7. Finally, a tidy dataset is created that consists of the average (mean) value of each variable for each subject and activity pair.

8. The end result is shown in the file 'tidy.txt'.
