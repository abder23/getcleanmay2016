##this script will do the following
##1-Merges the training and the test sets to create one data set.
##2-Extracts only the measurements on the mean and standard deviation for each measurement.
##3_Uses descriptive activity names to name the activities in the data set
##4-Appropriately labels the data set with descriptive variable names.
##5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis <- function(){
      fpath1 <- "C:/Coursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
      fpath2 <- "C:/Coursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"    
      fpath3 <- "C:/Coursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"
      fpath4 <- "C:/Coursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
      fpath5 <- "C:/Coursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"
      fpath6 <- "C:/Coursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"
      fpath7 <- "C:/Coursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"
      fpath8 <- "C:/Coursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"      
      
      traindata <- read.table(fpath1, sep = "", header = FALSE)
      testdata <- read.table(fpath2, sep = "", header = FALSE)
      
      ##check if 2 dataframe have the same number of colums ncol(traindata)=ncol(testdata)
      
      ##Merge the training and test data
      totaldata <- rbind(traindata, testdata)
      
      ##extracting measurements on the mean and std from features file
      ##read the file first. It has 2 colums and we want to work on the the second one.
      ##we need to search words "Mean" and "Std" 
      features <- read.table(fpath3, sep = "", header = FALSE)
      
      ##we need to associated namesin features.txt to columns in totaldata dataframe
      features2<- features[, 2]  
      features2 <- as.vector(features2)
      colnames(totaldata) <- features2
      
      colMeanStd <- grep(".*Mean.*|.*Std.*", features2)
      
      ##we reduce the size of the dataset 
      totaldata2 <- totaldata[, colMeanStd]
      

      ##associate appropriate name to activities in data set
      ##read activity file
      activity <- read.table(fpath4, sep = "", header = FALSE)
      
      ##associate activity name with subject
      ##merge train and test 
      
      activitytrain <- read.table(fpath5, sep = "", header = FALSE)
      activitytest <- read.table(fpath6, sep = "", header = FALSE)
      yyactivity <- rbind(activitytrain, activitytest)
      
      subjecttrain <- read.table(fpath7, sep = "", header = FALSE)
      subjecttest <- read.table(fpath8, sep = "", header = FALSE)
      subjectaction <- rbind(subjecttrain, subjecttest)
      
      ##add 2 columns to the totaldata2 detaset: subjectaction and yyactivity
      totaldata3 <- cbind(subjectaction, yyactivity)
      
      ##we give name to the new column
      colnames(totaldata3) <- c("subject", "activity")

      ##we recreate a new dataset with activity and subject include
      newtotaldata <- cbind(totaldata2, totaldata3)
      
      ##replace number by activity name 
      col9 <- newtotaldata[, 9]
      col9 <- gsub("1", "WALKING", col9)
      col9 <- gsub("2", "WALKING_UPSTAIRS", col9)
      col9 <- gsub("3", "WALKING_DOWNSTAIRS", col9)
      col9 <- gsub("4", "SITTING", col9)
      col9 <- gsub("5", "STANDING", col9)
      col9 <- gsub("6", "LAYING", col9)
      newtotaldata[, 9] <- col9
      
    
      ##creation of a tidy data
      tidydata = aggregate(newtotaldata, by=list(activity = newtotaldata$activity, subject=newtotaldata$subject), mean)
      
      ##remove the 2 last column of tidydata because the aggregate will add them at the beguining of the dataset
      tidydata[ ,11] <- NULL
      tidydata[ ,10] <- NULL
      
      ##create tidy file
      write.table(tidydata, "tidy.txt", sep="\t", row.name=FALSE)
}