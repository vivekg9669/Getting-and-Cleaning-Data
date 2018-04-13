# Course Project - Getting and Cleaning Data

This repository contains the course project for Getting and Cleaning Data. The file tidy.txt contains all the required results and CodeBook.md contains the features and activities. The file to be run, run_analysis.R does the following:

-> Download and unzip the data
-> Read in the features and only keep the required ones (only mean and std related features)
-> Read in the subject information
-> Read only the required features from the train and test datasets
-> Append the subject and activity information to the train and test datasets
-> Merge the train and test datasets
-> Rename the values in the activity column
-> Create the required tidy dataset, that is, mean values for the features for each subject and activity
