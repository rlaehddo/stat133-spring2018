#' @title is function an integer
#' @description determines if number is integer or not
#' @param x numerical value
#' @return logical determination
is_integer <- function(z){
  if (z %% 1 == 0){
    return (TRUE)
  } else {
    return (FALSE)
  }
}

#' @examples 
is_integer(-1)
is_integer(0)
is_integer(2L)
is_integer(2)
is_integer(2.1)
is_integer(pi)
is_integer(0.01)


#' @title is function positive
#' @description determines if number is positive or not
#' @param x numerical value
#' @return logical determination
is_positive <- function (x) {
  if (x <= 0) {
    return(FALSE)
  } else if (x >0){
    return (TRUE)
  }
}

#' @examples 
is_positive(0.01)
is_positive(2)
is_positive(-2)
is_positive(0)

#' @title is function nonnegative
#' @description determines if number is nonnegative or not
#' @param x numerical value
#' @return logical determination
is_nonnegative <- function (y) {
  if (y < 0) {
    return(FALSE)
  } else if (y >= 0){
    return(TRUE)
  }
}

#' @examples 
is_nonnegative(0)
is_nonnegative(2)
is_nonnegative(-0.00001)
is_nonnegative(-2)



#' @title is function positive and an integer
#' @description determines if number is positive and an integer
#' @param x numerical value
#' @return logical determination
is_positive_integer <- function(x){
  if (is_positive(x) & is_integer(x)){
    return(TRUE)
  } else if (!is_positive(x)){
    return(FALSE)
  } else if (!is_integer(x)){
    return(FALSE)
  }
}

#' @examples 
is_positive_integer(2)
is_positive_integer(2L)
is_positive_integer(0)
is_positive_integer(-2)


#' @title is function nonnegative and an integer
#' @description determines if number is nonnegative and an integer
#' @param x numerical value
#' @return logical determination
is_nonneg_integer<- function(x){
  if (is_nonnegative(x) & is_integer(x)){
    return(TRUE)
  } else if (!is_nonnegative(x)){
    return(FALSE)
  } else if (!is_integer(x)){
    return(FALSE)
  }
}

#' @examples 
is_nonneg_integer(0)
is_nonneg_integer(1)
is_nonneg_integer(-1)
is_nonneg_integer(-2.5)



#' @title is funcation a probability
#' @description determines if number is a probability
#' @param x numerical value
#' @return logical determination
is_probability <- function(x){
  if (0<= x  & x<= 1){
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' @examples 
is_probability(0)
is_probability(0.5)
is_probability(1)
is_probability(-1)
is_probability(1.000001)


#' @title factorial 
#' @description factorial of a nonnegative integer
#' @param x nonnegative integer
#' @return computed factorial
bin_factorial <- function(x){
  if(x==0 | x==1){
    return(1)}
  else{
    y=1
    for(i in 1:x){
      y<- y*((1:x)[i])
    } 
    return (y)
  }}

#' @examples 
bin_factorial(5)
bin_factorial(0)


#' @title combinations 
#' @description number of combinations in which k successes can occur in n trials
#' @param k number of successes (numeric)
#' @param n number of trials (numeric)
#' @return computed combination
bin_combinations <- function(n, k) {
  bin_factorial(n) / (bin_factorial(k) * bin_factorial(n-k))
  return(bin_factorial(n) / (bin_factorial(k) * bin_factorial(n-k)))
}

#' @examples 
bin_combinations(n=5, k=2)
bin_combinations(10,3)
bin_combinations(4,4)




#' @title probability  
#' @description probability 
#' @param trials number of trials
#' @param success number of successes
#' @param proability probability of the set
#' @return probability numeric value between 0 and 1
bin_probability <- function(trials, success, probability)
{if (is_nonneg_integer(trials) & is_nonneg_integer(success) & is_probability(probability)){
  bin_combinations(trials, success) * (probability ^ success) * ((1 - probability)^(trials - success))
}
  else{stop("invaid inputs")}}

#' @examples
bin_probability(trials = 5, success = 2, probability = 0.5)





#' @title binomial distribution   
#' @description binomial distribution 
#' @param trials number of trials
#' @param prob probability between 0 and 1
#' @return proabiblity and success chart

bin_distribution <- function(trials, prob){
  col1 = c(0:trials) #index list
  col2 = col1 #probability column
  
  for (i in 0:trials){
    col2[1+i] = 
      bin_probability(prob=prob, trials=trials, success = i)
  } 
  
  return(data.frame(cbind(success = col1, probability = col2)))
}

#' @example
bin_distribution(trials = 5, prob = 0.5)
