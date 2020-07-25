library(dplyr)

#reading files of training and test data sets for X,y, subject
X_train<- read.table("X_train.txt")
X_test<- read.table("X_test.txt")
y_train<- read.table("y_train.txt")
y_test<- read.table("y_test.txt")
subject_train<- read.table("subject_train.txt")
subject_test<- read.table("subject_test.txt")

#merging the two data sets for each variable by row binding train and test of each component 
X<- rbind(X_train,X_test)
y<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)

#naming y, subject components of the data set
names(y)<- c("label")
names(subject)<- c("subject_id")

#reading the names of the X variables and extracting only the variables that has the mean and standard deviation 
X_names<-readLines("features.txt")
names(X)<- X_names
X_new1<- X[,grep("mean()",X_names, fixed = TRUE)] #extracting variables of mean
X_new2<- X[,grep("std()",X_names, fixed = TRUE)]  #extracting variables of std
X_new<- cbind(X_new1,X_new2) #binding the mean and std 

#reading the activity labels
y_names<-readLines("activity_labels.txt")

#splitting the activity labels to remove the number at the beginning
for (i in 1:length(y_names)) {y_names[i]<- substr(y_names[i],3,nchar(y_names[i]))}

#creating a data frame for the activity label and name
y_names<- as.data.frame(cbind(c(1,2,3,4,5,6),y_names))
names(y_names)<- c("Id","Activity")

#for each observation in y, the corresponding activity label is obtained
for (i in 1:nrow(y)) {y$activity[i]<- y_names$Activity[y$label[i]]}

#all the data sets are merged into one data set
data_set <- cbind(subject,X_new,y)

#the variable names are parsed to remove the numbers from the beginning to create a descriptive variable name as per requirement 4 in the assignment requirements
var_names<- as.array(names(data_set))
for (i in 2:length(var_names[2:68])) {var_names[i]<- unlist(strsplit(var_names[i]," "))[2]}
names(data_set) <- var_names

#the averages of each variable for each activity and each subject --> 30 subjects * 6 activities = 180 rows 
by_subject_activity <- data_set %>% group_by(subject_id,activity) %>% summarise_all(list(mean))

