X_test<-read.table("~/UCI HAR Dataset/test/X_test.txt")


Y_test<-read.table("~/UCI HAR Dataset/test/Y_test.txt")

subject_test<-read.table("~/UCI HAR Dataset/test/subject_test.txt")

features<-read.table("~/UCI HAR Dataset/features.txt")

activity_labels<-read.table("~/UCI HAR Dataset/activity_labels.txt")


X_train<-read.table("~/UCI HAR Dataset/train/X_train.txt")


Y_train<-read.table("~/UCI HAR Dataset/train/Y_train.txt")

subject_train<-read.table("~/UCI HAR Dataset/train/subject_train.txt")


names(X_test)<-features$V2
names(X_train)<-features$V2


X_test<-cbind(X_test,subject_test)

X_train<-cbind(X_train,subject_train)


names(X_test)[562]<-"subject"

names(X_train)[562]<-"subject"

X_test<-cbind(X_test,Y_test)

X_train<-cbind(X_train,Y_train)


names(X_test)[563]<-"activity"

names(X_train)[563]<-"activity"

X<-rbind(X_train,X_test)

XS<-X[,c(grep(c("mean"),features$V2),grep(c("std"),features$V2),562,563)]

XSD<-merge(activity_labels, XS,by.x = "V1",by.y="activity")

names(XSD)[2]<-"activity"

XSD[,1]<-NULL #drop col


library("reshape2")

XMelt<-melt(XSD,id = c("activity","subject"))


Final<-dcast(XMelt, subject+activity ~variable, mean)

write.table(Final,file="DataSet.txt",row.name=FALSE)
