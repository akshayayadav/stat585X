brfss_iowa<-read.csv("brfss_iowa.csv",header=T, na.strings="NA")
brfss_iowa_w_h<-data.frame(weight=brfss_iowa$WEIGHT2,height=brfss_iowa$HEIGHT3)
brfss_iowa_w_h_clean<-na.omit(brfss_iowa_w_h)
brfss_iowa_w_h_clean<-subset(brfss_iowa_w_h_clean,weight!=7777 & weight!=9999)
brfss_iowa_w_h_clean<-subset(brfss_iowa_w_h_clean,height!=7777 & height!=9999)
brfss_iowa_w_h_clean$weight[brfss_iowa_w_h_clean$weight<=999]<-brfss_iowa_w_h_clean$weight[brfss_iowa_w_h_clean$weight<=999]*0.453

brfss_iowa_w_h_clean$weight[brfss_iowa_w_h_clean$weight>=9000]<-brfss_iowa_w_h_clean$weight[brfss_iowa_w_h_clean$weight>=9000]-9000

brfss_iowa_w_h_clean$height[brfss_iowa_w_h_clean$height<=711]<-(brfss_iowa_w_h_clean$height[brfss_iowa_w_h_clean$height<=711]%/%100)*30.48+(brfss_iowa_w_h_clean$height[brfss_iowa_w_h_clean$height<=711]%%100)*2.54

brfss_iowa_w_h_clean$height[brfss_iowa_w_h_clean$height>=9000]<-(brfss_iowa_w_h_clean$height[brfss_iowa_w_h_clean$height>=9000]-9000)