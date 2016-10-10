# gettingandcleaningdata
OUTLINE OF RUN_ANALYSIS.R


Step 1:Merges the training and the test sets to create one data set.
1.Use read.table() to read in the "txt" files in train and test directories(without reading inertial signals) into the variables with same name as files.
2.Use rbind() to merge subject_test & subject_train, X_test & X_train, y_test & y_train and store in subject, X, y respectively.
3.Use cbind() to merge subject,y, X and store in variable called exprecord.

Step 2:Extracts only the measurements on the mean and standard deviation for each measurement. 
1.Use read.table() to read in the "features.txt" file and store in the variable named features.
2.Use grep("[Mm]ean",features$V2) to collect all the collumn number having the term mean and store it into variable called meansequence. Do the same for std.(i.e.standard deviation).
3.Use union() to collect all the collumn number having the term "M(m)ean" of "S(s)td" and store it into variable called sequence. Add 2 to sequence since we have merged the data and had two columns in front of the measurements.
4.Pick the columns with the order in c(1,2,sequence).Use exprecord[,c(1,2,sequence)] and store the result into variable called extractexprecord.

Step 3:Uses descriptive activity names to name the activities in the data set
1.Use read.table() to read in the "activity_labels.txt" file and store in the variable named activity_labels.
2.Use level1 <- grep("1",extractexprecord$V1.1) to pick out all the activity with label 1 and store it into level1. Do the same for the activities with label 2-6.
3.Repeat the command test <- replace(extractexprecord$V1.1,level1,"WALKING") for level2 to level6 to create a variable test having all the activity number replaced by its corresponding names in activity_labels.
4.Then create a variable named rename replacing the 2nd column in extractexprecord.

Step 4:Appropriately labels the data set with descriptive variable names. 
1.Pick out the name of variables in features using the indices we created before, i.e. sequence-2, and store into variable nameofvariables. nameofvariables <- as.character(features[sequence-2,2])
2.Create all the name for the object rename. nameofvariables <- c("volunteers","activity",nameofvariables)
3.Change the name of rename by names() <- namesofvariables.

Step 5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
1.Store the activities' names into variable activity.
2.Use for function to loop volunteers 1-30, activity 1-6, features 1-86(column 3-88). 
3.In the innermost circulation, use which() to find the rows with corresponding volunteer and activity, and compute the average.
4.Use temp variable to store the average outcomes and use rbind() to combine all the data and store it into variable meandata. 
