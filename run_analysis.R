library(dplyr)
library(data.table)

filename <- "dataset.zip"

##Downloading and unzipping the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, mode = "wb")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

##Read in the features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

##Required features
requiredFeatures <- grep(pattern = ".*mean.*|.*std.*", x = features[,2])
featureNames <- features[requiredFeatures,2]

##Reading the train and test files
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_train <- X_train[requiredFeatures]
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")


X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_test <- X_test[requiredFeatures]
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

##Appending activity label and subject information to the feature set
train <- cbind(trainSubjects, y_train, X_train)
test <- cbind(testSubjects, y_test, X_test)

##Merging the train and test datasets
data <- rbind(train, test)

##Renaming the columns
colnames(data) <- c("Subject", "Activity", featureNames)

##Renaming the activities
data[data$Activity == 1, "Activity"] <- "WALKING"
data[data$Activity == 2, "Activity"] <- "WALKING_UPSTAIRS"
data[data$Activity == 3, "Activity"] <- "WALKING_DOWNSTAIRS"
data[data$Activity == 4, "Activity"] <- "SITTING"
data[data$Activity == 5, "Activity"] <- "STANDING"
data[data$Activity == 6, "Activity"] <- "LAYING"

##Creating the required dataset
tidyDataset <- data %>%
               group_by(Subject, Activity) %>%
               summarise_all(funs(mean))

write.table(tidyDataset, "tidy.txt", row.names = FALSE)
