library(dplyr)
movies <- read.csv("../materials/data/movies.csv")

#success according to Gross Earning per week
movies %>% group_by(Movie) %>% summarise(mean.Gross=mean(Gross)) %>% arrange(desc(mean.Gross))


movies %>% group_by(Movie) %>% mutate(week.count=n(),sum.Rank=(sum(Rank))) %>% mutate(mean.Rank=(sum.Rank/week.count)) %>% group_by(Movie) %>% summarise(mean.Rank=mean(mean.Rank)) %>% arrange(mean.Rank)


movies %>% group_by(Movie) %>% filter(Rank<=10) %>% summarize(nweeks=n()) %>% arrange(desc(nweeks))
movies %>% group_by(Movie) %>% filter(Rank<=5) %>% summarize(nweeks=n()) %>% arrange(desc(nweeks))