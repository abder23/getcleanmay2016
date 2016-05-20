
For the creation of the file file run_analysis.R we needed the following information to create the script:

this script will do the following
1-Merges the training and the test sets to create one data set.
2-Extracts only the measurements on the mean and standard deviation for each measurement.
3_Uses descriptive activity names to name the activities in the data set
4-Appropriately labels the data set with descriptive variable names.
5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Variables used in the function run_analysis:

fpath1 to fpath8 are the path to get to a file

traindata is the data frame read from the file X_train.txt
testdata is the data frame read from the file X_test.txt

features is the data read from the file features.txt

colMeanStd: define 2 columns of features contening "Mean" and "Std" 

totaldata: is the total data frame of training and test variable 
totaldata2: is the total data frame of training and test variable plus colMeanStd: 

yyactivity are the combine variable of train and test activity
subjectaction are the combine variable of train and test subjects
totaldata3 is the data set that combine 2 columns yyactivity and subjectaction 

newtotaldata is the new total data frame with all columns, it is created by binding totaldata2 and totaldata3

tidydata: is the data frame created by aggregation of newtotaldata (tidy data set contain the average of each 
variable for each activity and each subject.)

