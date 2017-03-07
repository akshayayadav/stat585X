library(tidyverse)
ddply(french_fries,.(subject),summarise,potato=mean(potato))
french_fries %>% filter(subject==3) %>% select(subject,potato) %>% summarise(potato.mean=mean(potato))

french_fries %>% filter(subject==3) %>% select(subject,potato) %>% mutate(potato.mean=mean(potato))

reps <- french_fries %>% group_by(time, subject, treatment) %>% summarise(potato_diff = diff(potato),potato = mean(potato))