library(rpart)
library(rpart.plot)
library(ggplot2)
library(dplyr)

iris2 <- iris[c("Sepal.Length", "Petal.Length", "Species")] %>% 
  mutate(Species = Species == "setosa")
  

ggplot(iris2, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point()

# wytrenuj predyktor rpart przewidujący kolumnę Species
