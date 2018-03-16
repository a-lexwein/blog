library(triebeard)
library(dplyr)
library(purrr)

default_node <- list(x = -1, y = -1)


test_node <- list(x = 1, y = 2)


neighbors <- function(df, node) {
  a <- node$x
  b <- node$y
  df %>%
    filter( !(x == a & y == b),
            x >= a - 1,
            x <= a + 1,
            y >= b - 1,
            y <= b + 1)
}

remove_node_from_board <- function(board, node) {
  a <- node$x
  b <- node$y
  filter(board, !(board$x == a & board$y == b))
}

node <- default_node
links_on_board <- function(board, node, word) {
  a <- node$x
  b <- node$y
  head <- substring(word, 1, 1)
  tail <- substring(word, 2)
  
  if (node$x == default_node$x) {
    return(filter(board, board$letter == head))
  }
  
  neighbors(board, node) %>%
    filter(letter == head)
}

f_pmap_aslist <- function(df) {
  pmap(as.list(df), list)
}


is_on_board <- function(board, node, word) {
  a <- node$x
  b <- node$y
  head <- substring(word, 1, 1)
  tail <- substring(word, 2)
  
  links <- links_on_board(board, node, head)
  if (nrow(links) == 0) {
    return(FALSE)
  }
  
  if (nchar(tail) == 0) {
    return(TRUE)
  }
  f_pmap_aslist(links) %>%
    map(function(row) {
      new_board <- remove_node_from_board(board, row)
      is_on_board(new_board, row, tail)
    })
}

is_on_board_shell <- function(board, node, word) {
  sum(unlist(is_on_board(board, node, word))) > 0
}

get_grid <- function(n,m) {
  ## test for n,m between 1 and 10
  grid <- data.frame(data.frame(x= integer(0), y= integer(0), stringsAsFactors = FALSE))
  for(i in seq(1,n)) {
    for(j in seq(1,m)) {
      grid <- rbind(grid, c(i,j))
    }
  }
  names(grid) <- c("x", "y")
  return(grid)
}



grid <- get_grid(3,3) %>% mutate(letter = c('C', 'A', 'T', 'S', 'A', 'B', 'E', 'E', 'P'))
is_on_board(grid, node, "PESCAT")
is_on_board_shell(grid, node, "EBS") 


