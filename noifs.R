# example: how to avoid if statements

df <- data.frame(id = paste0("S", 1L:3),
                 sq = c("AAATGT", "TGAATTTC", "GCCCTAT"),
                 s = c("+", "-", "+"), stringsAsFactors = FALSE)

get_sq <- function(x) {
  fun_list <- list(`+` = identity, `-` = rev)
  chosen_funs <- setNames(fun_list[df[["s"]]], df[["id"]])
  splitted_seqs <- setNames(strsplit(df[["sq"]], ""), df[["id"]])
  lapply(df[["id"]], function(i) chosen_funs[[i]](splitted_seqs[[i]]))
}

get_sq(df)
