library(ggplot2)
library(dplyr)

msleep
lapply(msleep, function(i) sum(is.na(i)))

set.seed(1)
library(ggbeeswarm)
ggplot(msleep, aes(x = vore, y = sleep_total)) +
  geom_quasirandom()

ggplot(msleep, aes(x = vore)) +
  geom_bar()

msleep_counted <- msleep %>% 
  group_by(vore) %>% 
  summarise(n = length(vore))
