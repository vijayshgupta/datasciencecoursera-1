# set working directory
setwd("C:\\webwork\\datasciencecoursera\\cleaning_data\\project\\")

# data feature sel col
feature_sel_col <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,516,517,529,530,542,543)

# data feature sel col names
feature_sel_col_name <- c("Time.Body.Accelerometer.mean.x",
                          "Time.Body.Accelerometer.mean.y",
                          "Time.Body.Accelerometer.mean.z",
                          "Time.Body.Accelerometer.std.x",
                          "Time.Body.Accelerometer.std.y",
                          "Time.Body.Accelerometer.std.z",
                          "Time.Gravity.Accelerometer.mean.x",
                          "Time.Gravity.Accelerometer.mean.y",
                          "Time.Gravity.Accelerometer.mean.z",
                          "Time.Gravity.Accelerometer.std.x",
                          "Time.Gravity.Accelerometer.std.y",
                          "Time.Gravity.Accelerometer.std.z",
                          "Time.Body.Accelerometer.Jerk.mean.x",
                          "Time.Body.Accelerometer.Jerk.mean.y",
                          "Time.Body.Accelerometer.Jerk.mean.z",
                          "Time.Body.Accelerometer.Jerk.std.x",
                          "Time.Body.Accelerometer.Jerk.std.y",
                          "Time.Body.Accelerometer.Jerk.std.z",
                          "Time.Body.Gyroscope.mean.x",
                          "Time.Body.Gyroscope.mean.y",
                          "Time.Body.Gyroscope.mean.z",
                          "Time.Body.Gyroscope.std.x",
                          "Time.Body.Gyroscope.std.y",
                          "Time.Body.Gyroscope.std.z",                             
                          "Time.BodyGyroJerk.mean.x",
                          "Time.BodyGyroJerk.mean.y",
                          "Time.Body.Gyroscope.Jerk.mean.z",
                          "Time.Body.Gyroscope.Jerk.std.x",
                          "Time.Body.Gyroscope.Jerk.std.y",
                          "Time.Body.Gyroscope.Jerk.std.z",
                          "Time.Body.Accelerometer.Magnitude.mean",
                          "Time.Body.Accelerometer.Magnitude.std",
                          "Time.Body.Accelerometer.Jerk.Magnitude.mean",
                          "Time.Body.Accelerometer.Jerk.Magnitude.std",
                          "Time.Body.Gyroscope.Magnitude.mean",
                          "Time.Body.Gyroscope.Magnitude.std",
                          "Time.Body.Gyroscope.Jerk.Magnitude.mean",
                          "Time.Body.Gyroscope.Jerk.Magnitude.std",
                          "Freq.Body.Accelerometer.mean.x",
                          "Freq.Body.Accelerometer.mean.y",
                          "Freq.Body.Accelerometer.mean.z",
                          "Freq.Body.Accelerometer.std.x",
                          "Freq.Body.Accelerometer.std.y",
                          "Freq.Body.Accelerometer.std.z",
                          "Freq.Body.Accelerometer.Jerk.mean.x",
                          "Freq.Body.Accelerometer.Jerk.mean.y",
                          "Freq.Body.Accelerometer.Jerk.mean.z",
                          "Freq.Body.Accelerometer.Jerk.std.x",
                          "Freq.Body.Accelerometer.Jerk.std.y",
                          "Freq.Body.Accelerometer.Jerk.std.z",
                          "Freq.Body.Gyroscope.mean.x",
                          "Freq.Body.Gyroscope.mean.y",
                          "Freq.Body.Gyroscope.mean.z",
                          "Freq.Body.Gyroscope.std.x",
                          "Freq.Body.Gyroscope.std.y",
                          "Freq.Body.Gyroscope.std.z",                             
                          "Freq.Body.Accelerometer.Magnitude.mean",
                          "Freq.Body.Accelerometer.Magnitude.std",                             
                          "Freq.Body.Accelerometer.Jerk.Magnitude.mean",
                          "Freq.Body.Accelerometer.Jerk.Magnitude.std",          
                          "Freq.Body.Gyroscope.Magnitude.mean",
                          "Freq.Body.Gyroscope.Magnitude.std",          
                          "Freq.Body.Gyroscope.Jerk.Magnitude.mean",
                          "Freq.Body.Gyroscope.Jerk.Magnitude.std")

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
            Time.Body.Accelerometer.avg.mean.x=mean(Time.Body.Accelerometer.mean.x),
            Time.Body.Accelerometer.avg.mean.y=mean(Time.Body.Accelerometer.mean.y),
            Time.Body.Accelerometer.avg.mean.z=mean(Time.Body.Accelerometer.mean.z),
            Time.Body.Accelerometer.avg.std.x=mean(Time.Body.Accelerometer.std.x),
            Time.Body.Accelerometer.avg.std.y=mean(Time.Body.Accelerometer.std.y),
            Time.Body.Accelerometer.avg.std.z=mean(Time.Body.Accelerometer.std.z),
            Time.Gravity.Accelerometer.avg.mean.x=mean(Time.Gravity.Accelerometer.mean.x),
            Time.Gravity.Accelerometer.avg.mean.y=mean(Time.Gravity.Accelerometer.mean.y),
            Time.Gravity.Accelerometer.avg.mean.z=mean(Time.Gravity.Accelerometer.mean.z),
            Time.Gravity.Accelerometer.avg.std.x=mean(Time.Gravity.Accelerometer.std.x),
            Time.Gravity.Accelerometer.avg.std.y=mean(Time.Gravity.Accelerometer.std.y),
            Time.Gravity.Accelerometer.avg.std.z=mean(Time.Gravity.Accelerometer.std.z),
            Time.Body.Accelerometer.Jerk.avg.mean.x=mean(Time.Body.Accelerometer.Jerk.mean.x),
            Time.Body.Accelerometer.Jerk.avg.mean.y=mean(Time.Body.Accelerometer.Jerk.mean.y),
            Time.Body.Accelerometer.Jerk.avg.mean.z=mean(Time.Body.Accelerometer.Jerk.mean.z),
            Time.Body.Accelerometer.Jerk.avg.std.x=mean(Time.Body.Accelerometer.Jerk.std.x),
            Time.Body.Accelerometer.Jerk.avg.std.y=mean(Time.Body.Accelerometer.Jerk.std.y),
            Time.Body.Accelerometer.Jerk.avg.std.z=mean(Time.Body.Accelerometer.Jerk.std.z),                      
            Time.Body.Gyroscope.avg.mean.x=mean(Time.Body.Gyroscope.mean.x),
            Time.Body.Gyroscope.avg.mean.y=mean(Time.Body.Gyroscope.mean.y),
            Time.Body.Gyroscope.avg.mean.z=mean(Time.Body.Gyroscope.mean.z),
            Time.Body.Gyroscope.avg.std.x=mean(Time.Body.Gyroscope.std.x),
            Time.Body.Gyroscope.avg.std.y=mean(Time.Body.Gyroscope.std.y),
            Time.Body.Gyroscope.avg.std.z=mean(Time.Body.Gyroscope.std.z),               
            Time.Body.Gyroscope.Jerk.avg.mean.x=mean(Time.Body.Gyroscope.Jerk.mean.x),
            Time.Body.Gyroscope.Jerk.avg.mean.y=mean(Time.Body.Gyroscope.Jerk.mean.y),
            Time.Body.Gyroscope.Jerk.avg.mean.z=mean(Time.Body.Gyroscope.Jerk.mean.z),
            Time.Body.Gyroscope.Jerk.avg.std.x=mean(Time.Body.Gyroscope.Jerk.std.x),
            Time.Body.Gyroscope.Jerk.avg.std.y=mean(Time.Body.Gyroscope.Jerk.std.y),
            Time.Body.Gyroscope.Jerk.avg.std.z=mean(Time.Body.Gyroscope.Jerk.std.z),                                                     
            Time.Body.Accelerometer.Magnitude.avg.mean = mean(Time.Body.Accelerometer.Magnitude.mean),
            Time.Body.Accelerometer.Magnitude.avg.std = mean(Time.Body.Accelerometer.Magnitude.std),
            Time.Body.Accelerometer.Jerk.Magnitude.avg.mean = mean(Time.Body.Accelerometer.Jerk.Magnitude.mean),
            Time.Body.Accelerometer.Jerk.Magnitude.avg.std = mean(Time.Body.Accelerometer.Jerk.Magnitude.std),
            Time.Body.Gyroscope.Magnitude.avg.mean = mean(Time.Body.Gyroscope.Magnitude.mean),
            Time.Body.Gyroscope.Magnitude.avg.std = mean(Time.Body.Gyroscope.Magnitude.std),            
            Time.Body.Gyroscope.Jerk.Magnitude.avg.mean = mean(Time.Body.Gyroscope.Jerk.Magnitude.mean),
            Time.Body.Gyroscope.Jerk.Magnitude.avg.std = mean(Time.Body.Gyroscope.Jerk.Magnitude.std),
            Freq.Body.Accelerometer.avg.mean.x=mean(Freq.Body.Accelerometer.mean.x),
            Freq.Body.Accelerometer.avg.mean.y=mean(Freq.Body.Accelerometer.mean.y),
            Freq.Body.Accelerometer.avg.mean.z=mean(Freq.Body.Accelerometer.mean.z),
            Freq.Body.Accelerometer.avg.std.x=mean(Freq.Body.Accelerometer.std.x),
            Freq.Body.Accelerometer.avg.std.y=mean(Freq.Body.Accelerometer.std.y),
            Freq.Body.Accelerometer.avg.std.z=mean(Freq.Body.Accelerometer.std.z),  
            Freq.Body.Accelerometer.Jerk.avg.mean.x=mean(Freq.Body.Accelerometer.Jerk.mean.x),
            Freq.Body.Accelerometer.Jerk.avg.mean.y=mean(Freq.Body.Accelerometer.Jerk.mean.y),
            Freq.Body.Accelerometer.Jerk.avg.mean.z=mean(Freq.Body.Accelerometer.Jerk.mean.z),
            Freq.Body.Accelerometer.Jerk.avg.std.x=mean(Freq.Body.Accelerometer.Jerk.std.x),
            Freq.Body.Accelerometer.Jerk.avg.std.y=mean(Freq.Body.Accelerometer.Jerk.std.y),
            Freq.Body.Accelerometer.Jerk.avg.std.z=mean(Freq.Body.Accelerometer.Jerk.std.z),                         
            Freq.Body.Gyroscope.avg.mean.x=mean(Freq.Body.Gyroscope.mean.x),
            Freq.Body.Gyroscope.avg.mean.y=mean(Freq.Body.Gyroscope.mean.y),
            Freq.Body.Gyroscope.avg.mean.z=mean(Freq.Body.Gyroscope.mean.z),
            Freq.Body.Gyroscope.avg.std.x=mean(Freq.Body.Gyroscope.std.x),
            Freq.Body.Gyroscope.avg.std.y=mean(Freq.Body.Gyroscope.std.y),
            Freq.Body.Gyroscope.avg.std.z=mean(Freq.Body.Gyroscope.std.z),    
            Freq.Body.Accelerometer.Magnitude.avg.mean = mean(Freq.Body.Accelerometer.Magnitude.mean),
            Freq.Body.Accelerometer.Magnitude.avg.std = mean(Freq.Body.Accelerometer.Magnitude.std),                    
            Freq.Body.Accelerometer.Jerk.Magnitude.avg.mean = mean(Freq.Body.Accelerometer.Jerk.Magnitude.mean),
            Freq.Body.Accelerometer.Jerk.Magnitude.avg.std = mean(Freq.Body.Accelerometer.Jerk.Magnitude.std),
            Freq.Body.Gyroscope.Magnitude.avg.mean = mean(Freq.Body.Gyroscope.Magnitude.mean),
            Freq.Body.Gyroscope.Magnitude.avg.std = mean(Freq.Body.Gyroscope.Magnitude.std),            
            Freq.Body.Gyroscope.Jerk.Magnitude.avg.mean = mean(Freq.Body.Gyroscope.Jerk.Magnitude.mean),
            Freq.Body.Gyroscope.Jerk.Magnitude.avg.std = mean(Freq.Body.Gyroscope.Jerk.Magnitude.std))

#output data to file 
write.table(avg_smartphone_activity, file = "avg_smartphone_activity.csv", sep = ",")
