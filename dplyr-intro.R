x <- c("MYGGP", "GGGHMIL")
splitted_x <- strsplit(x, "")
factor_x <- lapply(splitted_x, factor, levels = c("A", "C", "D", "E", "F", "G", 
                                                  "H", "I", "K", "L", "M", "N", 
                                                  "P", "Q", "R", "S", "T", "V", "W", "Y"))
lapply(factor_x, table)
