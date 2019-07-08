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
