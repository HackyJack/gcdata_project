data_zip_file_url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data_dest_file = "dataset.zip"
data_dir = "./UCI HAR Dataset"
featureInfo 	<- sprintf('%s/features_info.txt', data_dir)			#: Shows info about variables used on the feature vector.
features 		<- sprintf('%s/features.txt', data_dir)					#: List of features.
activityLabels 	<- sprintf('%s/activity_labels.txt', data_dir)		#: Links class labels with activity name.
subject_train 	<- sprintf('%s/train/subject_train.txt', data_dir)				#: Training set.
x_train 		<- sprintf('%s/train/X_train.txt', data_dir)				#: Training set.
y_train 		<- sprintf('%s/train/y_train.txt', data_dir)				#: Training labels.
subject_test 	<- sprintf('%s/test/subject_test.txt', data_dir)					#: Test set.
x_test 			<- sprintf('%s/test/X_test.txt', data_dir)					#: Test set.
y_test 			<- sprintf('%s/test/y_test.txt', data_dir)  					#: Test labels.



######################################################
#Start script
if(!file.exists(data_set_dir_name)) {
     if(!file.exists(data_dest_file)) {
          download.file(data_zip_file_url, destfile=data_dest_file, method="curl")
     }	
     unzip(data_dest_file)
}


activityLabels <- read.table(activityLabels)

fTestData <- read.table(x_test, header=FALSE)
fTrainData <- read.table(x_train, header=FALSE)

aTestData <- read.table(y_test, header=FALSE)
aTrainData <- read.table(y_train, header=FALSE)

sTestData <- read.table(subject_test, header=FALSE)
sTrainData <- read.table(subject_train, header=FALSE)


# Variable names
dataSubject <- rbind(sTrainData, sTestData)
dataActivity <- rbind(aTrainData, aTestData)
dataFeatures <- rbind(fTrainData, fTestData)

names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
#names(dataFeatures) <- features$V2
dataFeaturesNames <- read.table(features,header=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

# Merge dataFeatures
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )

Data<-subset(Data,select=selectedNames)


names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))



library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "cleandata.txt",row.name=FALSE)

