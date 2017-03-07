library("tidyverse")
setwd("/home/akshay/courses/stat585X/week3_4")
weather_data<-readRDS("../materials/data/temps.rds")
station_data<-subset(weather_data,Station=="USH00011084")
ggplot(subset(weather_data,Station %in% c("USH00011084","USH00017304")), aes(x = Year+Month/12, Temp/100,group=Station)) + geom_line(aes(color=Station))+xlim(c(2011,2016))

ggplot(subset(weather_data,Station %in% c("USH00011084","USH00017304")), aes(x = Year+Month/12, Temp/100,group=Station)) + geom_line(aes(color=Station)) + geom_text(data=weather_data %>% filter(Year == 1999, Month==7,Station %in% c("USH00011084","USH00017304")),aes(label=Station),hjust=0)+xlim(c(1950,2000))


