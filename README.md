# getdata-014
Repository for the course project for Getting and Cleaning Data course at Coursera

This repo contains the file run_analysis.R that performs the analysis of the dataset for the project.

The file run_analysis. R assumes that the working directory is the unzipped directory of the UCI HAR dataset (i.e., the directory contains "test" and "train" subdirectories).

First, the script loads the datasets for the train and the test phases (variables `x_train` and `x_test`) and merges them (variable `x_merged`). 

Then, it loads the names of the measurements (features) into variable `features` and creates the new variable named 
`features_mean_std` that consists only of those features that have the words *mean* or *std*. 

Next, a subset of measurements (`x_subset`) that consists only of those mesaurements specified by `features_mean_std`. 

The labels are loaded (`y_train`, `y_test`) and merged (`y_merged`) and then the names of the labes are read (`activity_labels`). a new column is added to the dataset (now called `x_labels`) which contains the name of each activity that the user was doing during measurements.

Finally, the subjects' indices are added the dataset (now called `x_subjects`).

Now, the required subset that contains only the measurements the represent mean or standard deviation is created and activity labels and subject indices are added to it.

The task in the project was to calculate the mean values for each variable for each activity and subject. So, a groups is created (`activities`), grouping by the activity and the subject. First, the mean is calculated for the first two columns and the results are added to a new dataset. Then, the process is repeated for all other columns. The names of columns are changes so that they match the original names of the columns from the `x_subjects` dataset.


