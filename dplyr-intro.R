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

# dplyr examples

cbind(iris, sepal_square = iris[["Sepal.Length"]]^2)

mutate(iris, sepal_square = Sepal.Length^2)

group_by(iris, Species) %>% 
  summarise(n_species = length(Species))

norm01 <- function(x)
  (x - min(x))/(max(x) - min(x))

group_by(iris, Species) %>% 
  mutate(norm_petal_length = norm01(Petal.Length))

mutate(iris, norm_petal_length = norm01(Petal.Length))

group_by(iris, Species) %>% 
  mutate(norm_petal_length = norm01(Petal.Length)) %>% 
  summarise(mnpl = mean(norm_petal_length)) %>% 
  pull(mnpl)

group_by(iris, Species) %>% 
  filter(Species != "virginica") %>% 
  mutate(norm_petal_length = norm01(Petal.Length)) %>% 
  summarise(mnpl = mean(norm_petal_length)) %>% 
  select(mnpl)

