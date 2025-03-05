# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

add_two <- function(x) {
  x + 2
}

add_two(3)
add_two(10)

# function: scrape_page --------------------------------------------------------

scrape_page <- function(url){
  
  # read page
  page <- read_html(url)
  
  # scrape titles
  titles <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_text() %>%
    str_squish()
  
  # scrape links
  links <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_attr("href") %>% 
    str_replace("\\.", "https://collections.ed.ac.uk/art")
  
  # scrape artists 
  artists <- page %>%
    html_nodes(".iteminfo") %>%
    html_node(".artist") %>%
    html_text() %>% 
    str_squish()
  
  # create and return tibble
  tibble(
    title = titles,
    artist = artists,
    link = links
  )
  
}
scrape_page("https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22")
#The output looks right.