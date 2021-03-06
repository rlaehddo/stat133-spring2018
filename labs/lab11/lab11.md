Lab 11: Random Number and Simulations
================

# Introduction

Random numbers have many applications in science and computer
programming, especially when there are significant uncertainties in a
phenomenon of interest.

# Computing Probabilities

With the mathematical rules from probability theory we can compute the
probability that a certain event happens. Consider for example two bags
containing balls of different colors. Bag 1 contains 2 white balls and 1
red ball; bag 2 contains 3 white balls and 1 red ball.

Suppose that a bag is chosen at random, and then a ball is picked at
random from the selected bag. What is the given probability that:

1 ) the ball chosen is red 2 ) the ball chosen is white

This problem can be solved analytically using the formulas:

P(red) = P(red | bag1) P(bag1) + P(red | bag2) P(bag2)

P(white) = P(white | bag1) P(bag1) + P(white | bag2) P(bag2)

Instead of solving this problem analytically, you can write R code to
simulate the experiment of picking a bag and drawing a ball. The first
step consists of creating two bags as character vectors with the name of
the colors for the balls:

``` r
library(ggplot2)
```

    ## Registered S3 methods overwritten by 'tibble':
    ##   method     from  
    ##   format.tbl pillar
    ##   print.tbl  pillar

``` r
# bags
bag1 <- c('white', 'white', 'red')
bag2 <- c(rep('white', 3), 'red')
```

To compute the probability using simulations, we need to replicate the
random experiments a large number of times (e.g. 500 or 1000 times).

``` r
bags <- c('bag1', 'bag2')
repetitions <- 1000
drawn_balls <- character(repetitions)

set.seed(345)
for (i in 1:repetitions) {
  # select one bag
  chosen_bag <- sample(bags, 1)
  
  # draw a ball from chosen bag
  if (chosen_bag == 'bag1') {
    drawn_balls[i] <- sample(bag1, 1)
  } else {
    drawn_balls[i] <- sample(bag2, 1)
  }
}

table(drawn_balls) / repetitions
```

    ## drawn_balls
    ##   red white 
    ## 0.289 0.711

# A less basic probability problem

You can manually find the probabilities of the previous example.
However, not all real problems have an analytic solution. Consider the
following situation. There are two boxes with balls of different colors.
Box 1 contains two blue balls, and one red ball. Box 2 contains two blue
balls, three red balls, and one white ball.

The random experiment consists of generating a random number that
follows a uniform distribution (min = 0, max = 1). If the number is
greater than 0.5, then a sample with replacement of size 4 is drawn from
box 1. If the random number is less than or equal to 0.5, then a sample
without replacement of size is drawn from box 2. The goal is to find the
probability distribution for the number of blue balls. In other words:

  - Probability of 0 blue balls
  - Probability of 1 blue ball
  - Probability of 2 blue balls
  - Probability of 3 blue balls
  - Probability of 4 blue balls

### Your Turn

1 ) Create two character vectors box1 and box2 with colors of balls:

``` r
# boxes as character vectors 
box1 <- c('blue', 'blue', 'red')
box2 <- c('blue', 'blue', 'red', 'red', 'red', 'white')
```

2)  The random experiment involves generating a uniform random number
    using runif(1). If this number is greater than 0.5, get a sample()
    without replacement of size = 4 from box1. Otherwise, get a sample()
    without replacement of size = 4 from box2.

<!-- end list -->

``` r
size = 4
```

3)  Repeat the experiment 1000 times using a for loop. To store the
    drawn samples, use a matrix drawn\_balls. This matrix will have 1000
    rows and 4 columns. In each row you assign the output of a random
    sample of balls.

<!-- end list -->

``` r
# sample size
size <- 4

# number of repetitions
repetitions <- 1000

# matrix to store sample results
drawn_balls <- matrix("", repetitions, size)

for (r in 1:repetitions) {
  aux <- runif(1)
  if (aux > 0.5) {
    drawn_balls[r, ] <- sample(box1, size, replace = TRUE)
  } else {
    drawn_balls[r,] <- sample(box2, size)
  }
}

head(drawn_balls)
```

    ##      [,1]    [,2]    [,3]    [,4]   
    ## [1,] "blue"  "red"   "white" "blue" 
    ## [2,] "red"   "white" "blue"  "blue" 
    ## [3,] "red"   "red"   "blue"  "white"
    ## [4,] "blue"  "blue"  "blue"  "red"  
    ## [5,] "white" "blue"  "red"   "red"  
    ## [6,] "blue"  "blue"  "blue"  "blue"

4 ) Once you filled the matrix drawn\_balls, compute the proportion of
samples containing: 0, 1, 2, 3, or 4 blue balls.

``` r
# number of blue balls in each repetition
blue_counts <- apply(drawn_balls, 1, function(x) sum(x == 'blue'))

# relative frequencies
table(blue_counts) / repetitions
```

    ## blue_counts
    ##     0     1     2     3     4 
    ## 0.038 0.320 0.322 0.222 0.098

5)  Try to obtain the following plot showing the relative frequencies of
    number of blue balls over the series of repetitions.

<!-- end list -->

``` r
# progression of relative frequencies
blue_freqs <- vector(mode = "list", length = 5)
for (num_blue in 0:4) {
  blue_freqs[[num_blue + 1]] <- cumsum(blue_counts == num_blue) / (1:repetitions)
}

dat <- data.frame(
  reps = rep(1:repetitions, 5),
  freqs = unlist(blue_freqs),
  number = factor(rep(0:4, each = repetitions))
)

ggplot(data = dat, aes(x = reps, y = freqs, group = number)) +
  geom_path(aes(color = number)) +
  ggtitle("Relative frequencies of number of blue balls")
```

![](lab11_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->
