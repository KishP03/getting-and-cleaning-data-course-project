##Read in all the files
features            = read.table('./features.txt', header=FALSE); 
activity            = read.table('./activity_labels.txt', header = FALSE)
subject_test        = read.table('./test/subject_test.txt', header=FALSE);
x_test              = read.table('./test/X_test.txt', header = FALSE);
y_test              = read.table('./test/y_test.txt', header = FALSE);
subject_train       = read.table('./train/subject_train.txt', header=FALSE);
x_train             = read.table('./train/X_train.txt', header=FALSE);
y_train             = read.table('./train/y_train.txt', header=FALSE);

##Create and assign column names to the data imported 
colnames(activity)      <- c('activityId','activityType');
colnames(subject_test)  <- "subjectId";
colnames(x_test)        <- features[,2];
colnames(y_test)        <- "activityId";
colnames(subject_train) <- "subjectId";
colnames(x_train)       <- features[,2];
colnames(y_train)       <- "activityId";

##Combining the data sets into a final data set called data_combine
data_test       <- cbind(subject_test,x_test,y_test);
data_train      <- cbind(subject_train,x_train,y_train);
data_combine    <- rbind(data_train, data_test);

##Extracts only the measurements on the mean and standard deviation for each measurement 
col_names        <- colnames(data_combine);
mean_and_std    <- (grepl("activity..",col_names)   | grepl("subject..",col_names) 
                    | grepl("-mean..",col_names)    & !grepl("-meanFreq..",col_names)   & 
                    !grepl("mean..-",col_names)     | grepl("-std..",col_names)         & 
                    !grepl("-std()..-",col_names));

data_combine <- data_combine[mean_and_std==TRUE];
col_names  = colnames(data_combine);


data_combine    <- merge(data_combine, activity, by='activityId',all.x=TRUE);

##Appropriately labels the data set with descriptive variable names.
col_names   <- gsub("[\\(\\)-]", "", col_names);
col_names   <- gsub("^t", "time", col_names);
col_names   <- gsub("^f", "frequency", col_names)
col_names   <- gsub("Acc", "Accelerometer", col_names);
col_names   <- gsub("Gyro", "Gyroscope", col_names);
col_names   <- gsub("Mag", "Magnitude", col_names);
col_names   <- gsub("BodyBody", "Body", col_names);

colnames(data_combine) <- col_names;

##Second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- aggregate(. ~subjectId + activityId, data_combine, mean);
tidy_data <- tidy_data[order(tidy_data$subjectId, tidy_data$activityId),];

write.table(tidy_data, "tidy_data.txt", row.name=FALSE);

