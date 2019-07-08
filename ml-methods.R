library(rpart)
library(rpart.plot)
library(ggplot2)
library(dplyr)

iris2 <- iris[c("Sepal.Length", "Petal.Length", "Species")] %>% 
  mutate(Species = Species == "setosa")
  

ggplot(iris2, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point()

# wytrenuj predyktor rpart przewidujący kolumnę Species

#wytrenuj predyktor oparty na lasach losowych z pakietu ranger

set.seed(15390)
ml_dat <- data.frame(et = c(rep(TRUE, 100), rep(FALSE, 100)),
                     x1 = c(rnorm(100) + 0.74*2, rnorm(100)),
                     x2 = c(rnorm(100) + 0.74*2, rnorm(100)))
                     
ggplot(ml_dat, aes(x = x1, y = x2, color = et)) +
  geom_point()

library(mlr)
task <- makeClassifTask("example1", data = ml_dat, target = "et")

tree <- makeLearner("classif.rpart", predict.type = "prob")
rf <- makeLearner("classif.ranger", predict.type = "prob")
svm <- makeLearner("classif.ksvm", predict.type = "prob")

benchmark(list(tree, rf, svm), tasks = task, resamplings = makeResampleDesc("CV", iters = 3L),
          measures = list(auc))


