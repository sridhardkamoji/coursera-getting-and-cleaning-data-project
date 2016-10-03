# Reading Train Data

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/Y_train.txt")
subject_train <- read.table("train/subject_train.txt")

# Reading Test Data

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/Y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# combining the test and train data

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
mean_and_std <- grep("-(mean|std)\\(\\)", features[,2])
x_data <- x_data[ , mean_and_std]
names(x_data) <- features[mean_and_std, 2]

# Naming the Activities in the data set

activity <- read.table("activity_labels.txt")
y_data[,1] <- activity[y_data[,1], 2]
names(y_data) <- "activity"
names(subject_data) <- "subject"

# Combining the entire data set

all_data <- cbind(x_data, y_data, subject_data)

# Calculating the averages of each columns from the all_data data set

library(plyr)
avg <- ddply(all_data, .(subject, activity), function(x) colMeans(x[ , 1:66]))
write.table(avg, "averages_data.txt", row.name = FALSE)
