
#1.1)Read Archive Data Table
library(XML)
library(dplyr)
library(stringr)
library(ggplot2)


#' @title read table of cran.r
#' @description reads the table of cran r 
#' @param x package 
#' @return table of pacakge data
read_archive <- function(x){
  url <- paste0('http://cran.r-project.org/src/contrib/Archive/',x)
  tbl_html <-readHTMLTable(url)
  tbl <- tbl_html[[1]]
  data.frame(tbl)
}


#1.2) Data Cleaning


#' @title names 
#' @description split names and nubmers
#' @param x raw data
#' @return name and number
version_names = function(a){
  str_sub(
    unlist(str_split(a$Name, pattern = '_' ))[c(TRUE, FALSE)]
  )
}



#' @title version
#' @description removes '.tar.gz' 
#' @param x raw data
#' @return version of archive
version_numbers = function(a){
  str_sub(
    str_replace(
      unlist(str_split(a$Name, pattern = '_' ))[c(FALSE, TRUE)],
      pattern = '.tar.gz',
      replacement = ''
    )
  )
}



#' @title last modified
#' @description when archive was last modified
#' @param x raw data 
#' @return date of last modified
version_dates = function(a){
  str_sub(a$Last.modified, end = -7)
}



#' @title size
#' @description make the size value in terms of KB 
#' @param x raw data
#' @return size in KB
version_sizes = function(a){
  size_value <- as.numeric(str_replace(a$Size, pattern = "K|M", replacement = ''))
  size_unit <- str_sub(a$Size, start = -1)
  which_size_unit <- size_unit == "M" 
  size_value[which_size_unit] <- size_value[which_size_unit] * 1000
  a$Size <- size_value
}



#' @title clean archive
#' @description clean the archive of package
#' @param x raw data of archive
#' @return organized table of archive
clean_archive <- function(y){
  y$Description <- NULL
  index<- which(is.na(y$Size))
  y <- y[-c(2,index),]
  y <- data.frame(
    as.character(version_names(y)),
    as.character(version_numbers(y)),
    as.Date(version_dates(y)),
    as.numeric(version_sizes(y))
  )
  colnames(y) <- c("name", "version", "date", "size")
  return(y)
}


raw_data <- read_archive('stringr')
clean_data <- clean_archive(raw_data)
clean_data

write.table(clean_archive(raw_data), file = "~/Desktop/school/stat133/hw/hw4/data/stringr-archive.csv", 
            sep = ",",
            col.names = TRUE,
            row.names = FALSE)

#1.3) Timeline Plot


#' @title plot the archive
#' @description creates data plot 
#' @param x packaged cleaned data 
#' @return plot step 
plot_archive <- function(z){
  ggplot(data = z) +
    geom_step(aes(x = date, y = size)) +
    ggtitle("timeline of version sizes") +
    xlab("date") + ylab("Size (Kilobytes)")
}

plot_archive(clean_data)


