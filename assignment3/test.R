#tidy_table<- score_table%>%gather(key=ValType,value=Measurement,3:18)


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




score_table<-readxl::read_excel("Spreadsheets/FileOne.xlsx", sheet=2)
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
new_score_table$semester<-rep(1,dim(new_score_table)[1])
new_score_table$exam<-rep(1,dim(new_score_table)[1])
