library(mlr)
library(mlrMBO)

set.seed(15390)
ml_dat <- data.frame(et = c(rep(TRUE, 200), rep(FALSE, 200)),
                     x1 = c(rnorm(200, sd = 2), rnorm(200)),
                     x2 = c(rnorm(200)^2 + 0.1, rnorm(200)))

library(ggplot2)
ggplot(ml_dat, aes(x = x1, y = x2, color = et)) +
  geom_point() +
  theme_bw()

task <- makeClassifTask("example1", data = ml_dat, target = "et")
svm <- makeLearner("classif.ksvm", predict.type = "prob", kernel = "rbfdot")

svm_pars <- makeParamSet(
  makeNumericParam("C", -15, 15, trafo = function(x) 2^x),
  makeNumericParam("sigma", -15, 15, trafo = function(x) 2^x)
)

grid_res <- tuneParams(svm, task, cv3, par.set = svm_pars, 
                       control = makeTuneControlGrid(resolution = 5L), 
                       measures = auc)

p <- ggplot(generateHyperParsEffectData(grid_res)[["data"]], 
            aes(x = C, y = sigma, fill = auc.test.mean)) +
  geom_tile(color = "black") +
  scale_fill_gradient("AUC", low = "red", high = "blue") +
  theme_bw()

p

mbo_ctrl <- makeTuneControlMBO(mbo.control = setMBOControlTermination(makeMBOControl(), iters = 20))

mbo_res <- tuneParams(svm, task, cv3, par.set = svm_pars, 
                      control = mbo_ctrl, measures = auc)


p + geom_point(data = generateHyperParsEffectData(mbo_res)[["data"]],
               aes(x = C, y = sigma),inherit.aes = FALSE)

library(dplyr)

arrange(generateHyperParsEffectData(mbo_res)[["data"]], desc(auc.test.mean)) %>% 
  slice(1L:5)

arrange(generateHyperParsEffectData(grid_res)[["data"]], desc(auc.test.mean)) %>% 
  slice(1L:5)

#

load("./mbo-intro-data/very_small_grid_res.RData")

arrange(generateHyperParsEffectData(very_small_grid_res)[["data"]], desc(auc.test.mean)) %>% 
  slice(1L:5)

ggplot(generateHyperParsEffectData(very_small_grid_res)[["data"]], 
       aes(x = C, y = sigma, fill = auc.test.mean)) +
  geom_tile() +
  geom_point(data = generateHyperParsEffectData(mbo_res)[["data"]],
               aes(x = C, y = sigma),inherit.aes = FALSE) +
  scale_fill_gradient("AUC", low = "red", high = "blue") +
  theme_bw()

