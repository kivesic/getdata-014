# getdata-014
Repository for the course project for Getting and Cleaning Data course at Coursera

This repo contains the file run_analysis.R that performs the analysis of the dataset for the project.

The file run_analysis. R assumes that the working directory is the unzipped directory of the UCI HAR dataset (i.e., the directory contains "test" and "train" subdirectories).

First, the script loads the datasets for the train and the test phases (variables `x_train` and `x_test`) and merges them (variable `x_merged`). 

Then, it loads the names of the measurements (features) into variable `features` and creates the new variable named 
`features_mean_std` that consists only of those features that have the words *mean* or *std*. 

Next, a subset of measurements (`x_subset`) that consists only of those mesaurements specified by `features_mean_std`. 
