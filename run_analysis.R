# step 1
# Merging of training and test sets for creating one dataset
ig1 <- read.table("~/get-data/project/UCI-HAR-DATASET/train/X_train.txt")
ig2 <- read.table("~/get-data/project/UCI-HAR-DATASET/test/X_test.txt")
hello_ig1 <- rbind(ig1, ig2)
ig3 <- read.table("~/get-data/project/UCI-HAR-DATASET/train/subject_train.txt")
ig4 <- read.table("~/get-data/project/UCI-HAR-DATASET/test/subject_test.txt")
hello_ig2 <- rbind(ig3, ig4)
ig5 <- read.table("~/get-data/project/UCI-HAR-DATASET/train/y_train.txt")
ig6 <- read.table("~/get-data/project/UCI-HAR-DATASET/test/y_test.txt")
hello_ig3 <- rbind(ig5, ig6)

# step 2
# Extraction of mean and Standard Deviation (S.D.) for each measurement
features <- read.table("~/get-data/project/UCI-HAR-DATASET/features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
hello_ig1 <- hello_ig1[, indices_of_good_features]
names(hello_ig1) <- features[indices_of_good_features, 2]
names(hello_ig1) <- gsub("\\(|\\)", "", names(hello_ig1))
names(hello_ig1) <- tolower(names(hello_ig1))

# step 3
# Naming the activities in the data set using the descriptive activity
activities <- read.table("~/get-data/project/UCI-HAR-DATASET/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
hello_ig3[,1] = activities[hello_ig3[,1], 2]
names(hello_ig3) <- "activity"

# step 4
# creating first dataset on merging clean data
# Labelling the dataset with descriptive activity names
names(hello_ig2) <- "subject"
cleaned <- cbind(hello_ig2, hello_ig3, hello_ig1)
write.table(cleaned, "~/get-data/project/1_clean_data.txt")

# step 5 --- (derived from step 4)
# Creating another tidy dataset
# creating second independent tidy dataset
## It has average of each variable for each activity and each subject
uniqueSubjects = unique(hello_ig2)[,1]
numSubjects = length(unique(hello_ig2)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]
row = 1
for (ig in 1:numSubjects) {
  for (ig_x in 1:numActivities) {
    result[row, 1] = uniqueSubjects[ig]
    result[row, 2] = activities[ig_x, 2]
    tmp <- cleaned[cleaned$subject==ig & cleaned$activity==activities[ig_x, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "~/get-data/project/2_independent_tidy_dataset.txt")
