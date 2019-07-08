#https://blogs.rstudio.com/tensorflow/posts/2018-01-29-dl-for-cancer-immunotherapy/
 
pep_dat <- read_tsv(file = "https://raw.githubusercontent.com/leonjessen/tensorflow_rstudio_example/master/data/ran_peps_netMHCpan40_predicted_A0201_reduced_cleaned_balanced.tsv")

pep_dat %>% filter(label_chr=='SB') %>% pull(peptide) %>% ggseqlogo()

pep_dat %>% filter(label_chr=='SB') %>% head(1) %>% pull(peptide) %>% pep_plot_images

x_train <- pep_dat %>% filter(data_type == 'train') %>% pull(peptide)   %>% pep_encode
y_train <- pep_dat %>% filter(data_type == 'train') %>% pull(label_num) %>% array
x_test  <- pep_dat %>% filter(data_type == 'test')  %>% pull(peptide)   %>% pep_encode
y_test  <- pep_dat %>% filter(data_type == 'test')  %>% pull(label_num) %>% array

x_train <- array_reshape(x_train, c(nrow(x_train), 9 * 20))
x_test  <- array_reshape(x_test,  c(nrow(x_test), 9 * 20))

y_train <- to_categorical(y_train, num_classes = 3)
y_test  <- to_categorical(y_test,  num_classes = 3)

model <- keras_model_sequential() %>% 
  layer_dense(units  = 180, activation = 'relu', input_shape = 180) %>% 
  layer_dropout(rate = 0.4) %>% 
  layer_dense(units  = 90, activation  = 'relu') %>%
  layer_dropout(rate = 0.3) %>%
  layer_dense(units  = 3, activation   = 'softmax')

model %>% compile(
  loss      = 'categorical_crossentropy',
  optimizer = optimizer_rmsprop(),
  metrics   = c('accuracy')
)

history = model %>% fit(
  x_train, y_train, 
  epochs = 150, 
  batch_size = 50, 
  validation_split = 0.2
)

acc     = perf$acc %>% round(3)*100
y_pred  = model %>% predict_classes(x_test)
y_real  = y_test %>% apply(1,function(x){ return( which(x==1) - 1) })
results = tibble(y_real = y_real %>% factor, y_pred = y_pred %>% factor,
                 Correct = ifelse(y_real == y_pred,"yes","no") %>% factor)
title = 'Performance on 10% unseen data - Feed Forward Neural Network'
xlab  = 'Measured (Real class, as predicted by netMHCpan-4.0)'
ylab  = 'Predicted (Class assigned by Keras/TensorFlow deep FFN)'
results %>%
  ggplot(aes(x = y_pred, y = y_real, colour = Correct)) +
  geom_point() +
  ggtitle(label = title, subtitle = paste0("Accuracy = ", acc,"%")) +
  xlab(xlab) +
  ylab(ylab) +
  scale_color_manual(labels = c('No', 'Yes'),
                     values = c('tomato','cornflowerblue')) +
  geom_jitter() +
  theme_bw()
