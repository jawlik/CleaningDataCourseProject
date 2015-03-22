# Code book for jawlik's Course Project

## Explanation of Data
The tidyDF.txt data set contains summary information from the UCI HAR dataset, which used Samsung smartphones to measure different time and frequency domains across 30 test subjects performing a variety of activities.  Specifically, the tidyDF.txt dataset contains the mean of any mean or standard deviation variable for each subject-activity combination (66 of the total 561 variables).

## Explanation of Variables
There are 68 total variables in the tidyDF.txt dataset
- Subject: a number from 1 to 30, corresponding to the test subject for the observation pertains
- Activity: 1 of 6 specific activities being measured in this observation (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

66 time and frequency domain variables (only the means or std devs)
- tBodyAccMeanXAxis
- tBodyAccMeanYAxis
- tBodyAccMeanZAxis
- tGravityAccMeanXAxis
- tGravityAccMeanYAxis
- tGravityAccMeanZAxis
- tBodyAccJerkMeanXAxis
- tBodyAccJerkMeanYAxis
- tBodyAccJerkMeanZAxis
- tBodyGyroMeanXAxis
- tBodyGyroMeanYAxis
- tBodyGyroMeanZAxis
- tBodyGyroJerkMeanXAxis
- tBodyGyroJerkMeanYAxis
- tBodyGyroJerkMeanZAxis
- tBodyAccMagMean
- tGravityAccMagMean
- tBodyAccJerkMagMean
- tBodyGyroMagMean
- tBodyGyroJerkMagMean
- fBodyAccMeanXAxis
- fBodyAccMeanYAxis
- fBodyAccMeanZAxis
- fBodyAccJerkMeanXAxis
- fBodyAccJerkMeanYAxis
- fBodyAccJerkMeanZAxis
- fBodyGyroMeanXAxis
- fBodyGyroMeanYAxis
- fBodyGyroMeanZAxis
- fBodyAccMagMean
- fBodyAccJerkMagMean
- fBodyGyroMagMean
- fBodyGyroJerkMagMean
- tBodyAccStdDevXAxis
- tBodyAccStdDevYAxis
- tBodyAccStdDevZAxis
- tGravityAccStdDevXAxis
- tGravityAccStdDevYAxis
- tGravityAccStdDevZAxis
- tBodyAccJerkStdDevXAxis
- tBodyAccJerkStdDevYAxis
- tBodyAccJerkStdDevZAxis
- tBodyGyroStdDevXAxis
- tBodyGyroStdDevYAxis
- tBodyGyroStdDevZAxis
- tBodyGyroJerkStdDevXAxis
- tBodyGyroJerkStdDevYAxis
- tBodyGyroJerkStdDevZAxis
- tBodyAccMagStdDev
- tGravityAccMagStdDev
- tBodyAccJerkMagStdDev
- tBodyGyroMagStdDev
- tBodyGyroJerkMagStdDev
- fBodyAccStdDevXAxis
- fBodyAccStdDevYAxis
- fBodyAccStdDevZAxis
- fBodyAccJerkStdDevXAxis
- fBodyAccJerkStdDevYAxis
- fBodyAccJerkStdDevZAxis
- fBodyGyroStdDevXAxis
- fBodyGyroStdDevYAxis
- fBodyGyroStdDevZAxis
- fBodyAccMagStdDev
- fBodyAccJerkMagStdDev
- fBodyGyroMagStdDev
- fBodyGyroJerkMagStdDev

## Explanations of the Transformation of Work

###1. Read in and combine data
- For all 8 datasets, read in as a table and convert to tbl_df so can be used in dplyr
- Use rbind to combine the two x datasets, two y datasets, and two subject datasets
- Pull the second colummn of the features dataset and add that as the column names in the combined X dataset
- Set an appropriate column names for the combined y and combined subject datasets
- Combine x, y and subject dataset with cbind and convert it to tbl_df

###2. Extract only the mean and std dev variables
- Use select() to pull only variables containing ".mean." or ".std."

###3. Replace the activity number with the corresponding activity name
- Merge the actitivy table with the "combined" table
- Convert it to a tbl_df, and remove the activity number columns

###4. Use descriptive label names
- Remove all period separators
- Convert "X" to the more descriptive "XAxis" and so on
- Convert all labels to the format of "firstSecondThirdFourth"
- Remove duplicate works, like "BodyBody"

###5. Make a tidy dataset of just the means of activity-subject combinations
- Split the dataset by subject and activity
- Use sapply to run colMeans on the new split dataset
- Convert it back to a dataframe, and transpose it back to the original structure
- Create a new column based on the row.names, and split it into two columns for 'Activity' and 'Subject'
- Reorder the dataframe so Activity and Subject are the first two columns
- Print it without the row.names
