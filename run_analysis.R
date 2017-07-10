# set up working directory
  setwd("C:/Users/rr5743/Projects/2017/Data Science/Data cleaning/Wk4")

#include library dplyr
  library(dplyr)
  
# read files for each dataset
  features <- read.table("features.txt")
  activity <- read.table("activity_labels.txt")
  names(activity) <- c("activity","activityname")
  
  subject_test <- read.table("subject_test.txt")
    names(subject_test) <- c("subject")
  measure_test <- read.table("X_test.txt")
    names(measure_test) <- paste(features$V1,features$V2)
  activity_test <- read.table("y_test.txt")
    names(activity_test) <- c("activity")
  
  subject_train <- read.table("subject_train.txt")
    names(subject_train) <- c("subject")
  measure_train <- read.table("X_train.txt")
    names(measure_train) <- paste(features$V1,features$V2)
  activity_train <- read.table("y_train.txt")
    names(activity_train) <- c("activity")

#select mean and std
  measure_test_mean <- select(measure_test, contains("mean()"))
  measure_test_std <- select(measure_test, contains("std()"))
  measure_train_mean <- select(measure_train, contains("mean()"))
  measure_train_std <- select(measure_train, contains("std()"))

# merging datasets
  # merge test data sets
  data_test <- cbind(subject_test,activity_test,measure_test_mean,measure_test_std)
  data_train <- cbind(subject_train,activity_train,measure_train_mean,measure_train_std)
  data <- rbind(data_test,data_train)
  
  data1 <- merge(data,activity,by="activity")
  data2 <- subset(data1,select=-c(activity))
  
# create summaries  
  by_sub_act <- group_by(data2,subject,activityname)
  data3 <- aggregate(data2[,2:67],list(data2$subject,data2$activityname),  mean) 
  