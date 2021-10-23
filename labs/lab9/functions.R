
# Practice writing simple tests

# Example with stat_range()
# Let’s start with a basic function stat_range() to compute the overall range of a numeric vector. Create this function in the file functions.R.

#' @title Range
#' @description Computes overall range: max - min
#' @param x numeric vector
#' @return computed range
stat_range <- function(x) {
  max(x) - min(x)
}

#' @title Center measures
#' @description Computes measures of center: mean and median
#' @param x numeric vector
#' @return vector with mean and median
stat_centers <- function(x) {
  c('mean' = mean(x), 'median' = median(x))
}


#' @title Spread measures
#' @description Computes measures of spread: range, IQR, and SD
#' @param x numeric vector
#' @return vector with range, iqr, and stdev
stat_spreads <- function(x) {
  c('range' = stat_range(x), 
    'iqr' = IQR(x),
    'stdev' = sd(x))
}

