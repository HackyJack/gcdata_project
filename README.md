The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

Project data can be found at: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Script: run_analysis.R
	1.	Downloads data into working directory.
	2.	Extracts mean and standard deviation from training and test datasets.
	3.	Loads activity and subject data from each dataset and merges with the dataset.
	4.	Appropriately labels the data set with descriptive variable names.
	5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject. This is shown in the output file called ???cleandata.txt.???
