Lab 8: Simple Loops
================
Amy Kim

# Introduction

The majority of functions that work with vectors are vectorized.
Remember that vectorized operations are calculations that are applied to
all the elements in a vector (element-wise operations).

In order to learn about loops and iterations, it’s good to forget about
vectorized operations in R. This means that you will be asked to write
code, using some sort of loop structure, to perform tasks for which
there is already a vectorized implementation. For example, in this lab
you will have to write code with various types of loops to calculate the
mean of a numeric vector. This can easily be done using the function
mean(). But we don’t want you to use mean(). We want you to think about
control-flow structures, which are essential in any programming
activity.

# For loops

Let’s start with a super simple example. Consider a vector vec \<- c(3,
1, 4). And suppose you want to add 1 to every element of vec. You know
that this can easily be achieved using vectorized code:

``` r
vec <- c(3, 1, 4) 
vec + 1
```

    ## [1] 4 2 5

In order to learn about loops, I’m going to ask you to forget about the
notion of vectorized code in R. That is, pretend that R does not have
vectorized functions.

Think about what you would manually need to do in order to add 1 to the
elements in vec. This addition would involve taking the first element in
vec and add 1, then taking the second element in vec and add 1, and
finally the third element in vec and add 1, something like this:

``` r
vec[1] + 1
```

    ## [1] 4

``` r
vec[2] + 1
```

    ## [1] 2

``` r
vec[3] + 1
```

    ## [1] 5

The code above does the job. From a purely arithmetic standpoint, the
three lines of code reflect the operation that you would need to carry
out to add 1 to all the elements in vec.

From a programming point of view, you are performing the same type of
operation three times: selecting an element in vec and adding 1 to it.
But there’s a lot of (unnecessary) repetition.

This is where loops come very handy. Here’s how to use a for () loop to
add 1 to each element in vec:

``` r
vec <- c(3, 1, 4)

for (j in 1:3) {
  print(vec[j] + 1)
}
```

    ## [1] 4
    ## [1] 2
    ## [1] 5

In the code above we are taking each vec element vec\[j\], adding 1 to
it, and printing the outcome with print() so you can visualize the
additions at each iteration of the loop.

**Your turn** : rewrite the for loop in order to triple every element in
vec, and printing the output at each step of the loop:

``` r
vec <- c(3, 1, 4) # Change this value!

for (j in 1:3) {
  print(3*vec[j])
}
```

    ## [1] 9
    ## [1] 3
    ## [1] 12

What if you want to create a vector vec2, in which you store the values
produced at each iteration of the loop? Here’s one possibility:

``` r
vec <- c(3, 1, 4)  
vec2 <- rep(0, length(vec)) 

for (i in 1:3) {
  print(vec2[i] <- vec[i])
}
```

    ## [1] 3
    ## [1] 1
    ## [1] 4

# Summation Series

Write a for loop to compute the following two series. Your loop should
start at step k = 0 and stop at step n. Test your code with different
values for n. And store each k-th term at each iteration. Does the
series converge as n increase?

``` r
#summation from k = 0 to n of 1/(2^k)
n = 10 # change value!
x = rep(0,n)
for (k in 0:n){ 
  x[k] = 1/(2^k)
} 
sum(x) # series converges to 1 as n increases
```

    ## [1] 0.9990234

``` r
#summation from k = 0 to n of 1/(9^k)
n = 1000000 # change value!
x = rep(0,n)
for (k in 0:n){
  x[k] = 1/(9^k)
} 
sum(x) # series converges to 0.125 as n increases 
```

    ## [1] 0.125

## Arithmetic Series

Write a for loop to compute the following arithmetic series aₙ = a₁ +(n
− 1)d when a₁ = 3, and d = 3. For instance: 3 + 6 + 9 + 12 + 24 +….

``` r
d <- 3
a_one <- 3
n = 3 #change value! 
x = rep(0, n)
for (k in 1:n){
  x[k] = a_one + (k - 1) * d
} 
sum(x)
```

    ## [1] 18

Test your code with different values for n. And store each n-th term at
each iteration. Does the series converge as n increase?

No the series diverges as n increases.

## Geometric Sequence

A sequence such as 3, 6, 12, 24, 48 is an example of a geometric
sequence. In this type of sequence, the n-th term is obtained as:

aₙ = a₁ × r^(n − 1)

