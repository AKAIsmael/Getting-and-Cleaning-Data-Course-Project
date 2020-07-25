1- The datasets are read into 3 parts: 1- X_test and X_train, 2- y_test and y_train, 3- subject_train and subject_test
2- Only columns with mean and std are kept from the X variables
3- All the three parts are binded together to create X, y , subject data frames
4- The y variables are labeled by activity name as requested
5- All the dataframes are combined together to from one new tidy data set
6- The names of the y, subject data frame variables were changed to more descriptive variable names
7- For X data frame variables, since names are descriptive from the begining, the numbers were removed from the title and 
   the names were retrieved as they are
8- Using the "dplyr" package on the tidy data set the average of each variable for each activity and each subject were calculated
   leading to 180 rows (6 activities * 30 subjects)