library(tidyverse)
library(ggplot2)
setwd("/home/akshay/courses/stat585X/assignment3")

get_unique_values<-function(x){
  u_len<-length(unique(x[!is.na(x)]))
  if(u_len==0){
    return("NA")
  }else if(u_len==2){
    return(paste(unique(x[!is.na(x)]),collapse=","))
  } else {
    return(unique(x[!is.na(x)]))
  }
}

read_exam_data <- function(file="Spreadsheets/FileOne.xlsx", sem=1, exam=1){
score_table<-readxl::read_excel(path=file, sheet=sem)
names(score_table)[1]<-"id"
names(score_table)[2]<-"scoretype"
colnames(score_table) <- tolower(colnames(score_table))
score_table <- score_table %>% select(id, scoretype, starts_with("gen"), 
                  starts_with("treatme"),
                  starts_with("charac"),
                  starts_with("tot"), 
                  starts_with("norm"))

names(score_table)<- c("id", "scoretype", "gender", 
                    "treat1", "treat2",
                    "characteristic",
                    "total","normchange")

uval_table<-score_table %>% group_by(id) %>% 
  select(id,normchange,gender,treat1,treat2,characteristic) %>% 
  summarise(gender=get_unique_values(unique(gender[!is.na(gender)])),
            normchange=get_unique_values(unique(normchange[!is.na(normchange)])),
            characteristic=get_unique_values(unique(characteristic[!is.na(characteristic)])),
            treat1=get_unique_values(unique(treat1[!is.na(treat1)])),
            treat2=get_unique_values(unique(treat2[!is.na(treat2)])))


nuval_table<-score_table %>% select(id,scoretype,total)
new_score_table<-full_join(uval_table,nuval_table,by="id")
new_score_table$semester<-rep(sem,dim(new_score_table)[1])
new_score_table$exam<-rep(exam,dim(new_score_table)[1])

return(new_score_table)
}

master_table<-read_exam_data(file="Spreadsheets/FileOne.xlsx", sem=1, exam=1)
master_table<-rbind(master_table,read_exam_data(file="Spreadsheets/FileOne.xlsx", sem=2, exam=1))
master_table<-rbind(master_table,read_exam_data(file="Spreadsheets/FileOne.xlsx", sem=3, exam=1))
master_table<-rbind(master_table,read_exam_data(file="Spreadsheets/FileOne.xlsx", sem=4, exam=1))

master_table<-rbind(master_table,read_exam_data(file="Spreadsheets/FileTwo.xlsx", sem=1, exam=2))
master_table<-rbind(master_table,read_exam_data(file="Spreadsheets/FileTwo.xlsx", sem=2, exam=2))
master_table<-rbind(master_table,read_exam_data(file="Spreadsheets/FileTwo.xlsx", sem=3, exam=2))
master_table<-rbind(master_table,read_exam_data(file="Spreadsheets/FileTwo.xlsx", sem=4, exam=2))

master_table<-data.frame(lapply(master_table, function(v) {
  if (is.character(v)) return(tolower(v))
  else return(v)
}))

master_table$gender<-as.factor(master_table$gender)
master_table$semester<-as.factor(master_table$semester)
master_table$exam<-as.factor(master_table$exam)

master_table %>% spread(scoretype,total) %>% 
  ggplot(aes(x = pre, y = post,color=exam)) + 
  geom_point(aes(shape=gender)) + 
  facet_wrap(~semester)



