##Bottom-To-Top Approach
<br><br>
Explaining the execution file:- <br>
<code>source("~/get-data/project/run_analysis.R")</code><br>
My in-built directory is located here:-
```R
> getwd()
[1] "C:/Users/dell/Documents"
```
I kept the project work inside <code>get-data/project</code> location. <br>
So, it happened to run as,
```R
> source("~/get-data/project/run_analysis.R")
```
Main files found here:
```
1. run_analysis.R
2. 1_clean_data.txt
3. 2_independent_tidy_dataset.txt
Then, the dataset folder that have been downloaded for training and testing sets.
Finally, a "codebook.md" that explains it.
```
For writing the <code>run_analysis.R</code>, some steps have been followed:-
```
Step 1: Merges the training and the test sets to create one data set.
Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
Step 3: Uses descriptive activity names to name the activities in the data set
Step 4: Appropriately labels the data set with descriptive variable names. 
Step 5: From the data set in step 4, create independent tidy data set with the average of each variable for each activity and each subject.
```
<b>To access the CODEBOOK ---> <a href="https://github.com/ashumeow/get-data/blob/master/project/codebook.md">CLICK HERE!</a></b>
