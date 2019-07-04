library(ggplot2)
library(dplyr)

msleep
lapply(msleep, function(i) sum(is.na(i)))

set.seed(1)
library(ggbeeswarm)
ggplot(msleep, aes(x = vore, y = sleep_total)) +
  geom_quasirandom()

ggplot(msleep, aes(x = vore)) +
  geom_bar(stat = "count")

msleep_counted <- msleep %>% 
  group_by(vore) %>% 
  summarise(n = length(vore))

ggplot(msleep_counted, aes(x = vore, y = n)) +
  geom_bar(stat = "identity")

# stat a dodawanie nowych geometrii
ggplot(msleep_counted, aes(x = vore, y = n, label = n)) +
  geom_bar(stat = "identity") +
  geom_text(color = "white", vjust = 1)

ggplot(msleep, aes(x = vore, label = ..count..)) +
  geom_bar(stat = "count") +
  geom_text(stat = "count", color = "white", vjust = 1)

ggplot(msleep, aes(x = sleep_total, y = bodywt)) +
  geom_point()

ggplot(msleep, aes(x = sleep_total, y = log(bodywt))) +
  geom_point()

ggplot(msleep, aes(x = sleep_total, y = bodywt)) +
  geom_point() +
  scale_y_log10()

ggplot(msleep, aes(x = sleep_total, y = bodywt, color = vore)) +
  geom_point() +
  scale_y_log10()

ggplot(msleep, aes(x = sleep_total, y = bodywt, fill = vore, alpha = ..level..)) +
  stat_density2d(geom = "polygon", color = "black", contour = TRUE) +
  scale_y_log10()

ggplot(msleep, aes(x = sleep_total, y = bodywt, fill = vore)) +
  stat_bin_2d() +
  scale_y_log10()

ggplot(msleep, aes(x = sleep_total, y = bodywt, fill = vore)) +
  stat_bin_hex() +
  scale_y_log10()

ggplot(msleep, aes(x = sleep_total, y = bodywt)) +
  geom_point() +
  geom_smooth() +
  scale_y_log10()

ggplot(filter(msleep, vore != "insecti"), aes(x = sleep_total, y = bodywt, color = vore)) +
  geom_point() +
  geom_smooth() +
  scale_y_log10()

ggplot(filter(msleep, vore != "insecti"), aes(x = sleep_total, y = bodywt, color = vore)) +
  geom_point() +
  geom_smooth() +
  scale_y_log10() +
  facet_wrap(~ vore)

ggplot(filter(msleep, vore != "insecti"), aes(x = sleep_total, y = bodywt, color = vore)) +
  geom_point() +
  geom_smooth() +
  scale_y_log10() +
  facet_wrap(~ vore, scales = "free_y")

ggplot(filter(msleep, vore != "insecti"), aes(x = sleep_total, y = bodywt, color = vore)) +
  geom_point() +
  geom_smooth() +
  scale_y_log10() +
  facet_wrap(~ vore, scales = "free_x")

ggplot(filter(msleep, vore != "insecti"), aes(x = sleep_total, y = bodywt, color = vore)) +
  geom_point() +
  geom_smooth() +
  scale_y_log10() +
  facet_wrap(~ vore, scales = "free")

ggplot(msleep, aes(x = vore)) +
  geom_bar() +
  facet_wrap(~ order)

ggplot(msleep, aes(x = sleep_total)) +
  geom_histogram()

ggplot(msleep, aes(x = sleep_total)) +
  geom_density() 

ggplot(msleep, aes(x = sleep_total, fill = vore)) +
  geom_density(alpha = 0.2)

ggplot(msleep, aes(x = sleep_total, fill = vore)) +
  geom_density() +
  facet_wrap(~ vore, ncol = 1)

# devtools::install_github("thomasp85/patchwork")
# http://www.gersonides.com/static/images/scat.png
# ggplot(msleep, aes(x = sleep_total, y = bodywt)) 
# wykresy gestosci sleep_total i bodywt, zaznaczone kolorem vore
