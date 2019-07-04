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

p_main <- ggplot(msleep, aes(x = sleep_total, y = bodywt, color = vore)) +
  geom_point() +
  scale_y_log10()

p_dens_sleep <- ggplot(msleep, aes(x = sleep_total, fill = vore)) +
  geom_density(alpha = 0.2) +
  scale_x_continuous("")

p_dens_bodywt <- ggplot(msleep, aes(x = bodywt, fill = vore)) +
  geom_density(alpha = 0.2) +
  scale_x_log10("") +
  coord_flip()

get_legend <- function(gg_plot) {
  grob_table <- ggplotGrob(gg_plot)
  # gtable from gtable package
  # names(grob_table[["grobs"]]) does not work!
  grob_table[["grobs"]][[which(sapply(grob_table[["grobs"]], function(x) x[["name"]]) == "guide-box")]]
}

library(patchwork)
p <- (p_dens_sleep + get_legend(p_dens_sleep) + 
    p_main + p_dens_bodywt) * theme_bw() * theme(legend.position = "none") + 
    plot_layout(ncol = 2, nrow = 2, heights = c(0.3, 0.7), widths = c(0.7, 0.3))
  
png("plot1.png")
p
dev.off()

cairo_ps("plot1.eps")
p
dev.off()

