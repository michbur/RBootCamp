x <- c("MYGGP", "GGGHMIL")
splitted_x <- strsplit(x, "")
lapply(splitted_x, function(i) table(factor(i, levels = c("A", "C", "D", "E", "F", "G", 
                                                          "H", "I", "K", "L", "M", "N", 
                                                          "P", "Q", "R", "S", "T", "V", "W", "Y"))))

res <- lapply(splitted_x <- strsplit(x, ""), function(i) table(factor(i, levels = c("A", "C", "D", "E", "F", "G", 
                                                          "H", "I", "K", "L", "M", "N", 
                                                          "P", "Q", "R", "S", "T", "V", "W", "Y"))))

library(dplyr)

x %>% 
  strsplit("") %>% 
  lapply(function(i) factor(i, levels = c("A", "C", "D", "E", "F", "G", 
                                          "H", "I", "K", "L", "M", "N", 
                                          "P", "Q", "R", "S", "T", "V", "W", "Y")) %>% 
           table)
