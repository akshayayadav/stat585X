library(rvest)
url <- "http://www.baseball-reference.com/players/a/"
html <- read_html(url)
html %>% html_nodes("b a") %>% html_text()
html %>% html_nodes("b a") %>% html_attr(name="href")