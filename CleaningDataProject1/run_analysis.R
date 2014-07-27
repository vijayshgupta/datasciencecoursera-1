# set working directory
setwd("C:\\webwork\\datasciencecoursera\\cleaning_data\\project\\")

# data feature sel col
feature_sel_col <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,516,517,529,530,542,543)

# data feature sel col names
feature_sel_col_name <- c("Time.BodyAcc.mean.x",
                          "Time.BodyAcc.mean.y",
                          "Time.BodyAcc.mean.z",
                          "Time.BodyAcc.std.x",
                          "Time.BodyAcc.std.y",
                          "Time.BodyAcc.std.z",
                          "Time.GravityAcc.mean.x",
                          "Time.GravityAcc.mean.y",
                          "Time.GravityAcc.mean.z",
                          "Time.GravityAcc.std.x",
                          "Time.GravityAcc.std.y",
                          "Time.GravityAcc.std.z",
                          "Time.BodyAccJerk.mean.x",
                          "Time.BodyAccJerk.mean.y",
                          "Time.BodyAccJerk.mean.z",
                          "Time.BodyAccJerk.std.x",
                          "Time.BodyAccJerk.std.y",
                          "Time.BodyAccJerk.std.z",
                          "Time.BodyGyro.mean.x",
                          "Time.BodyGyro.mean.y",
                          "Time.BodyGyro.mean.z",
                          "Time.BodyGyro.std.x",
                          "Time.BodyGyro.std.y",
                          "Time.BodyGyro.std.z",                             
                          "Time.BodyGyroJerk.mean.x",
                          "Time.BodyGyroJerk.mean.y",
                          "Time.BodyGyroJerk.mean.z",
                          "Time.BodyGyroJerk.std.x",
                          "Time.BodyGyroJerk.std.y",
                          "Time.BodyGyroJerk.std.z",
                          "Time.BodyAccMag.mean",
                          "Time.BodyAccMag.std",
                          "Time.BodyAccJerkMag.mean",
                          "Time.BodyAccJerkMag.std",
                          "Time.BodyGyroMag.mean",
                          "Time.BodyGyroMag.std",
                          "Time.BodyGyroJerkMag.mean",
                          "Time.BodyGyroJerkMag.std",
                          "Freq.BodyAcc.mean.x",
                          "Freq.BodyAcc.mean.y",
                          "Freq.BodyAcc.mean.z",
                          "Freq.BodyAcc.std.x",
                          "Freq.BodyAcc.std.y",
                          "Freq.BodyAcc.std.z",
                          "Freq.BodyAccJerk.mean.x",
                          "Freq.BodyAccJerk.mean.y",
                          "Freq.BodyAccJerk.mean.z",
                          "Freq.BodyAccJerk.std.x",
                          "Freq.BodyAccJerk.std.y",
                          "Freq.BodyAccJerk.std.z",
                          "Freq.BodyGyro.mean.x",
                          "Freq.BodyGyro.mean.y",
                          "Freq.BodyGyro.mean.z",
                          "Freq.BodyGyro.std.x",
                          "Freq.BodyGyro.std.y",
                          "Freq.BodyGyro.std.z",                             
                          "Freq.BodyAccMag.mean",
                          "Freq.BodyAccMag.std",                             
                          "Freq.BodyAccJerkMag.mean",
                          "Freq.BodyAccJerkMag.std",          
                          "Freq.BodyGyroMag.mean",
                          "Freq.BodyGyroMag.std",          
                          "Freq.BodyGyroJerkMag.mean",
                          "Freq.BodyGyroJerkMag.std")

# load activity lables
labels <- read.table("./data/activity_labels.txt", col.names=c("level","label") )

# load test labels file 
test_labels  <- read.table("./data/test/y_test.txt", col.names="label_id")

# associating test labels levels with labels
test_labels_factor <- factor(test_labels$label_id,labels=labels$label)

# load subject test data
test_subject <- read.table("./data/test/subject_test.txt",col.names="subject")