where: a₁ is the first term, r is the common ratio, and n is the number
of terms.

Write a for loop to compute the sum of the first n terms of: 3 + 6 + 12
+ 24 + …. Test your code with different values for n. Does the series
converge as n increase?

``` r
a_one <- 3
r <- 2
n = 100000 #change value! 
x = rep(0, n)
for (n in 1:n){
  x[n] = a_one * r^(n - 1)
}
sum(x)
```

    ## [1] Inf

The series diverges as n increases.

# Sine Approximation

Consider the following series that is used to approximate the function
sin(x)

Write a for loop to approximate sin(x). Try different number of terms, n
= 5, 10, 50, 100. Compare your loop with the sin() function.

``` r
n = 10
x = 1
sin_sum = 0
for (i in 1:n){
  term <- ((-1)^(n-1) * x^(2*n -1))/factorial(2*n -1)
  sin_sum <- sin_sum + term
  print(sin_sum)
}
```

    ## [1] -8.220635e-18
    ## [1] -1.644127e-17
    ## [1] -2.466191e-17
    ## [1] -3.288254e-17
    ## [1] -4.110318e-17
    ## [1] -4.932381e-17
    ## [1] -5.754445e-17
    ## [1] -6.576508e-17
    ## [1] -7.398572e-17
    ## [1] -8.220635e-17

# For loop with a matrix

Consider the following matrix A:

``` r
A <- matrix(1:20, nrow = 5, ncol = 4)
A
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    6   11   16
    ## [2,]    2    7   12   17
    ## [3,]    3    8   13   18
    ## [4,]    4    9   14   19
    ## [5,]    5   10   15   20

Say we want to add 1 to all elements in row 1, add 2 to all elements in
row 2, add 3 to all elements in row 3, and so on. To do this without
using vectorized coe, you need to work with two nested for() loops. One
loop will control how you traverse the matrix by rows, the other loop
will control how you traverse the matrix by columns. Here’s how:

``` r
# empty matrix B
B <- matrix(NA, nrow = 5, ncol = 4)

# for loop to get matrix B
for (i in 1:nrow(A)) {
  for (j in 1:ncol(A)) {
    B[i,j] <- A[i,j] + i
  }
}

B
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    2    7   12   17
    ## [2,]    4    9   14   19
    ## [3,]    6   11   16   21
    ## [4,]    8   13   18   23
    ## [5,]   10   15   20   25

## Your Turn

Consider the following matrix X:

``` r
set.seed(123)
X <- matrix(rnorm(12), nrow = 4, ncol = 3)
X
```

    ##             [,1]       [,2]       [,3]
    ## [1,] -0.56047565  0.1292877 -0.6868529
    ## [2,] -0.23017749  1.7150650 -0.4456620
    ## [3,]  1.55870831  0.4609162  1.2240818
    ## [4,]  0.07050839 -1.2650612  0.3598138

Write code in R, using loops, to get a matrix Y such that the negative
numbers in A are transformed into squared values, while the positive
numbers in A are transformed into square root values

``` r
Y <- matrix(NA, nrow = 4, ncol = 3)

# for loop to get matrix Y
for (i in 1:nrow(X)) {
  for (j in 1:ncol(X)) {
    if(X[i,j] < 0){
      Y[i,j] <- (X[i,j])^2
    }
    if(X[i,j] > 0){
      Y[i,j] <- sqrt(X[i,j])
    }
  }
}

Y
```

    ##            [,1]      [,2]      [,3]
    ## [1,] 0.31413295 0.3595660 0.4717668
    ## [2,] 0.05298168 1.3096049 0.1986146
    ## [3,] 1.24848240 0.6789081 1.1063823
    ## [4,] 0.26553416 1.6003799 0.5998448

# Dividing a number by 2 multiple times

The following examples involve dividing a number by 2 until it becomes
odd.

## Using a repeat loop

``` r
# Divide a number by 2 until it becomes odd.
val_rep <- 898128000 # Change this value!

repeat {
  print(val_rep)
  if (val_rep %% 2 == 1) { # If val_rep is odd,
    break                  # end the loop.
  }
  val_rep <- val_rep / 2 # Divide val_rep by 2 since val_rep was even.
  # When the end of the loop is reached, return to the beginning of the loop.
}
```

    ## [1] 898128000
    ## [1] 449064000
    ## [1] 224532000
    ## [1] 112266000
    ## [1] 56133000
    ## [1] 28066500
    ## [1] 14033250
    ## [1] 7016625

