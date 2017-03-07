library(tidyverse)
box <- read.csv("../materials/data/boxoffice.csv")
box <- box %>% mutate(
  Gross = parse_number(Gross),
  Total.Gross = parse_number(Total.Gross),
  Days = parse_number(Days),
  Thtrs. = parse_number(Thtrs.)
) 
