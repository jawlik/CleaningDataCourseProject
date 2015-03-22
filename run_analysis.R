## Course Project Script for 'Getting and Cleaning Data' Coursera Course

## load the necessary libraries for completing the assignment
library(dplyr)
library(tidyr)

## Read in the datasets, and convert them to dplyr dataframes
xtestFile <- "C:\\Users\\mjawlik\\Documents\\R\\R-3.1.2\\CleaningDataCourseProject\\UCI HAR Dataset\\test\\X_test.txt"
xtestData <- read.table(xtestFile)
xtest <- tbl_df(xtestData)
ytestFile <- "C:\\Users\\mjawlik\\Documents\\R\\R-3.1.2\\CleaningDataCourseProject\\UCI HAR Dataset\\test\\y_test.txt"
ytestData <- read.table(ytestFile)
ytest <- tbl_df(ytestData)
subjTestFile <- "C:\\Users\\mjawlik\\Documents\\R\\R-3.1.2\\CleaningDataCourseProject\\UCI HAR Dataset\\test\\subject_test.txt"
subjTestData <- read.table(subjTestFile)
subjTest <- tbl_df(subjTestData)
xtrainFile <- "C:\\Users\\mjawlik\\Documents\\R\\R-3.1.2\\CleaningDataCourseProject\\UCI HAR Dataset\\train\\X_train.txt"
xtrainData <- read.table(xtrainFile)
xtrain <- tbl_df(xtrainData)
ytrainFile <- "C:\\Users\\mjawlik\\Documents\\R\\R-3.1.2\\CleaningDataCourseProject\\UCI HAR Dataset\\train\\y_train.txt"
ytrainData <- read.table(ytrainFile)
ytrain <- tbl_df(ytrainData)
subjTrainFile <- "C:\\Users\\mjawlik\\Documents\\R\\R-3.1.2\\CleaningDataCourseProject\\UCI HAR Dataset\\train\\subject_train.txt"
subjTrainData <- read.table(subjTrainFile)
subjTrain <- tbl_df(subjTrainData)
featuresFile <- "C:\\Users\\mjawlik\\Documents\\R\\R-3.1.2\\CleaningDataCourseProject\\UCI HAR Dataset\\features.txt"
featuresData <- read.table(featuresFile)
features <- tbl_df(featuresData)
activityFile <- "C:\\Users\\mjawlik\\Documents\\R\\R-3.1.2\\CleaningDataCourseProject\\UCI HAR Dataset\\activity_labels.txt"
activityData <- read.table(activityFile)
activityLabels <- tbl_df(activityData)

## combine the x, y and subject datasets
xCombined <- rbind(xtest, xtrain)
yCombined <- rbind(ytest, ytrain)
subjCombined <- rbind(subjTestData, subjTrainData)

## add features as the column heading for xCombined
xcolHeaders <- features$V2
xnames <- make.names(xcolHeaders, unique = TRUE, allow_ = TRUE)
names(xCombined) <- xnames

## Add name to y table, and combine with x dataset
names(yCombined) <- "Activity"
combined <- cbind(yCombined, xCombined)

## Add names to subject tables, and add to combined dataset
names(subjCombined) <- "Subject"
combined <- cbind(subjCombined, combined)

## Make combined a dplyr datafram
combinedDF <- tbl_df(combined)


## PART 2
## Extract only means and standard deviations 
ExtractedDF <- select(combinedDF, Subject, Activity, contains(".mean."), contains(".std."))

## PART 3
## Replace activity # with the Activity Name
names(activityLabels) <- c("Activity", "ActivityName")
labeledDF <- merge(activityLabels, ExtractedDF, by.x = "Activity", by.y = "Activity")
labeledDF2 <- tbl_df(labeledDF)
part3DF <- select(labeledDF2, -Activity)

## Part 4
## Clean up labels and give descriptive names
names(part3DF) <- sub("...X", "XAxis", names(part3DF))
names(part3DF) <- sub("...Y", "YAxis", names(part3DF))
names(part3DF) <- sub("...Z", "ZAxis", names(part3DF))
names(part3DF) <- sub(".mean", "Mean", names(part3DF))
names(part3DF) <- sub(".std", "StdDev", names(part3DF))
names(part3DF) <- sub("BodyBody", "Body", names(part3DF))
names(part3DF) <- sub("[.]", "", names(part3DF))
names(part3DF) <- sub("[.]", "", names(part3DF))

## PART 5
## Create a tidy dataset of average of each var for subject and activity
splitDF <- split(part3DF, list(part3DF$Subject, part3DF$Activity))
meanDF <- sapply(splitDF, function(x) colMeans(x[,3:68], na.rm = TRUE))
##transpose back to original structure
meanDF <- as.data.frame(t(meanDF))  
## Create a column for the row.names, and separate into Subject and Activity
meanDF$names <- rownames(meanDF)
sepDF <- separate(meanDF, names, c("Subject", "Activity"), sep = "[.]")
## Move Subject and Activity cols to the the first two columns, and remove row.names
tidyDF <- select(sepDF, Subject, Activity, 1:66)
row.names(tidyDF) <- NULL

write.table(tidyDF, "tidyDF.txt", row.names = FALSE)



