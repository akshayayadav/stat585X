library(tidyverse)
temps <- read_fwf("ushcn.v2.5.5.20170118/USH00132999.raw.tmax",
                  col_positions = fwf_positions(
                    start=c( 1,13, rep(16+9*0:11, each=4) + c(1,7,8,9)), 
                    end  =c(11,16, rep(16+9*0:11, each=4) + c(6,7,8,9))))
names(temps) <- c("Station", "Year", 
                  paste0(rep(c("Value","DMflag", "QCflag", "DSflag"), 12), 
                         rep(1:12, each=4)))

FortDodge <- temps %>% 
  gather(key="Month", value="Temp_Max", starts_with("Value"))
FortDodge$Month <- as.numeric(gsub("Value", "", FortDodge$Month))
FortDodge$Temp_Max <- replace(FortDodge$Temp_Max, 
                              FortDodge$Temp_Max == -9999, NA)

FortDodge %>% ggplot(aes(x = Year, Temp_Max/100)) + 
  geom_point() + facet_wrap(~Month, nrow=2) 