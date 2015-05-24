library(dplyr)

x_train <- read.csv("./train/X_train.txt", sep="", header = F) # separator = whitespace, no header present in the file

x_test <- read.csv("./test/X_test.txt", sep="", header = F)

x_merged <- merge(x_train, x_test, all=T, sort = F ) # there are no common values, so all the columns and rows have to be merged. Additionally, we do not
                                                     # the data to be sorted so that x_train data set is on the top and x_test is below, thus making it 
                                                     # possible to label participants

features <- read.csv("./features.txt", sep="", header=F)

features_mean_std <- features[c(grep("std", features$V2), grep("mean", features$V2) ),] # indices of names with "mean" or "std"

x_subset <- x_merged[,features_mean_std[,1]]  # subset of measurements with columns that contain "mean" or "std"

y_train <- read.csv("./train/y_train.txt", header = F) # training set labels
y_test <- read.csv("./test/y_test.txt", header = F) # test set labels
y_merged <- rbind(y_train, y_test) # labels for both sets

activity_labels <- read.csv("./activity_labels.txt", sep="", header = F) # names of activity labels 

labels_merged <- merge(y_merged, activity_labels, sort = F) # merging indices of activities with their names

x_labels <- mutate(x_subset, activity = labels_merged[,2]) # adding a columns with activity names

var_labels <- c(as.character(features_mean_std[,2]), "activity")  # extracting names of features as characters
colnames(x_labels) <- var_labels  # adding appropriate names to all the columns with activities

subject_train <- read.csv("./train/subject_train.txt", sep="", header = F) # indices of participatns, train dataset
subject_test <- read.csv("./test/subject_test.txt", sep="", header = F) # indices of participatns, test dataset
subjects <- rbind(subject_train, subject_test) # binding indices of participants for both datasets

x_subjects <- mutate(x_labels, subject = subjects[,1]) # adding indices of the participants to the dataset

activities <- group_by(x_subjects, activity, subject) # creating a group: activities & subjects
num_vars <- length(features_mean_std[,2])  # number of diff. variabless for mean in tidy data set

mean1 <- summarise(activities, mean1 = mean(x_subjects[,1]))  # mean of the 1st column
mean2 <- summarise(activities, mean2 = mean(x_subjects[,2]))  # mean of the 2nd column
result <- merge(mean1, mean2, sort = F)  # merging the 1st two columns manually

names <- colnames(result)  # changing the names of the first two columns in the new dataset
names[3] <- as.character(features_mean_std[1,2])
names[4] <- as.character(features_mean_std[2,2])
colnames(result) <- names

# doing the same for all other columns
for( i in 3:num_vars) { 
  mean_temp <-  summarise(activities, mean_temp = mean(x_subjects[,i]));   # mean of the i-th column
  result <- merge(result, mean_temp,  sort = F); # merge the i-th column's mean
  names <- colnames(result) # fix the name of the i-th column...
  names[length(names)] <- as.character(features_mean_std[i,2])
  colnames(result) <- names
}

