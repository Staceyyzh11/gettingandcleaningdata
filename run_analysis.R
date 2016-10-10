run_analysis <- function(){
  ##Step 1:Merges the training and the test sets to create one data set.%
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")##you need to put the data and this script in the working directory.%
    y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    subject <- rbind(subject_test,subject_train)##row combine first and then column combine%
    X <- rbind(X_test,X_train)
    y <- rbind(y_test,y_train)
    exprecord <- cbind(subject,y,X)

 ##Step 2:Extracts only the measurements on the mean and standard deviation for each measurement. 
    features <- read.table("./UCI HAR Dataset/features.txt") 
    meansequence <- grep("[Mm]ean",features$V2)##find the variable with term "M(m)ean"%
    stdsequence <- grep("[Ss]td",features$V2)
    sequence <- union(meansequence,stdsequence)
    sequence <- sequence + 2 ##first two columns already exist%
    extractexprecord <- exprecord[,c(1,2,sequence)]
  
  ##Step 3:Uses descriptive activity names to name the activities in the data set 
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    activity<- as.character(activity_labels$V2)
  ##find the rows with each activity%
    level1 <- grep("1",extractexprecord$V1.1) 
    level2 <- grep("2",extractexprecord$V1.1)
    level3 <- grep("3",extractexprecord$V1.1)
    level4 <- grep("4",extractexprecord$V1.1)
    level5 <- grep("5",extractexprecord$V1.1)
    level6 <- grep("6",extractexprecord$V1.1)
  ##replace the activity number with its corresponding name%
    test <- replace(extractexprecord$V1.1,level1,activity[1])
    test <- replace(test,level2,activity[2])
    test <- replace(test,level3,activity[3])
    test <- replace(test,level4,activity[4])
    test <- replace(test,level5,activity[5])
    test <- replace(test,level6,activity[6])
    extractexprecord[,2] <- test
    rename <- extractexprecord
    
    ##Step 4:Appropriately labels the data set with descriptive variable names.%
    nameofvariables <- as.character(features[sequence-2,2]) 
    nameofvariables <- c("volunteers","activity",nameofvariables)##include the name of first two columns%
    names(rename) <- nameofvariables
    ##Step 5 :From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.%   
    for (i in 1:30)
    {
      for (j in 1:6)
      {
         order <- which(rename$volunteers == i&rename$activity==activity[j])
        if (i==1&j==1)
        {  
    
          meandata <- rename[1,]
          meandata[1,1] <- i
          meandata[1,2] <- activity[j]
          for (k in 3:88)
            meandata[1,k] <- mean(as.numeric(as.character(rename[order,k])),na.rm=TRUE)
        }
        else
        {
          meandatatest <- rename[1,]
          meandatatest[1,1] <- i
          meandatatest[1,2] <- activity[j]
          for (k in 3:88)
            meandatatest[1,k] <- mean(as.numeric(as.character(rename[order,k])),na.rm=TRUE)
          meandata <- rbind(meandata,meandatatest)
    
        }
      }
    }
  write.table(meandata,"tidydata.txt",row.names=FALSE)
  return(meandata)
  
}