# load test set data
test_data <- read.table("./data/test/X_test.txt")
test_data_subset <- test_data[,feature_sel_col]
names(test_data_subset) <- feature_sel_col_name

# concatonate test and training data into a single data frame
test_smartphone_activity <- data.frame(test_subject,test_labels_factor,test_data_subset)

# rename column test_labels.f to acivity
colnames(test_smartphone_activity)[colnames(test_smartphone_activity) == 'test_labels_factor'] <- 'activity'


# load train labels file 
train_labels  <- read.table("./data/train/y_train.txt", col.names="label_id")

# associating test labels levels with labels
train_labels_factor <- factor(train_labels$label_id,labels=labels$label)

# load training subject data
train_subject <- read.table("./data/train/subject_train.txt",col.names="subject")

# load test set data
train_data <- read.table("./data/train/X_train.txt")
train_data_subset <- train_data[,feature_sel_col]
names(train_data_subset) <- feature_sel_col_name

# concatonate test and training data into a single data frame
train_smartphone_activity <- data.frame(train_subject,train_labels_factor,train_data_subset)

# rename column test_labels.f to acivity
colnames(train_smartphone_activity)[colnames(train_smartphone_activity) == 'train_labels_factor'] <- 'activity'


# concatonate test and training data
smartphone_activity <- rbind(test_smartphone_activity,train_smartphone_activity )

#output data to file 
write.table(smartphone_activity, file = "smartphone_activity.csv", sep = ",")


