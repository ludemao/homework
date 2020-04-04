The R script can be accessed --> <a href="https://github.com/ashumeow/get-data/blob/master/project/run_analysis.R">Here!</a>
```
In this codebook, it explains:-
1. How run_analysis.R is written?
2. How data are merged into a clean dataset?
3. How an independent tidy dataset is created from the clean dataset?
```
```
Step 1: Merges the training and the test sets to create one data set.
```
```R
## reading the data
## training and testing
ig1 <- read.table("~/get-data/project/UCI-HAR-DATASET/train/X_train.txt")
ig2 <- read.table("~/get-data/project/UCI-HAR-DATASET/test/X_test.txt")
## row binding ig1 and ig2
hello_ig1 <- rbind(ig1, ig2)
## reading table
## training and testing
ig3 <- read.table("~/get-data/project/UCI-HAR-DATASET/train/subject_train.txt")
ig4 <- read.table("~/get-data/project/UCI-HAR-DATASET/test/subject_test.txt")
## row binding ig3 and ig4
hello_ig2 <- rbind(ig3, ig4)
## reading table
## training and testing
ig5 <- read.table("~/get-data/project/UCI-HAR-DATASET/train/y_train.txt")
ig6 <- read.table("~/get-data/project/UCI-HAR-DATASET/test/y_test.txt")
## row binding ig5 and ig6
hello_ig3 <- rbind(ig5, ig6)
```
```
Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
```
```R
## reading
features <- read.table("~/get-data/project/UCI-HAR-DATASET/features.txt")
## grep -- finding values
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
hello_ig1 <- hello_ig1[, indices_of_good_features]
names(hello_ig1) <- features[indices_of_good_features, 2]
## gsub -- fixing character vectors
names(hello_ig1) <- gsub("\\(|\\)", "", names(hello_ig1))
## tolower -- editing text variables
names(hello_ig1) <- tolower(names(hello_ig1))
```
```
Step 3: Uses descriptive activity names to name the activities in the data set
```
```R
## reading activity table
activities <- read.table("~/get-data/project/UCI-HAR-DATASET/activity_labels.txt")
## gsub -- fixing character vectors
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
hello_ig3[,1] = activities[hello_ig3[,1], 2]
names(hello_ig3) <- "activity"
```
```
Step 4: Appropriately labels the data set with descriptive variable names. 
```
```R
names(hello_ig2) <- "subject"
## column binding
cleaned <- cbind(hello_ig2, hello_ig3, hello_ig1)
## Finally, a clean dataset! (^_^)
write.table(cleaned, "~/get-data/project/1_clean_data.txt")
```
The dataset <code>1_clean_data.txt</code> can be found --> <a href="https://github.com/ashumeow/get-data/tree/master/project">Here!</a>
```
Step 5: From the data set in step 4, create independent tidy data set with the average of each variable for each activity and each subject.
```
```R
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
## Finally, an independent tidy dataset has been created (^_^)
write.table(result, "~/get-data/project/2_independent_tidy_dataset.txt")
```
The <code>2_independent_tidy_dataset.txt</code> can be accessed --> <a href="https://github.com/ashumeow/get-data/tree/master/project">Here!</a>
