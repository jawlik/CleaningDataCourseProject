## CleaningDataCourseProject README.md
Repo containing files for the 'Getting and Cleaning Data' course project.

#Summary
The objective was to combine several wearable computing datasets from the UCI HAR website (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
and calculate the mean for each activity-subject combination, returning this information in a tidy dataset.

The final output is found in the tidyDF.txt file
The R script developed to conduct this work is found in run_analysis.R

The UCI HAR dataset is composed of the following files:
- X_test: contains observations for the test cases across 561 variables
- y_test: for each observation in the x_test set, contains a numerical value corresponding to 1 of 6 activities
- subject_test: contains the subject ID for correlating to the observation in X_test
- X_train: contains observations for the training cases across 561 variables
- y_train: for each observation in the x_train set, contains a numerical value corresponding to 1 of 6 activities
- subject_train: contains the subject ID for correlating to the observation in X_train
- features: contains the 561 variable names for the columns in X_test and X_train
- activity labels: contains the activity names corresponding the values in the y_test and y_train files

#Approach used in run_analysis.R
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