avg_smartphone_activity <- ddply(smartphone_activity,c("subject","activity"),summarise,
            Time.BodyAcc.avg.mean.x=mean(Time.BodyAcc.mean.x),
            Time.BodyAcc.avg.mean.y=mean(Time.BodyAcc.mean.y),
            Time.BodyAcc.avg.mean.z=mean(Time.BodyAcc.mean.z),
            Time.BodyAcc.avg.std.x=mean(Time.BodyAcc.std.x),
            Time.BodyAcc.avg.std.y=mean(Time.BodyAcc.std.y),
            Time.BodyAcc.avg.std.z=mean(Time.BodyAcc.std.z),
            Time.GravityAcc.avg.mean.x=mean(Time.GravityAcc.mean.x),
            Time.GravityAcc.avg.mean.y=mean(Time.GravityAcc.mean.y),
            Time.GravityAcc.avg.mean.z=mean(Time.GravityAcc.mean.z),
            Time.GravityAcc.avg.std.x=mean(Time.GravityAcc.std.x),
            Time.GravityAcc.avg.std.y=mean(Time.GravityAcc.std.y),
            Time.GravityAcc.avg.std.z=mean(Time.GravityAcc.std.z),
            Time.BodyAccJerk.avg.mean.x=mean(Time.BodyAccJerk.mean.x),
            Time.BodyAccJerk.avg.mean.y=mean(Time.BodyAccJerk.mean.y),
            Time.BodyAccJerk.avg.mean.z=mean(Time.BodyAccJerk.mean.z),
            Time.BodyAccJerk.avg.std.x=mean(Time.BodyAccJerk.std.x),
            Time.BodyAccJerk.avg.std.y=mean(Time.BodyAccJerk.std.y),
            Time.BodyAccJerk.avg.std.z=mean(Time.BodyAccJerk.std.z),                      
            Time.BodyGyro.avg.mean.x=mean(Time.BodyGyro.mean.x),
            Time.BodyGyro.avg.mean.y=mean(Time.BodyGyro.mean.y),
            Time.BodyGyro.avg.mean.z=mean(Time.BodyGyro.mean.z),
            Time.BodyGyro.avg.std.x=mean(Time.BodyGyro.std.x),
            Time.BodyGyro.avg.std.y=mean(Time.BodyGyro.std.y),
            Time.BodyGyro.avg.std.z=mean(Time.BodyGyro.std.z),               
            Time.BodyGyroJerk.avg.mean.x=mean(Time.BodyGyroJerk.mean.x),
            Time.BodyGyroJerk.avg.mean.y=mean(Time.BodyGyroJerk.mean.y),
            Time.BodyGyroJerk.avg.mean.z=mean(Time.BodyGyroJerk.mean.z),
            Time.BodyGyroJerk.avg.std.x=mean(Time.BodyGyroJerk.std.x),
            Time.BodyGyroJerk.avg.std.y=mean(Time.BodyGyroJerk.std.y),
            Time.BodyGyroJerk.avg.std.z=mean(Time.BodyGyroJerk.std.z),                                                     
            Time.BodyAccMag.avg.mean = mean(Time.BodyAccMag.mean),
            Time.BodyAccMag.avg.std = mean(Time.BodyAccMag.std),
            Time.BodyAccJerkMag.avg.mean = mean(Time.BodyAccJerkMag.mean),
            Time.BodyAccJerkMag.avg.std = mean(Time.BodyAccJerkMag.std),
            Time.BodyGyroMag.avg.mean = mean(Time.BodyGyroMag.mean),
            Time.BodyGyroMag.avg.std = mean(Time.BodyGyroMag.std),            
            Time.BodyGyroJerkMag.avg.mean = mean(Time.BodyGyroJerkMag.mean),
            Time.BodyGyroJerkMag.avg.std = mean(Time.BodyGyroJerkMag.std),
            Freq.BodyAcc.avg.mean.x=mean(Freq.BodyAcc.mean.x),
            Freq.BodyAcc.avg.mean.y=mean(Freq.BodyAcc.mean.y),
            Freq.BodyAcc.avg.mean.z=mean(Freq.BodyAcc.mean.z),
            Freq.BodyAcc.avg.std.x=mean(Freq.BodyAcc.std.x),
            Freq.BodyAcc.avg.std.y=mean(Freq.BodyAcc.std.y),
            Freq.BodyAcc.avg.std.z=mean(Freq.BodyAcc.std.z),  
            Freq.BodyAccJerk.avg.mean.x=mean(Freq.BodyAccJerk.mean.x),
            Freq.BodyAccJerk.avg.mean.y=mean(Freq.BodyAccJerk.mean.y),
            Freq.BodyAccJerk.avg.mean.z=mean(Freq.BodyAccJerk.mean.z),
            Freq.BodyAccJerk.avg.std.x=mean(Freq.BodyAccJerk.std.x),
            Freq.BodyAccJerk.avg.std.y=mean(Freq.BodyAccJerk.std.y),
            Freq.BodyAccJerk.avg.std.z=mean(Freq.BodyAccJerk.std.z),                         
            Freq.BodyGyro.avg.mean.x=mean(Freq.BodyGyro.mean.x),
            Freq.BodyGyro.avg.mean.y=mean(Freq.BodyGyro.mean.y),
            Freq.BodyGyro.avg.mean.z=mean(Freq.BodyGyro.mean.z),
            Freq.BodyGyro.avg.std.x=mean(Freq.BodyGyro.std.x),
            Freq.BodyGyro.avg.std.y=mean(Freq.BodyGyro.std.y),
            Freq.BodyGyro.avg.std.z=mean(Freq.BodyGyro.std.z),    
            Freq.BodyAccMag.avg.mean = mean(Freq.BodyAccMag.mean),
            Freq.BodyAccMag.avg.std = mean(Freq.BodyAccMag.std),                    
            Freq.BodyAccJerkMag.avg.mean = mean(Freq.BodyAccJerkMag.mean),
            Freq.BodyAccJerkMag.avg.std = mean(Freq.BodyAccJerkMag.std),
            Freq.BodyGyroMag.avg.mean = mean(Freq.BodyGyroMag.mean),
            Freq.BodyGyroMag.avg.std = mean(Freq.BodyGyroMag.std),            
            Freq.BodyGyroJerkMag.avg.mean = mean(Freq.BodyGyroJerkMag.mean),
            Freq.BodyGyroJerkMag.avg.std = mean(Freq.BodyGyroJerkMag.std))

#output data to file 
write.table(avg_smartphone_activity, file = "avg_smartphone_activity.csv", sep = ",")
