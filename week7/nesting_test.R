library(gapminder)
library(tidyverse)
library(broom)
library(purrr)
library(ggplot2)

gapminder2 <- gapminder %>% mutate(year = year-1950)
countryList <- gapminder2 %>% nest(-country, -continent) 

myfit <- function (dframe) {
  lm(lifeExp ~ year, data = dframe)
}

countryList <- countryList %>% mutate(
  model = purrr::map(data, myfit)
)

countryList <- countryList %>% mutate(
  model.stats = model %>% purrr::map(.f=broom::glance)
)

rsquares<-countryList %>% select (country,continent,model.stats) %>% unnest() 

rsquares %>% ggplot(aes(x=country,y=r.squared))