library(tidyverse)
temps <- read_fwf("ushcn-v2.5-stations.txt",col_positions = fwf_positions(
                    start=c(1,3,4,6,13,22,33,39,42,73,80,87,94), 
                    end  =c(2,3,5,11,20,30,37,40,71,78,85,92,95)))
names(temps) <- c("COUNTRY", "NETWORK","ID","COOP_ID","LATITUDE","LONGITUDE","ELEVATION","STATE","NAME","COMP1","COMP2","COMP3","UTC_OFF") 
temps%>% ggplot(aes(x = LONGITUDE, LATITUDE)) + geom_point() 