## Using a while Loop

``` r
# Divide a number by 2 until it becomes odd.
val_while <- 898128000 # Change this value!

while (val_while %% 2 == 0) { # Continue the loop as long as val_while is even.
  print(val_while)
  val_while <- val_while / 2
}
```

    ## [1] 898128000
    ## [1] 449064000
    ## [1] 224532000
    ## [1] 112266000
    ## [1] 56133000
    ## [1] 28066500
    ## [1] 14033250

``` r
print(val_while)
```

    ## [1] 7016625

## Make a reduce() function

Now generalize the above code to create a function reduce() which
performs the same operation. (You should change very little.)

``` r
# your reduce() function
reduce <- function(x) {
  while(x %% 2 == 0){
    print(x)
    x <- x / 2
  }
  print(x)
}

reduce(898128000)
```

    ## [1] 898128000
    ## [1] 449064000
    ## [1] 224532000
    ## [1] 112266000
    ## [1] 56133000
    ## [1] 28066500
    ## [1] 14033250
    ## [1] 7016625

# Average

Write R code, using each type of loop (e.g. for, while, repeat) to
implement the arithmetic mean of the vector x = 1 : 100

``` r
x = 1:100 
mean(x)
```

    ## [1] 50.5

``` r
# for loop
y = rep(1:length(x))
a = 0
x = 1:100 

for(i in 1:length(x)){
  y[i] <- x[i] + a
} 
average <- sum(y) / length(x)
average
```

    ## [1] 50.5

``` r
# while loop
y = rep(1:length(x))
a = 0
x = 1:100

i <- 1
while(i <= length(x)){
  y[i] <- a + x[i]
  i <- i + 1
}
average <- sum(y) / length(x)
average
```

    ## [1] 50.5

``` r
# repeat loop
y = rep(1:length(x))
a = 0
x = 1:100 

repeat{
  i <- 1 + i
  if (i >= length(x)) {
    break
  }
  y[i] = x[i] + a
}
average <- sum(y) / length(x)
average
```

    ## [1] 50.5

# Standard Deviation

Write R code, using each type of loop (e.g. for, while, repeat) to
implement the sample standard deviation of the vector x = 1 : 100

``` r
x = 1:100
sd(x) # 29.01149
```

    ## [1] 29.01149

``` r
# for loop
x = 1:100 
y = rep(1:length(x))
a = 0

for (i in 1:length(x)){
  y[i] = (x[i] - mean(x))^2
}
sd <- sqrt((1/(length(x)-1))*sum(y))
sd
```

    ## [1] 29.01149

``` r
# while loop
x = 1:100 
y = rep(1:length(x))
a = 0

i <- 1
while(i <= length(x)){
  y[i] = (x[i] - mean(x))^2
  i <- i + 1
}
sd <- sqrt((1/(length(x)-1))*sum(y))
sd
```

    ## [1] 29.01149

``` r
# repeat loop
y = rep(1:length(x))
a = 0
x = 1:100 

repeat{
  i <- 1 + i
  if (i >= length(x)) {
    break
  }
  y[i] = x[i] + a
}
sd <- sqrt((1/(length(x)-1))*sum(y))
sd
```

    ## [1] 7.142136

# Geometric Mean

Write R code, using each type of loop (e.g. for, while, repeat) to
implement the geometric mean of the vector x = 1:50

``` r
# for loop
x <- 1:50
product <- 1

for (i in 1:length(x)) {
  product <- product * x[i]
}
(product)^(1/length(x))
```

    ## [1] 19.48325

``` r
# while loop
x = 1:50 
a = 1
i = 1
y = rep(1:length(x))
while(i <= length(x)){
  y[i]<-  x[i] * a
  i = i + 1
}
geom_mean <- (prod(y))^(1/length(x))
geom_mean
```

    ## [1] 19.48325

``` r
# repeat loop
y = rep(1:length(x))
a = 1
x = 1:50 
i = 1
repeat{
  i <- 1 + i
  if (i >= length(x)) {
    break
  }
  y[i] = x[i] * a
}
geom_mean <- (prod(y))^(1/length(x))
geom_mean
```

    ## [1] 19.48325
