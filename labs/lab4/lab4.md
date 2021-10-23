Lab 4: Data Frame Basics
================
Amy Kim

# Abalone Data Set

The first data set that you will working with is the Abalone Data Set
that is part of the UCI Machine Learning Repository

The location of the data file
is:

<http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data>

The location of the data dictionary (description of the data)
is:

<http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.names>

Look at both the dataset file, and the file with its description, and
answer the following questions:

\*What’s the character delimiter?

The character delimiter is “,”.

\*Is there a row for column names?

No.

\*Are there any missing values? If so, how are they codified?

No missing values.

\*What is the data type of each column?

| Name           | Data Type  |
| -------------- | ---------- |
| Sex            | nominal    |
| Length         | continuous |
| Diameter       | continuous |
| Height         | continuous |
| Whole weight   | continuous |
| Shucked weight | continuous |
| Viscera weight | continuous |
| Shell weight   | continuous |
| Rings          | integer    |

One basic way to read this file in R is by passing the url location of
the file directly to any of the read.table()
functions:

``` r
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"
abalone <- read.table(url, sep = ",")
```

## Getting a Local Copy of the Data

My suggestion when reading datasets from the Web, is to always try to
get a local copy of the data file in your machine (as long as you have
enough free space to save it in your computer). To do this, you can use
the function download.file() and specify the url address, and the name
of the file that will be created in your computer. For instance, to save
the abalone data file in your working directory, type the following
commands directly on the R console:

# Some Bash Commands

Before describing some of the reading-table functions in R, let’s
practice some basic bash commands to inspect the downloaded data file.

  - For those of you using Gitbash, go to your browser and open a tab to
    get the Linux Man Pages Online available in the website:
    <http://man.he.net/>

  - Open the terminal (e.g. Mac terminal or Gitbash) and change
    directories to the folder that contains the downloaded file
    abalone.data.

  - Use the file command to know what type of file is abalone.data.

<!-- end list -->

``` r
#CSV text
```

  - Use the word count command wc to obtain information about: 1)
    newline count, 2) word count, and 3) byte count, of the abalone.data
    file.

<!-- end list -->

``` r
# 1) 4177 
# 2) 4177
# 3) 191873
```

  - See the man documentation of wc and learn what option you should use
    to obtain only the number of lines in abalone.data.

<!-- end list -->

``` r
#wc -l 
# 4177
```

  - Use head to take a peek at the first lines (10 lines by default) of
    abalone.data

<!-- end list -->

``` r
#M,0.455,0.365,0.095,0.514,0.2245,0.101,0.15,15
#M,0.35,0.265,0.09,0.2255,0.0995,0.0485,0.07,7
#F,0.53,0.42,0.135,0.677,0.2565,0.1415,0.21,9
#M,0.44,0.365,0.125,0.516,0.2155,0.114,0.155,10
#I,0.33,0.255,0.08,0.205,0.0895,0.0395,0.055,7
#I,0.425,0.3,0.095,0.3515,0.141,0.0775,0.12,8
#F,0.53,0.415,0.15,0.7775,0.237,0.1415,0.33,20
#F,0.545,0.425,0.125,0.768,0.294,0.1495,0.26,16
#M,0.475,0.37,0.125,0.5095,0.2165,0.1125,0.165,9
#F,0.55,0.44,0.15,0.8945,0.3145,0.151,0.32,19
```

  - See the man documentation of head and learn what option you should
    use to display only the first 5 files in abalone.data.

<!-- end list -->

``` r
#head -5 abalone.data
#M,0.455,0.365,0.095,0.514,0.2245,0.101,0.15,15
#M,0.35,0.265,0.09,0.2255,0.0995,0.0485,0.07,7
#F,0.53,0.42,0.135,0.677,0.2565,0.1415,0.21,9
#M,0.44,0.365,0.125,0.516,0.2155,0.114,0.155,10
#I,0.33,0.255,0.08,0.205,0.0895,0.0395,0.055,7
```

  - Use tail to take a peek at the last lines (10 lines by default) of
    abalone.data

<!-- end list -->

``` r
#tail abalone.data
#M,0.5,0.38,0.125,0.577,0.269,0.1265,0.1535,9
#F,0.515,0.4,0.125,0.615,0.2865,0.123,0.1765,8
#M,0.52,0.385,0.165,0.791,0.375,0.18,0.1815,10
#M,0.55,0.43,0.13,0.8395,0.3155,0.1955,0.2405,10
#M,0.56,0.43,0.155,0.8675,0.4,0.172,0.229,8
#F,0.565,0.45,0.165,0.887,0.37,0.239,0.249,11
#M,0.59,0.44,0.135,0.966,0.439,0.2145,0.2605,10
#M,0.6,0.475,0.205,1.176,0.5255,0.2875,0.308,9
#F,0.625,0.485,0.15,1.0945,0.531,0.261,0.296,10
#M,0.71,0.555,0.195,1.9485,0.9455,0.3765,0.495,12
```

  - See the man documentation of tail and learn what option you should
    use to display only the last 3 files in abalone.data.

<!-- end list -->

``` r
# tail -3 abalone data
#M,0.6,0.475,0.205,1.176,0.5255,0.2875,0.308,9
#F,0.625,0.485,0.15,1.0945,0.531,0.261,0.296,10
#M,0.71,0.555,0.195,1.9485,0.9455,0.3765,0.495,12
```

  - Use the less command to look at the contents of abalone.data (this
    command opens a paginator so you can move up and down the contents
    of the file).

# Basic Importing

Now that you have a local copy of the dataset, you can read it in R with
read.table() like so:

``` r
# reading data from your working directory
abalone <- read.table("abalone.data", sep = ",")
```

Once you read a data table, you may want to start looking at its
contents, usually taking a peek at a few rows. This can be done with
head() and/or with tail():

``` r
# take a peek of first rows
head(abalone)
```

    ##   V1    V2    V3    V4     V5     V6     V7    V8 V9
    ## 1  M 0.455 0.365 0.095 0.5140 0.2245 0.1010 0.150 15
    ## 2  M 0.350 0.265 0.090 0.2255 0.0995 0.0485 0.070  7
    ## 3  F 0.530 0.420 0.135 0.6770 0.2565 0.1415 0.210  9
    ## 4  M 0.440 0.365 0.125 0.5160 0.2155 0.1140 0.155 10
    ## 5  I 0.330 0.255 0.080 0.2050 0.0895 0.0395 0.055  7
    ## 6  I 0.425 0.300 0.095 0.3515 0.1410 0.0775 0.120  8

``` r
# take a peek of last rows
tail(abalone)
```

    ##      V1    V2    V3    V4     V5     V6     V7     V8 V9
    ## 4172  M 0.560 0.430 0.155 0.8675 0.4000 0.1720 0.2290  8
    ## 4173  F 0.565 0.450 0.165 0.8870 0.3700 0.2390 0.2490 11
    ## 4174  M 0.590 0.440 0.135 0.9660 0.4390 0.2145 0.2605 10
    ## 4175  M 0.600 0.475 0.205 1.1760 0.5255 0.2875 0.3080  9
    ## 4176  F 0.625 0.485 0.150 1.0945 0.5310 0.2610 0.2960 10
    ## 4177  M 0.710 0.555 0.195 1.9485 0.9455 0.3765 0.4950 12

Likewsie, you may also want to examine how R has decided to take care of
the storage details (what data type is used for each column?). Use the
function str() to check the structure of the data frame:

``` r
# check data frame's structure
str(abalone, vec.len = 1)
```

    ## 'data.frame':    4177 obs. of  9 variables:
    ##  $ V1: chr  "M" ...
    ##  $ V2: num  0.455 0.35 ...
    ##  $ V3: num  0.365 0.265 ...
    ##  $ V4: num  0.095 0.09 ...
    ##  $ V5: num  0.514 ...
    ##  $ V6: num  0.225 ...
    ##  $ V7: num  0.101 0.0485 ...
    ##  $ V8: num  0.15 0.07 ...
    ##  $ V9: int  15 7 ...

## Detailed information about the columns

So far we have been able to read the data file in R. But we are missing
a few things. First, we don’t have names for the columns. Second, it
would be nice if we could specify the data types of each column instead
of letting R guess how to handle each data type.

According to the description of the Abalone data set, we can assign the
following data types to each of the columns as:

| Name           | Data Type  |
| -------------- | ---------- |
| Sex            | character  |
| Length         | continuous |
| Diameter       | continuous |
| Height         | continuous |
| Whole weight   | continuous |
| Shucked weight | continuous |
| Viscera weight | continuous |
| Shell weight   | continuous |
| Rings          | integer    |

Let’s create a vector of columns names, and another vector of data
types:

``` r
# vector of column names
column_names <- c(
    'sex',
    'length',
    'diameter',
    'height',
    'whole_weight',
    'shucked_weight',
    'viscera_weight',
    'shell_weight',
    'rings'
)

# vector of data types (for each column)
column_types <- c(
    'character',
    'real',
    'real',
    'real',
    'real',
    'real',
    'real',
    'real',
    'integer'   
)
```

Optionally, we could also specify a type “factor” for the variable sex
since this is supposed to be in nominal scale (i.e. it is a categorical
variable). Also note that the variable rings is supposed to be integers,
therefore we can choose an integer vector for this column.

Now we can re-read the table in a more complete (and usually more
efficient) way:

``` r
abalone <- read.table(
    'abalone.data',
    col.names = column_names,
    colClasses = column_types,
    sep = ","
)

# check its structure again
str(abalone, vec.len = 1)
```

    ## 'data.frame':    4177 obs. of  9 variables:
    ##  $ sex           : chr  "M" ...
    ##  $ length        : num  0.455 0.35 ...
    ##  $ diameter      : num  0.365 0.265 ...
    ##  $ height        : num  0.095 0.09 ...
    ##  $ whole_weight  : num  0.514 ...
    ##  $ shucked_weight: num  0.225 ...
    ##  $ viscera_weight: num  0.101 0.0485 ...
    ##  $ shell_weight  : num  0.15 0.07 ...
    ##  $ rings         : int  15 7 ...

## Your Turn

  - Read the Abalone data with the read.csv() function.
  - Use the inputs col.names and colClasses to specify column names and
    their data types.
  - Look at the data description in the following link:
    <http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.names>
    and confirm the following statistics:

<!-- end list -->

``` r
csv.abalone <- read.csv('abalone.data', col.names = column_names, 
         colClasses = column_types,
         sep = ",")

summary <- summary(csv.abalone, digits = max(3))
summary[c(1,3,4,6), -c(1)]
```

    ##      length         diameter         height       whole_weight  
    ##  Min.   :0.075   Min.   :0.055   Min.   :0.000   Min.   :0.002  
    ##  Median :0.545   Median :0.425   Median :0.140   Median :0.800  
    ##  Mean   :0.524   Mean   :0.408   Mean   :0.140   Mean   :0.829  
    ##  Max.   :0.815   Max.   :0.650   Max.   :1.130   Max.   :2.825  
    ##  shucked_weight  viscera_weight    shell_weight        rings      
    ##  Min.   :0.001   Min.   :0.0005   Min.   :0.0015   Min.   : 1.00  
    ##  Median :0.336   Median :0.1710   Median :0.2340   Median : 9.00  
    ##  Mean   :0.359   Mean   :0.1806   Mean   :0.2389   Mean   : 9.93  
    ##  Max.   :1.488   Max.   :0.7600   Max.   :1.0050   Max.   :29.00

# Import Abalone data with read\_csv()

In addition to the built-in functions for importing tables in R, there
is also the set of functions from the R package “readr”:

  - read\_delim()
  - read\_csv()
  - read\_tsv()
  - read\_csv2()
  - read\_fwf()
  - read\_table()

Take a look at this post for some
examples:<https://blog.rstudio.com/2015/04/09/readr-0-1-0/>

  - Use read\_csv() to import the abalone data set.
  - Use the argument col\_names to specify the column names.
  - Learn how to use the argument col\_types to specify the data type
    for each column.

<!-- end list -->

``` r
library(readr)

spec_csv("abalone.data")
```

    ## Parsed with column specification:
    ## cols(
    ##   M = col_character(),
    ##   `0.455` = col_double(),
    ##   `0.365` = col_double(),
    ##   `0.095` = col_double(),
    ##   `0.514` = col_double(),
    ##   `0.2245` = col_double(),
    ##   `0.101` = col_double(),
    ##   `0.15` = col_double(),
    ##   `15` = col_double()
    ## )

    ## cols(
    ##   M = col_character(),
    ##   `0.455` = col_double(),
    ##   `0.365` = col_double(),
    ##   `0.095` = col_double(),
    ##   `0.514` = col_double(),
    ##   `0.2245` = col_double(),
    ##   `0.101` = col_double(),
    ##   `0.15` = col_double(),
    ##   `15` = col_double()
    ## )

``` r
csv <- read_csv("abalone.data", col_names = column_names, 
                col_types = list(
                  sex = col_character(), 
                  length = col_double(),
                  diameter = col_double(),
                  height = col_double(),
                  whole_weight = col_double(),
                  shucked_weight = col_double(),
                  viscera_weight = col_double(),
                  shell_weight = col_double(),
                  rings = col_double()
                ))
```

# Pittsburgh Bridges Data Set

This data set is part of the UCI Machine Learning Repository:

<http://archive.ics.uci.edu/ml/datasets/Pittsburgh+Bridges>

The data Description is
here:

<http://archive.ics.uci.edu/ml/machine-learning-databases/bridges/bridges.names>

The Data file is
here:

<http://archive.ics.uci.edu/ml/machine-learning-databases/bridges/bridges.data.version1>

Read the description, and take a look at the data set:

  - Are there column names?

Yes. The column names are IDENTIF(identification), RIVER, LOCATION,
ERECTED, PURPOSE, LENGTH, LANES, CLEAR-G, T-OR-D, MATERIAL, SPAN n,
REL-L, TYPE n

  - What is the field separator?

The field separator is “,”.

  - Are there any missing values?

Yes. there are missing values.

  - What is the character for missing values (if any)?

The character for missing values is “?”

  - What is the data type of each variable (i.e. column)?

| Name     | Type                         |
| -------- | ---------------------------- |
| RIVER    | nominal                      |
| LOCATION | nominal                      |
| ERECTED  | conitnuous/integer , nominal |
| PURPOSE  | nominal                      |
| LENGTH   | conitnuous/integer , nominal |
| LANES    | conitnuous/integer , nominal |
| CLEAR-G  | nominal                      |
| T-OR-D   | nominal                      |
| MATERIAL | nominal                      |
| SPAN     | nominal                      |
| REL-L    | nominal                      |
| TYPE     | nominal                      |

  - Download a copy of the data to your computer (use download.file())
    and save it in a file named bridges.data

## Reading the Data

  - Create a vector of column names

<!-- end list -->

``` r
column_names <- c(
  'identification',
  'river',
  'location',
  'erected',
  'purpose',
  'length',
  'lanes',
  'clear-g',
  't-or-d',
  'material',
  'span',
  'rel-l',
  'type') 
```

  - Create a vector of column types

<!-- end list -->

``` r
column_types <- c(
  'character', 
  'character',
  'double',
  'double',
  'character',
  'double',
  'double',
  'character',
  'character',
  'character',
  'character',
  'character',
  'character'
)
```

  - Use the function read.table() to import the data. Name it bridges1.

<!-- end list -->

``` r
bridges1 <- read.table('bridges.data',
    col.names = column_names,
    sep = ",")

bridges1[bridges1 == "?"] <- NA
```

  - Use the function read.csv() to import the data. Name it bridges2.

<!-- end list -->

``` r
bridges2 <- read.csv('bridges.data', stringsAsFactors = FALSE,
                     sep = ",",
                     na.strings = "NULL",
                     col.names = column_names)

bridges2[bridges2 == "?"] <- NA
```

## Basic Inspection

Use functions to start examining the bridges1 data frame:

  - str()

<!-- end list -->

``` r
str(bridges1)
```

    ## 'data.frame':    108 obs. of  13 variables:
    ##  $ identification: chr  "E1" "E2" "E3" "E5" ...
    ##  $ river         : chr  "M" "A" "A" "A" ...
    ##  $ location      : chr  "3" "25" "39" "29" ...
    ##  $ erected       : int  1818 1819 1829 1837 1838 1840 1844 1846 1848 1851 ...
    ##  $ purpose       : chr  "HIGHWAY" "HIGHWAY" "AQUEDUCT" "HIGHWAY" ...
    ##  $ length        : chr  NA "1037" NA "1000" ...
    ##  $ lanes         : chr  "2" "2" "1" "2" ...
    ##  $ clear.g       : chr  "N" "N" "N" "N" ...
    ##  $ t.or.d        : chr  "THROUGH" "THROUGH" "THROUGH" "THROUGH" ...
    ##  $ material      : chr  "WOOD" "WOOD" "WOOD" "WOOD" ...
    ##  $ span          : chr  "SHORT" "SHORT" NA "SHORT" ...
    ##  $ rel.l         : chr  "S" "S" "S" "S" ...
    ##  $ type          : chr  "WOOD" "WOOD" "WOOD" "WOOD" ...

  - summary()

<!-- end list -->

``` r
summary(bridges1)
```

    ##  identification        river             location            erected    
    ##  Length:108         Length:108         Length:108         Min.   :1818  
    ##  Class :character   Class :character   Class :character   1st Qu.:1884  
    ##  Mode  :character   Mode  :character   Mode  :character   Median :1903  
    ##                                                           Mean   :1905  
    ##                                                           3rd Qu.:1928  
    ##                                                           Max.   :1986  
    ##    purpose             length             lanes             clear.g         
    ##  Length:108         Length:108         Length:108         Length:108        
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##     t.or.d            material             span              rel.l          
    ##  Length:108         Length:108         Length:108         Length:108        
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##      type          
    ##  Length:108        
    ##  Class :character  
    ##  Mode  :character  
    ##                    
    ##                    
    ## 

  - head() and
    tail()

<!-- end list -->

``` r
head(bridges1)
```

    ##   identification river location erected  purpose length lanes clear.g  t.or.d
    ## 1             E1     M        3    1818  HIGHWAY   <NA>     2       N THROUGH
    ## 2             E2     A       25    1819  HIGHWAY   1037     2       N THROUGH
    ## 3             E3     A       39    1829 AQUEDUCT   <NA>     1       N THROUGH
    ## 4             E5     A       29    1837  HIGHWAY   1000     2       N THROUGH
    ## 5             E6     M       23    1838  HIGHWAY   <NA>     2       N THROUGH
    ## 6             E7     A       27    1840  HIGHWAY    990     2       N THROUGH
    ##   material   span rel.l type
    ## 1     WOOD  SHORT     S WOOD
    ## 2     WOOD  SHORT     S WOOD
    ## 3     WOOD   <NA>     S WOOD
    ## 4     WOOD  SHORT     S WOOD
    ## 5     WOOD   <NA>     S WOOD
    ## 6     WOOD MEDIUM     S WOOD

``` r
tail(bridges1)
```

    ##     identification river location erected purpose length lanes clear.g  t.or.d
    ## 103            E85     M        9    1962 HIGHWAY   2213     4       G    DECK
    ## 104            E84     A       24    1969 HIGHWAY    870     6       G THROUGH
    ## 105            E91     O       44    1975 HIGHWAY   3756     6       G THROUGH
    ## 106            E90     M        7    1978 HIGHWAY    950     6       G THROUGH
    ## 107           E100     O       43    1982 HIGHWAY   <NA>  <NA>       G    <NA>
    ## 108           E109     A       28    1986 HIGHWAY   <NA>  <NA>       G    <NA>
    ##     material   span rel.l   type
    ## 103    STEEL   LONG     F CONT-T
    ## 104    STEEL MEDIUM     F   ARCH
    ## 105    STEEL   LONG     F   ARCH
    ## 106    STEEL   LONG     F   ARCH
    ## 107     <NA>   <NA>     F   <NA>
    ## 108     <NA>   <NA>     F   <NA>

  - dim()

<!-- end list -->

``` r
dim(bridges1)
```

    ## [1] 108  13

  - names()

<!-- end list -->

``` r
names(bridges1)
```

    ##  [1] "identification" "river"          "location"       "erected"       
    ##  [5] "purpose"        "length"         "lanes"          "clear.g"       
    ##  [9] "t.or.d"         "material"       "span"           "rel.l"         
    ## [13] "type"

  - colnames()

<!-- end list -->

``` r
colnames(bridges1)
```

    ##  [1] "identification" "river"          "location"       "erected"       
    ##  [5] "purpose"        "length"         "lanes"          "clear.g"       
    ##  [9] "t.or.d"         "material"       "span"           "rel.l"         
    ## [13] "type"

  - nrow()

<!-- end list -->

``` r
nrow(bridges1)
```

    ## [1] 108

  - ncol()

<!-- end list -->

``` r
ncol(bridges1)
```

    ## [1] 13

## Optional: Want to do more?

Write R code to find:

  - Year of the oldest erected bridge

<!-- end list -->

``` r
min(bridges1$erected)
```

    ## [1] 1818

  - Year of the most recent erected bridge

<!-- end list -->

``` r
max(bridges1$erected)
```

    ## [1] 1986

  - Frequency of bridges by purpose

<!-- end list -->

``` r
library(plyr)
count(bridges1, 'purpose')
```

    ##    purpose freq
    ## 1 AQUEDUCT    4
    ## 2  HIGHWAY   71
    ## 3       RR   32
    ## 4     WALK    1

  - Frequency of materials

<!-- end list -->

``` r
count(bridges1, 'material')
```

    ##   material freq
    ## 1     IRON   11
    ## 2    STEEL   79
    ## 3     WOOD   16
    ## 4     <NA>    2

  - Average length of the bridges

<!-- end list -->

``` r
bridges1$length <- as.numeric(bridges1$length)

mean(na.omit(bridges1$length))
```

    ## [1] 1567.469

# Creating Data Frames

Here’s a table with the starting lineup of the Golden State Warriors:

| Player   | Position | Salary   | Points | PPG  | Rookie |
| -------- | -------- | -------- | ------ | ---- | ------ |
| Thompson | SG       | 16663575 | 1742   | 22.3 | FALSE  |
| Curry    | PG       | 12112359 | 1999   | 25.3 | FALSE  |
| Green    | PF       | 15330435 | 776    | 10.2 | FALSE  |
| Durant   | SF       | 26540100 | 1555   | 25.1 | FALSE  |
| Pachulia | C        | 2898000  | 426    | 6.1  | FALSE  |

  - Start by creating vectors for each of the columns.

<!-- end list -->

``` r
player <- c("Thompson", "Curry", "Green", "Durant", "Pachulia")
position <- c("SG", "PG", "PF", "SF", "C")
salary <- c(16663575, 12112359, 15330435, 26540100, 2898000)
points <- c(1742, 1999, 775, 1555, 426)
ppg <- c(22.3, 25.3, 10.2, 25.1, 6.1)
rookie <- c(FALSE, FALSE, FALSE, FALSE, FALSE)
```

  - Use the vectors to create a first data frame with data.frame().

<!-- end list -->

``` r
df <- data.frame(cbind(player, position, salary, points, ppg, rookie))
```

  - Check that this data frame is of class “data.frame”, and that it is
    also a list.

<!-- end list -->

``` r
class(df)
```

    ## [1] "data.frame"

  - Create another data frame by first starting with a list(), and then
    passing the list to
data.frame().

<!-- end list -->

``` r
col_names <- c("player", "position", "salary", "points", "ppg", "rookie")
as.data.frame(list(player, position, salary, points, ppg, rookie), col.names = col_names)
```

    ##     player position   salary points  ppg rookie
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE
    ## 2    Curry       PG 12112359   1999 25.3  FALSE
    ## 3    Green       PF 15330435    775 10.2  FALSE
    ## 4   Durant       SF 26540100   1555 25.1  FALSE
    ## 5 Pachulia        C  2898000    426  6.1  FALSE

  - What would you do to obtain a data frame such that when you check
    its structure str() the variables are:

  - Player as character

  - Position as factor

  - Salary as numeric or real (ignore the commas)

  - Points as integer

  - PPG as numeric or real

  - Rookie as logical

<!-- end list -->

``` r
df$position <- as.factor(df$position)
df$salary <- as.numeric(df$salary)
df$points <- as.integer(df$points)
df$ppg <- as.numeric(df$ppg)
df$rookie <- as.logical(df$rookie)
str(df)
```

    ## 'data.frame':    5 obs. of  6 variables:
    ##  $ player  : chr  "Thompson" "Curry" "Green" "Durant" ...
    ##  $ position: Factor w/ 5 levels "C","PF","PG",..: 5 3 2 4 1
    ##  $ salary  : num  16663575 12112359 15330435 26540100 2898000
    ##  $ points  : int  1742 1999 775 1555 426
    ##  $ ppg     : num  22.3 25.3 10.2 25.1 6.1
    ##  $ rookie  : logi  FALSE FALSE FALSE FALSE FALSE

  - Find out how to use the column binding function cbind() to create a
    tabular object with the vectors created in step 1 (inspect what
    class of object is obtained with cbind()).

<!-- end list -->

``` r
bind <- cbind(player, position, salary, points, ppg, rookie)

class(bind)
```

    ## [1] "matrix" "array"

  - How could you convert the object in the previous step into a data
    frame?

<!-- end list -->

``` r
as.data.frame(bind)
```

    ##     player position   salary points  ppg rookie
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE
    ## 2    Curry       PG 12112359   1999 25.3  FALSE
    ## 3    Green       PF 15330435    775 10.2  FALSE
    ## 4   Durant       SF 26540100   1555 25.1  FALSE
    ## 5 Pachulia        C  2898000    426  6.1  FALSE

# NBA Players Data

Now that you’ve seen some of the most basic operations to manipulate
data frames, let’s apply them on a data set about NBA players. The
corresponding data file is nba2017-players.csv, located in the data/
folder of the course github repository. This file contains 15 variables
measured on 441 players.

First download a copy of the csv file to your computer.

To import the data in R you can use the function
read.csv():

``` r
csv <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/nba2017-players.csv"
download.file(url = csv, destfile = 'nba2017-players.csv')

dat <- read.csv('nba2017-players.csv', stringsAsFactors = FALSE)
```

Notice that I’m specifying the argument stringsAsFactors = FALSE to
avoid the conversion of characters into R factors.

All the default reading table functions generate a data frame.
Typically, everytime I read a new data set which I’m not familiar with,
or a data set that I haven’t worked on in a long time, I always like to
call a couple of functions to inspect its contents:

  - dim()
  - head()
  - tail()
  - str()
  - summary()

A first check-up is to examine the dimensions of the data frame with
dim():

``` r
# dimensions (# of rows, # of columns)
dim(dat)
```

    ## [1] 441  15

If you know in advanced how many rows and columns are in the data table,
this is a good way to make sure that R was able to read all the records.

Then, depending on the size of the data, you may want to take a peek at
its contents with head() or tail(), just to get an idea of what the data
looks like:

``` r
# display first few rows
head(dat)
```

    ##              player team position height weight age experience
    ## 1        Al Horford  BOS        C     82    245  30          9
    ## 2      Amir Johnson  BOS       PF     81    240  29         11
    ## 3     Avery Bradley  BOS       SG     74    180  26          6
    ## 4 Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5      Gerald Green  BOS       SF     79    205  31          9
    ## 6     Isaiah Thomas  BOS       PG     69    185  27          5
    ##                         college   salary games minutes points points3 points2
    ## 1         University of Florida 26540100    68    2193    952      86     293
    ## 2                               12000000    80    1608    520      27     186
    ## 3 University of Texas at Austin  8269663    55    1835    894     108     251
    ## 4      University of Notre Dame  1450000     5      17     10       1       2
    ## 5                                1410598    47     538    262      39      56
    ## 6      University of Washington  6587132    76    2569   2199     245     437
    ##   points1
    ## 1     108
    ## 2      67
    ## 3      68
    ## 4       3
    ## 5      33
    ## 6     590

For a more detailed description of how R is treating the data type in
each column, you should use the structure function str().

``` r
# check the structure
str(dat, vec.len = 1)
```

    ## 'data.frame':    441 obs. of  15 variables:
    ##  $ player    : chr  "Al Horford" ...
    ##  $ team      : chr  "BOS" ...
    ##  $ position  : chr  "C" ...
    ##  $ height    : int  82 81 ...
    ##  $ weight    : int  245 240 ...
    ##  $ age       : int  30 29 ...
    ##  $ experience: int  9 11 ...
    ##  $ college   : chr  "University of Florida" ...
    ##  $ salary    : num  26540100 ...
    ##  $ games     : int  68 80 ...
    ##  $ minutes   : int  2193 1608 ...
    ##  $ points    : int  952 520 ...
    ##  $ points3   : int  86 27 ...
    ##  $ points2   : int  293 186 ...
    ##  $ points1   : int  108 67 ...

This function str() displays the dimensions of the data frame, and then
a list with the name of all the variables, and their data types
(e.g. chr character, num real, etc). The argument vec.len = 1 indicates
that just the first element in each column should be displayed.

When working with data frames, remember to always take some time
inspecting the contents, and checking how R is handling the data types.
It is in these early stages of data exploration that you can catch
potential issues in order to avoid disastrous consequences or bugs in
subsequent stages.

Your turn: Use bracket notation, the dollar operator, as well as
concepts of logical subsetting and indexing to:

Display the last 5 rows of the data.

``` r
tail(dat)
```

    ##              player team position height weight age experience
    ## 436 Leandro Barbosa  PHO       SG     75    194  34         13
    ## 437 Marquese Chriss  PHO       PF     82    233  19          0
    ## 438    Ronnie Price  PHO       PG     74    190  33         11
    ## 439     T.J. Warren  PHO       SF     80    230  23          2
    ## 440      Tyler Ulis  PHO       PG     70    150  21          0
    ## 441  Tyson Chandler  PHO        C     85    240  34         15
    ##                             college   salary games minutes points points3
    ## 436                                  4000000    67     963    419      35
    ## 437        University of Washington  2941440    82    1743    753      72
    ## 438       Utah Valley State College   282595    14     134     14       3
    ## 439 North Carolina State University  2128920    66    2048    951      26
    ## 440          University of Kentucky   918369    61    1123    444      21
    ## 441                                 12415000    47    1298    397       0
    ##     points2 points1
    ## 436     137      40
    ## 437     212     113
    ## 438       1       3
    ## 439     377     119
    ## 440     163      55
    ## 441     153      91

Display those rows associated to players having height less than 70
inches tall.

``` r
dat[dat$height < 70, ]
```

    ##           player team position height weight age experience
    ## 6  Isaiah Thomas  BOS       PG     69    185  27          5
    ## 24    Kay Felder  CLE       PG     69    176  21          0
    ##                     college  salary games minutes points points3 points2
    ## 6  University of Washington 6587132    76    2569   2199     245     437
    ## 24       Oakland University  543471    42     386    166       7      55
    ##    points1
    ## 6      590
    ## 24      35

Of those players that are centers (position C), display their names and
salaries.

``` r
center <- dat[dat$position == "C", ]
center[c("player", "salary")]
```

    ##                   player   salary
    ## 1             Al Horford 26540100
    ## 12          Kelly Olynyk  3094014
    ## 15          Tyler Zeller  8000000
    ## 16         Channing Frye  7806971
    ## 20           Edy Tavares     5145
    ## 30      Tristan Thompson 15330435
    ## 37          Jakob Poeltl  2703960
    ## 38     Jonas Valanciunas 14382022
    ## 40        Lucas Nogueira  1921320
    ## 50         Daniel Ochefu   543471
    ## 51           Ian Mahinmi 15944154
    ## 52           Jason Smith  5000000
    ## 54         Marcin Gortat 12000000
    ## 62         Dwight Howard 23180275
    ## 69          Mike Muscala  1015696
    ## 75           Greg Monroe 17100000
    ## 78           John Henson 12517606
    ## 86            Thon Maker  2568600
    ## 89          Al Jefferson 10230179
    ## 98          Myles Turner  2463840
    ## 105    Cristiano Felicio   874636
    ## 111    Joffrey Lauvergne  1709720
    ## 116          Robin Lopez 13219250
    ## 119     Hassan Whiteside 22116750
    ## 128        Udonis Haslem  4000000
    ## 130          Willie Reed  1015696
    ## 131       Andre Drummond 22116750
    ## 132          Aron Baynes  6500000
    ## 134     Boban Marjanovic  7000000
    ## 150       Frank Kaminsky  2730000
    ## 157        Miles Plumlee 12500000
    ## 165          Joakim Noah 17000000
    ## 168         Kyle O'Quinn  3900000
    ## 170     Marshall Plumlee   543471
    ## 175    Willy Hernangomez  1375000
    ## 177      Bismack Biyombo 17000000
    ## 187       Nikola Vucevic 11750000
    ## 189    Stephen Zimmerman   950000
    ## 194        Jahlil Okafor  4788840
    ## 196          Joel Embiid  4826160
    ## 199       Richaun Holmes  1025831
    ## 202           Shawn Long    89513
    ## 204       Tiago Splitter  8550000
    ## 208          Brook Lopez 21165675
    ## 213      Justin Hamilton  3000000
    ## 222         Damian Jones  1171560
    ## 223           David West  1551659
    ## 227         JaVale McGee  1403611
    ## 229         Kevon Looney  1182840
    ## 235        Zaza Pachulia  2898000
    ## 241       Dewayne Dedmon  2898000
    ## 242         Joel Anthony   165952
    ## 249            Pau Gasol 15500000
    ## 252       Chinanu Onuaku   543471
    ## 253         Clint Capela  1296240
    ## 259     Montrezl Harrell  1000000
    ## 271       DeAndre Jordan 21165675
    ## 272        Diamond Stone   543471
    ## 276    Marreese Speights  1403611
    ## 286          Jeff Withey  1015696
    ## 292          Rudy Gobert  2121288
    ## 299          Enes Kanter 17145838
    ## 307         Steven Adams  3140517
    ## 313        Deyonta Davis  1369229
    ## 317           Marc Gasol 21165675
    ## 332         Jusuf Nurkic  1921320
    ## 348        Mason Plumlee  2328530
    ## 350         Nikola Jokic  1358500
    ## 351          Roy Hibbert  5000000
    ## 354        Alexis Ajinca  4600000
    ## 355        Anthony Davis 22116750
    ## 359     DeMarcus Cousins 16957900
    ## 364            Omer Asik  9904494
    ## 368         A.J. Hammons   650000
    ## 373        Dwight Powell  8375000
    ## 377         Nerlens Noel  4384490
    ## 379          Salah Mejri   874636
    ## 389 Georgios Papagiannis  2202240
    ## 390         Kosta Koufos  8046500
    ## 397  Willie Cauley-Stein  3551160
    ## 401         Cole Aldrich  7643979
    ## 403          Jordan Hill  3911380
    ## 404   Karl-Anthony Towns  5960160
    ## 416          Ivica Zubac  1034956
    ## 423          Tarik Black  6191000
    ## 425       Timofey Mozgov 16000000
    ## 427        Alan Williams   874636
    ## 428             Alex Len  4823621
    ## 441       Tyson Chandler 12415000

Create a data frame durant with Kevin Durant’s information (i.e. row).

``` r
which(dat$player == "Kevin Durant")
```

    ## [1] 228

``` r
durant <- as.data.frame(dat[228,])
durant
```

    ##           player team position height weight age experience
    ## 228 Kevin Durant  GSW       SF     81    240  28          9
    ##                           college   salary games minutes points points3 points2
    ## 228 University of Texas at Austin 26540100    62    2070   1555     117     434
    ##     points1
    ## 228     336

Create a data frame ucla with the data of players from college UCLA
(“University of California, Los
Angeles”).

``` r
ucla <- as.data.frame(dat[c(which(dat$college == "University of California, Los Angeles")),])
```

Create a data frame rookies with those players with 0 years of
experience.

``` r
rookies <- as.data.frame(dat[which(dat$experience == 0), ])
```

Create a data frame rookie\_centers with the data of Center rookie
players.

``` r
rookie_centers <- as.data.frame(dat[which(dat$experience == 0 & dat$position == "C"),])
```

Create a data frame top\_players for players with more than 50 games and
more than 100 minutes
played.

``` r
top_players <- as.data.frame(dat[which(dat$games > 50 & dat$minutes > 100),])
```

What’s the largest height value?

``` r
max(dat$height)
```

    ## [1] 87

What’s the minimum height value?

``` r
min(dat$height)
```

    ## [1] 69

What’s the overall average height?

``` r
mean(dat$height, na.rm = TRUE)
```

    ## [1] 79.1542

Who is the tallest player?

``` r
dat$player[which.max(dat$height)]
```

    ## [1] "Edy Tavares"

Who is the shortest player?

``` r
dat$player[which.min(dat$height)]
```

    ## [1] "Isaiah Thomas"

Which are the unique
    teams?

``` r
count(dat$team)[,1]
```

    ##  [1] "ATL" "BOS" "BRK" "CHI" "CHO" "CLE" "DAL" "DEN" "DET" "GSW" "HOU" "IND"
    ## [13] "LAC" "LAL" "MEM" "MIA" "MIL" "MIN" "NOP" "NYK" "OKC" "ORL" "PHI" "PHO"
    ## [25] "POR" "SAC" "SAS" "TOR" "UTA" "WAS"

How many different teams?

``` r
nrow(count(dat$team))
```

    ## [1] 30

Who is the oldest player?

``` r
dat$player[which.max(dat$age)]
```

    ## [1] "Vince Carter"

What is the median salary of all players?

``` r
median(dat$salary)
```

    ## [1] 3500000

What is the median salary of the players with 10 years of experience or
more?

``` r
experience <- dat[dat$experience > 10 | dat$experience == 10, ]
median(experience$salary)
```

    ## [1] 5644034

What is the median salary of Shooting Guards (SG) and Point Guards (PG)?

``` r
sgpg <- dat[dat$position == "SG" | dat$position == "PG", ]
median(sgpg$salary)
```

    ## [1] 3230690

What is the median salary of Power Forwards (PF), 29 years or older, and
74 inches tall or
less?

``` r
dat[dat$position == "PF" & dat$age > 29 & dat$height < 74 | dat$position == "PF" & dat$age > 29 & dat$height == 74 | dat$position == "PF" & dat$age == 29 & dat$height == 74 | dat$position == "PF" & dat$age == 29 & dat$height < 74,]
```

    ##  [1] player     team       position   height     weight     age       
    ##  [7] experience college    salary     games      minutes    points    
    ## [13] points3    points2    points1   
    ## <0 rows> (or 0-length row.names)

No player matches the criteria

How many players scored 4 points or less?

``` r
length(dat[dat$points == 4 | dat$points < 4, ])
```

    ## [1] 15

Who are those players who scored 4 points or
    less?

``` r
dat[dat$points == 4 | dat$points < 4, ][,1]
```

    ## [1] "Chris McCullough" "Michael Gbinije"  "Patricio Garino"  "Isaiah Taylor"   
    ## [5] "Brice Johnson"    "Roy Hibbert"      "Elijah Millsap"

Who is the player with 0 points?

``` r
dat[dat$points == 0,][,1]
```

    ## [1] "Patricio Garino"

How many players are from “University of California, Berkeley”?

``` r
length(dat[dat$college == "University of California, Berkeley"])
```

    ## [1] 0

Are there any players from “University of Notre Dame”? If so how many
and who are they?

``` r
dat[dat$college == "University of Notre Dame", ][,1]
```

    ## [1] "Demetrius Jackson" "Jerian Grant"      "Pat Connaughton"

``` r
length(dat[dat$college == "University of Notre Dame", ][,1])
```

    ## [1] 3

Are there any players with weight greater than 260 pounds? If so how
many and who are they?

``` r
dat[dat$weight > 260, ][,1]
```

    ##  [1] "Jonas Valanciunas" "Dwight Howard"     "Greg Monroe"      
    ##  [4] "Al Jefferson"      "Kevin Seraphin"    "Cristiano Felicio"
    ##  [7] "Hassan Whiteside"  "Andre Drummond"    "Boban Marjanovic" 
    ## [10] "Jahlil Okafor"     "Brook Lopez"       "JaVale McGee"     
    ## [13] "Zaza Pachulia"     "DeAndre Jordan"    "Derrick Favors"   
    ## [16] "Jusuf Nurkic"      "Roy Hibbert"       "DeMarcus Cousins" 
    ## [19] "Kosta Koufos"      "Ivica Zubac"       "Timofey Mozgov"

``` r
length(dat[dat$weight > 260, ][,1])
```

    ## [1] 21

Who is the player with the maximum rate of points per minute?

``` r
dat[ which.max(dat$points/60),][,1]
```

    ## [1] "Russell Westbrook"

Who is the player with the maximum rate of three-points per minute?

``` r
dat[ which.max(dat$points3/60),][,1]
```

    ## [1] "Stephen Curry"

Who is the player with the maximum rate of two-points per minute?

``` r
dat[ which.max(dat$points2/60),][,1]
```

    ## [1] "Anthony Davis"

Who is the player with the maximum rate of one-points (free-throws) per
minute?

``` r
dat[ which.max(dat$points1/60),][,1]
```

    ## [1] "James Harden"

Create a data frame gsw with the name, height, weight of Golden State
Warriors (GSW)

``` r
gsw <- dat[,c("player","height", "weight")]
```

Display the data in gsw sorted by height in increasing order (hint: see
?sort and ?order)

``` r
gsw[order(gsw$height),]
```

    ##                       player height weight
    ## 6              Isaiah Thomas     69    185
    ## 24                Kay Felder     69    176
    ## 440               Tyler Ulis     70    150
    ## 395                Ty Lawson     71    195
    ## 36             Fred VanVleet     72    195
    ## 39                Kyle Lowry     72    205
    ## 88              Aaron Brooks     72    161
    ## 108            Isaiah Canaan     72    201
    ## 137                Ish Smith     72    175
    ## 179            D.J. Augustin     72    183
    ## 248              Patty Mills     72    185
    ## 270               Chris Paul     72    175
    ## 344            Jameer Nelson     72    190
    ## 375               J.J. Barea     72    185
    ## 382             Yogi Ferrell     72    180
    ## 387          Darren Collison     72    175
    ## 4          Demetrius Jackson     73    201
    ## 48          Brandon Jennings     73    170
    ## 59                Trey Burke     73    191
    ## 61           Dennis Schroder     73    172
    ## 115              Rajon Rondo     73    186
    ## 146            Brian Roberts     73    173
    ## 153             Kemba Walker     73    172
    ## 258             Lou Williams     73    175
    ## 260         Patrick Beverley     73    185
    ## 278           Raymond Felton     73    205
    ## 290                Raul Neto     73    179
    ## 318              Mike Conley     73    175
    ## 337           Shabazz Napier     73    175
    ## 367              Tim Frazier     73    170
    ## 434             Eric Bledsoe     73    190
    ## 3              Avery Bradley     74    180
    ## 14              Terry Rozier     74    190
    ## 77               Jason Terry     74    185
    ## 92               Jeff Teague     74    186
    ## 93                 Joe Young     74    180
    ## 147            Briante Weber     74    165
    ## 162           Chasson Randle     74    185
    ## 178              C.J. Watson     74    175
    ## 203           T.J. McConnell     74    200
    ## 250              Tony Parker     74    185
    ## 251              Bobby Brown     74    175
    ## 304              Norris Cole     74    175
    ## 365               Quinn Cook     74    184
    ## 380               Seth Curry     74    185
    ## 391        Langston Galloway     74    200
    ## 410               Tyus Jones     74    195
    ## 438             Ronnie Price     74    190
    ## 18            Deron Williams     75    200
    ## 27              Kyrie Irving     75    193
    ## 32               Cory Joseph     75    193
    ## 64             Jose Calderon     75    200
    ## 67           Malcolm Delaney     75    190
    ## 97               Monta Ellis     75    185
    ## 104            Cameron Payne     75    185
    ## 118             Goran Dragic     75    190
    ## 133               Beno Udrih     75    205
    ## 143           Reggie Jackson     75    208
    ## 159           Ramon Sessions     75    190
    ## 164             Derrick Rose     75    190
    ## 195           Jerryd Bayless     75    200
    ## 201         Sergio Rodriguez     75    176
    ## 211               Jeremy Lin     75    200
    ## 225                Ian Clark     75    175
    ## 234            Stephen Curry     75    190
    ## 236              Bryn Forbes     75    190
    ## 255            Isaiah Taylor     75    170
    ## 284              George Hill     75    188
    ## 293             Shelvin Mack     75    203
    ## 305        Russell Westbrook     75    200
    ## 306           Semaj Christon     75    190
    ## 328           Damian Lillard     75    195
    ## 370             Devin Harris     75    192
    ## 426              Tyler Ennis     75    194
    ## 429           Brandon Knight     75    189
    ## 436          Leandro Barbosa     75    194
    ## 13              Marcus Smart     76    220
    ## 41             Norman Powell     76    215
    ## 53                 John Wall     76    195
    ## 81       Matthew Dellavedova     76    198
    ## 107              Dwyane Wade     76    220
    ## 109             Jerian Grant     76    195
    ## 117             Dion Waiters     76    225
    ## 126          Rodney McGruder     76    205
    ## 127            Tyler Johnson     76    186
    ## 129          Wayne Ellington     76    200
    ## 173                Ron Baker     76    220
    ## 181            Elfrid Payton     76    185
    ## 184              Jodie Meeks     76    210
    ## 210         Isaiah Whitehead     76    213
    ## 216               Randy Foye     76    213
    ## 218          Sean Kilpatrick     76    210
    ## 254              Eric Gordon     76    215
    ## 266            Austin Rivers     76    200
    ## 273              J.J. Redick     76    190
    ## 309           Victor Oladipo     76    210
    ## 319               Tony Allen     76    213
    ## 320             Troy Daniels     76    205
    ## 322             Wade Baldwin     76    202
    ## 327            C.J. McCollum     76    200
    ## 342              Gary Harris     76    210
    ## 343             Jamal Murray     76    207
    ## 361            E'Twaun Moore     76    191
    ## 362          Jordan Crawford     76    195
    ## 363             Jrue Holiday     76    205
    ## 386              Buddy Hield     76    214
    ## 405                Kris Dunn     76    210
    ## 408              Ricky Rubio     76    194
    ## 415              David Nwaba     76    209
    ## 21             Iman Shumpert     77    220
    ## 33              Delon Wright     77    183
    ## 47              Bradley Beal     77    207
    ## 57         Sheldon McClellan     77    200
    ## 65             Kent Bazemore     77    201
    ## 80           Malcolm Brogdon     77    215
    ## 95          Lance Stephenson     77    230
    ## 102           Anthony Morrow     77    210
    ## 139 Kentavious Caldwell-Pope     77    205
    ## 151              Jeremy Lamb     77    185
    ## 154          Marco Belinelli     77    210
    ## 163             Courtney Lee     77    200
    ## 185      Marcus Georges-Hunt     77    216
    ## 193         Gerald Henderson     77    215
    ## 207           Archie Goodwin     77    200
    ## 240          Dejounte Murray     77    170
    ## 256             James Harden     77    220
    ## 274           Jamal Crawford     77    200
    ## 323             Wayne Selden     77    230
    ## 336          Pat Connaughton     77    206
    ## 341          Emmanuel Mudiay     77    200
    ## 347            Malik Beasley     77    196
    ## 381          Wesley Matthews     77    220
    ## 384            Arron Afflalo     77    210
    ## 385             Ben McLemore     77    195
    ## 411              Zach LaVine     77    189
    ## 414         D'Angelo Russell     77    195
    ## 417          Jordan Clarkson     77    194
    ## 7                Jae Crowder     78    235
    ## 8                James Young     78    215
    ## 17             Dahntay Jones     78    225
    ## 22                J.R. Smith     78    225
    ## 42               P.J. Tucker     78    245
    ## 60           DeAndre' Bembry     78    210
    ## 73              Tim Hardaway     78    205
    ## 84             Rashad Vaughn     78    202
    ## 90                C.J. Miles     78    225
    ## 106         Denzel Valentine     78    212
    ## 112  Michael Carter-Williams     78    190
    ## 122          Josh Richardson     78    200
    ## 135          Darrun Hilliard     78    205
    ## 160           Treveon Graham     78    220
    ## 166           Justin Holiday     78    185
    ## 188          Patricio Garino     78    210
    ## 197          Justin Anderson     78    228
    ## 198             Nik Stauskas     78    205
    ## 205  Timothe Luwawu-Cabarrot     78    205
    ## 212               Joe Harris     78    219
    ## 214           K.J. McDaniels     78    205
    ## 219        Spencer Dinwiddie     78    200
    ## 221           Andre Iguodala     78    215
    ## 237              Danny Green     78    215
    ## 243         Jonathon Simmons     78    195
    ## 247            Manu Ginobili     78    205
    ## 265            Alan Anderson     78    220
    ## 280               Alec Burks     78    214
    ## 282               Dante Exum     78    190
    ## 295             Alex Abrines     78    190
    ## 310          Andrew Harrison     78    213
    ## 321             Vince Carter     78    220
    ## 326             Allen Crabbe     78    210
    ## 338           Tim Quarterman     78    195
    ## 352              Will Barton     78    175
    ## 369          DeAndre Liggins     78    209
    ## 388           Garrett Temple     78    195
    ## 392       Malachi Richardson     78    205
    ## 396             Tyreke Evans     78    220
    ## 400             Brandon Rush     78    220
    ## 409         Shabazz Muhammad     78    223
    ## 421        Metta World Peace     78    260
    ## 431             Devin Booker     78    206
    ## 433           Elijah Millsap     78    225
    ## 5               Gerald Green     79    205
    ## 9               Jaylen Brown     79    225
    ## 26               Kyle Korver     79    212
    ## 29         Richard Jefferson     79    233
    ## 34             DeMar DeRozan     79    221
    ## 58          Tomas Satoransky     79    210
    ## 72           Thabo Sefolosha     79    220
    ## 87                Tony Snell     79    200
    ## 110             Jimmy Butler     79    220
    ## 123          Justise Winslow     79    225
    ## 141          Michael Gbinije     79    200
    ## 142           Reggie Bullock     79    205
    ## 144          Stanley Johnson     79    245
    ## 156   Michael Kidd-Gilchrist     79    232
    ## 174            Sasha Vujacic     79    195
    ## 182            Evan Fournier     79    205
    ## 190            Terrence Ross     79    206
    ## 191           Alex Poythress     79    238
    ## 209             Caris LeVert     79    203
    ## 215               Quincy Acy     79    240
    ## 217  Rondae Hollis-Jefferson     79    220
    ## 224           Draymond Green     79    230
    ## 230            Klay Thompson     79    215
    ## 231              Matt Barnes     79    226
    ## 232            Patrick McCaw     79    185
    ## 233         Shaun Livingston     79    192
    ## 244            Kawhi Leonard     79    230
    ## 264            Troy Williams     79    218
    ## 277              Paul Pierce     79    235
    ## 279           Wesley Johnson     79    215
    ## 288              Joe Johnson     79    240
    ## 296           Andre Roberson     79    210
    ## 301             Josh Huestis     79    230
    ## 314              James Ennis     79    210
    ## 330              Evan Turner     79    220
    ## 356             Axel Toupane     79    197
    ## 366             Solomon Hill     79    225
    ## 378         Nicolas Brussino     79    195
    ## 422               Nick Young     79    210
    ## 430            Derrick Jones     79    190
    ## 435             Jared Dudley     79    225
    ## 11             Jordan Mickey     80    235
    ## 19          Derrick Williams     80    240
    ## 23               James Jones     80    218
    ## 28              LeBron James     80    250
    ## 35           DeMarre Carroll     80    215
    ## 46          Bojan Bogdanovic     80    216
    ## 56               Otto Porter     80    198
    ## 70              Paul Millsap     80    246
    ## 76             Jabari Parker     80    250
    ## 79           Khris Middleton     80    234
    ## 91             Georges Niang     80    230
    ## 101           Thaddeus Young     80    221
    ## 114              Paul Zipser     80    215
    ## 125              Okaro White     80    204
    ## 128            Udonis Haslem     80    235
    ## 158            Nicolas Batum     80    200
    ## 161          Carmelo Anthony     80    240
    ## 169             Lance Thomas     80    235
    ## 186            Mario Hezonja     80    215
    ## 220            Trevor Booker     80    228
    ## 259         Montrezl Harrell     80    240
    ## 263             Trevor Ariza     80    215
    ## 268             Brandon Bass     80    250
    ## 275         Luc Mbah a Moute     80    230
    ## 281               Boris Diaw     80    250
    ## 285           Gordon Hayward     80    226
    ## 287               Joe Ingles     80    226
    ## 291              Rodney Hood     80    206
    ## 298           Doug McDermott     80    225
    ## 300             Jerami Grant     80    210
    ## 302             Kyle Singler     80    228
    ## 346           Kenneth Faried     80    228
    ## 349              Mike Miller     80    218
    ## 353          Wilson Chandler     80    225
    ## 358         Dante Cunningham     80    230
    ## 372      Dorian Finney-Smith     80    220
    ## 374          Harrison Barnes     80    210
    ## 383         Anthony Tolliver     80    240
    ## 393                 Rudy Gay     80    230
    ## 399           Andrew Wiggins     80    199
    ## 427            Alan Williams     80    260
    ## 439              T.J. Warren     80    230
    ## 2               Amir Johnson     81    240
    ## 30          Tristan Thompson     81    238
    ## 31             Bruno Caboclo     81    218
    ## 43             Pascal Siakam     81    230
    ## 44         Patrick Patterson     81    230
    ## 66            Kris Humphries     81    235
    ## 68             Mike Dunleavy     81    230
    ## 82           Michael Beasley     81    235
    ## 83           Mirza Teletovic     81    242
    ## 94            Kevin Seraphin     81    285
    ## 96               Lavoy Allen     81    260
    ## 99               Paul George     81    220
    ## 100         Rakeem Christmas     81    250
    ## 120            James Johnson     81    250
    ## 124             Luke Babbitt     81    225
    ## 140            Marcus Morris     81    235
    ## 145            Tobias Harris     81    235
    ## 152          Johnny O'Bryant     81    257
    ## 155          Marvin Williams     81    237
    ## 171            Maurice Ndour     81    200
    ## 172     Mindaugas Kuzminskas     81    215
    ## 176             Aaron Gordon     81    220
    ## 177          Bismack Biyombo     81    255
    ## 183               Jeff Green     81    235
    ## 200         Robert Covington     81    215
    ## 202               Shawn Long     81    255
    ## 206         Andrew Nicholson     81    250
    ## 223               David West     81    250
    ## 226     James Michael McAdoo     81    230
    ## 228             Kevin Durant     81    240
    ## 229             Kevon Looney     81    220
    ## 238                David Lee     81    245
    ## 242             Joel Anthony     81    245
    ## 245            Kyle Anderson     81    230
    ## 262               Sam Dekker     81    230
    ## 289            Joel Bolomboy     81    235
    ## 308               Taj Gibson     81    225
    ## 315           JaMychal Green     81    227
    ## 324            Zach Randolph     81    260
    ## 325          Al-Farouq Aminu     81    220
    ## 331              Jake Layman     81    210
    ## 333         Maurice Harkless     81    215
    ## 340           Darrell Arthur     81    235
    ## 345         Juan Hernangomez     81    230
    ## 357            Cheick Diallo     81    220
    ## 376            Jarrod Uthoff     81    221
    ## 407              Omri Casspi     81    225
    ## 412           Brandon Ingram     81    190
    ## 413             Corey Brewer     81    186
    ## 418            Julius Randle     81    250
    ## 419          Larry Nance Jr.     81    230
    ## 420                Luol Deng     81    220
    ## 423              Tarik Black     81    250
    ## 1                 Al Horford     82    245
    ## 10             Jonas Jerebko     82    231
    ## 25                Kevin Love     82    251
    ## 45               Serge Ibaka     82    235
    ## 55           Markieff Morris     82    245
    ## 63            Ersan Ilyasova     82    235
    ## 89              Al Jefferson     82    289
    ## 105        Cristiano Felicio     82    275
    ## 113           Nikola Mirotic     82    220
    ## 121           Josh McRoberts     82    240
    ## 130              Willie Reed     82    220
    ## 132              Aron Baynes     82    260
    ## 138                Jon Leuer     82    228
    ## 168             Kyle O'Quinn     82    250
    ## 180             Damjan Rudez     82    228
    ## 192              Dario Saric     82    223
    ## 199           Richaun Holmes     82    245
    ## 239            Davis Bertans     82    210
    ## 252           Chinanu Onuaku     82    245
    ## 253             Clint Capela     82    240
    ## 257             Kyle Wiltjer     82    240
    ## 261            Ryan Anderson     82    240
    ## 267            Blake Griffin     82    251
    ## 269            Brice Johnson     82    230
    ## 276        Marreese Speights     82    255
    ## 283           Derrick Favors     82    265
    ## 294               Trey Lyles     82    234
    ## 303            Nick Collison     82    255
    ## 311           Brandan Wright     82    210
    ## 312         Chandler Parsons     82    230
    ## 316            Jarell Martin     82    239
    ## 329                 Ed Davis     82    240
    ## 335              Noah Vonleh     82    240
    ## 339         Danilo Gallinari     82    225
    ## 350             Nikola Jokic     82    250
    ## 355            Anthony Davis     82    253
    ## 398            Adreian Payne     82    237
    ## 403              Jordan Hill     82    235
    ## 406          Nemanja Bjelica     82    240
    ## 424          Thomas Robinson     82    237
    ## 437          Marquese Chriss     82    233
    ## 16             Channing Frye     83    255
    ## 49          Chris McCullough     83    200
    ## 50             Daniel Ochefu     83    245
    ## 51               Ian Mahinmi     83    250
    ## 54             Marcin Gortat     83    240
    ## 62             Dwight Howard     83    265
    ## 69              Mike Muscala     83    240
    ## 71                Ryan Kelly     83    230
    ## 74     Giannis Antetokounmpo     83    222
    ## 75               Greg Monroe     83    265
    ## 78               John Henson     83    229
    ## 98              Myles Turner     83    243
    ## 103             Bobby Portis     83    230
    ## 111        Joffrey Lauvergne     83    220
    ## 131           Andre Drummond     83    279
    ## 136           Henry Ellenson     83    245
    ## 148           Christian Wood     83    220
    ## 157            Miles Plumlee     83    249
    ## 165              Joakim Noah     83    230
    ## 175        Willy Hernangomez     83    240
    ## 194            Jahlil Okafor     83    275
    ## 204           Tiago Splitter     83    245
    ## 235            Zaza Pachulia     83    270
    ## 246        LaMarcus Aldridge     83    260
    ## 271           DeAndre Jordan     83    265
    ## 272            Diamond Stone     83    255
    ## 297         Domantas Sabonis     83    240
    ## 299              Enes Kanter     83    245
    ## 313            Deyonta Davis     83    237
    ## 348            Mason Plumlee     83    245
    ## 359         DeMarcus Cousins     83    270
    ## 373            Dwight Powell     83    240
    ## 377             Nerlens Noel     83    228
    ## 394          Skal Labissiere     83    225
    ## 401             Cole Aldrich     83    250
    ## 402             Gorgui Dieng     83    241
    ## 12              Kelly Olynyk     84    238
    ## 15              Tyler Zeller     84    253
    ## 37              Jakob Poeltl     84    248
    ## 38         Jonas Valanciunas     84    265
    ## 40            Lucas Nogueira     84    241
    ## 52               Jason Smith     84    245
    ## 116              Robin Lopez     84    255
    ## 119         Hassan Whiteside     84    265
    ## 149              Cody Zeller     84    240
    ## 150           Frank Kaminsky     84    242
    ## 170         Marshall Plumlee     84    250
    ## 187           Nikola Vucevic     84    260
    ## 189        Stephen Zimmerman     84    240
    ## 196              Joel Embiid     84    250
    ## 208              Brook Lopez     84    275
    ## 213          Justin Hamilton     84    260
    ## 222             Damian Jones     84    245
    ## 227             JaVale McGee     84    270
    ## 241           Dewayne Dedmon     84    245
    ## 249                Pau Gasol     84    250
    ## 286              Jeff Withey     84    231
    ## 307             Steven Adams     84    255
    ## 332             Jusuf Nurkic     84    280
    ## 360       Donatas Motiejunas     84    222
    ## 364                Omer Asik     84    255
    ## 368             A.J. Hammons     84    260
    ## 371            Dirk Nowitzki     84    245
    ## 390             Kosta Koufos     84    265
    ## 397      Willie Cauley-Stein     84    240
    ## 404       Karl-Anthony Towns     84    244
    ## 85             Spencer Hawes     85    245
    ## 86                Thon Maker     85    216
    ## 292              Rudy Gobert     85    245
    ## 317               Marc Gasol     85    255
    ## 334           Meyers Leonard     85    245
    ## 379              Salah Mejri     85    245
    ## 389     Georgios Papagiannis     85    240
    ## 416              Ivica Zubac     85    265
    ## 425           Timofey Mozgov     85    275
    ## 428                 Alex Len     85    260
    ## 432            Dragan Bender     85    225
    ## 441           Tyson Chandler     85    240
    ## 351              Roy Hibbert     86    270
    ## 354            Alexis Ajinca     86    248
    ## 20               Edy Tavares     87    260
    ## 134         Boban Marjanovic     87    290
    ## 167       Kristaps Porzingis     87    240

Display the data in gsw by weight in decreasing order (hint: see ?sort
and ?order)

``` r
gsw[order(gsw$height, decreasing = TRUE),]
```

    ##                       player height weight
    ## 20               Edy Tavares     87    260
    ## 134         Boban Marjanovic     87    290
    ## 167       Kristaps Porzingis     87    240
    ## 351              Roy Hibbert     86    270
    ## 354            Alexis Ajinca     86    248
    ## 85             Spencer Hawes     85    245
    ## 86                Thon Maker     85    216
    ## 292              Rudy Gobert     85    245
    ## 317               Marc Gasol     85    255
    ## 334           Meyers Leonard     85    245
    ## 379              Salah Mejri     85    245
    ## 389     Georgios Papagiannis     85    240
    ## 416              Ivica Zubac     85    265
    ## 425           Timofey Mozgov     85    275
    ## 428                 Alex Len     85    260
    ## 432            Dragan Bender     85    225
    ## 441           Tyson Chandler     85    240
    ## 12              Kelly Olynyk     84    238
    ## 15              Tyler Zeller     84    253
    ## 37              Jakob Poeltl     84    248
    ## 38         Jonas Valanciunas     84    265
    ## 40            Lucas Nogueira     84    241
    ## 52               Jason Smith     84    245
    ## 116              Robin Lopez     84    255
    ## 119         Hassan Whiteside     84    265
    ## 149              Cody Zeller     84    240
    ## 150           Frank Kaminsky     84    242
    ## 170         Marshall Plumlee     84    250
    ## 187           Nikola Vucevic     84    260
    ## 189        Stephen Zimmerman     84    240
    ## 196              Joel Embiid     84    250
    ## 208              Brook Lopez     84    275
    ## 213          Justin Hamilton     84    260
    ## 222             Damian Jones     84    245
    ## 227             JaVale McGee     84    270
    ## 241           Dewayne Dedmon     84    245
    ## 249                Pau Gasol     84    250
    ## 286              Jeff Withey     84    231
    ## 307             Steven Adams     84    255
    ## 332             Jusuf Nurkic     84    280
    ## 360       Donatas Motiejunas     84    222
    ## 364                Omer Asik     84    255
    ## 368             A.J. Hammons     84    260
    ## 371            Dirk Nowitzki     84    245
    ## 390             Kosta Koufos     84    265
    ## 397      Willie Cauley-Stein     84    240
    ## 404       Karl-Anthony Towns     84    244
    ## 16             Channing Frye     83    255
    ## 49          Chris McCullough     83    200
    ## 50             Daniel Ochefu     83    245
    ## 51               Ian Mahinmi     83    250
    ## 54             Marcin Gortat     83    240
    ## 62             Dwight Howard     83    265
    ## 69              Mike Muscala     83    240
    ## 71                Ryan Kelly     83    230
    ## 74     Giannis Antetokounmpo     83    222
    ## 75               Greg Monroe     83    265
    ## 78               John Henson     83    229
    ## 98              Myles Turner     83    243
    ## 103             Bobby Portis     83    230
    ## 111        Joffrey Lauvergne     83    220
    ## 131           Andre Drummond     83    279
    ## 136           Henry Ellenson     83    245
    ## 148           Christian Wood     83    220
    ## 157            Miles Plumlee     83    249
    ## 165              Joakim Noah     83    230
    ## 175        Willy Hernangomez     83    240
    ## 194            Jahlil Okafor     83    275
    ## 204           Tiago Splitter     83    245
    ## 235            Zaza Pachulia     83    270
    ## 246        LaMarcus Aldridge     83    260
    ## 271           DeAndre Jordan     83    265
    ## 272            Diamond Stone     83    255
    ## 297         Domantas Sabonis     83    240
    ## 299              Enes Kanter     83    245
    ## 313            Deyonta Davis     83    237
    ## 348            Mason Plumlee     83    245
    ## 359         DeMarcus Cousins     83    270
    ## 373            Dwight Powell     83    240
    ## 377             Nerlens Noel     83    228
    ## 394          Skal Labissiere     83    225
    ## 401             Cole Aldrich     83    250
    ## 402             Gorgui Dieng     83    241
    ## 1                 Al Horford     82    245
    ## 10             Jonas Jerebko     82    231
    ## 25                Kevin Love     82    251
    ## 45               Serge Ibaka     82    235
    ## 55           Markieff Morris     82    245
    ## 63            Ersan Ilyasova     82    235
    ## 89              Al Jefferson     82    289
    ## 105        Cristiano Felicio     82    275
    ## 113           Nikola Mirotic     82    220
    ## 121           Josh McRoberts     82    240
    ## 130              Willie Reed     82    220
    ## 132              Aron Baynes     82    260
    ## 138                Jon Leuer     82    228
    ## 168             Kyle O'Quinn     82    250
    ## 180             Damjan Rudez     82    228
    ## 192              Dario Saric     82    223
    ## 199           Richaun Holmes     82    245
    ## 239            Davis Bertans     82    210
    ## 252           Chinanu Onuaku     82    245
    ## 253             Clint Capela     82    240
    ## 257             Kyle Wiltjer     82    240
    ## 261            Ryan Anderson     82    240
    ## 267            Blake Griffin     82    251
    ## 269            Brice Johnson     82    230
    ## 276        Marreese Speights     82    255
    ## 283           Derrick Favors     82    265
    ## 294               Trey Lyles     82    234
    ## 303            Nick Collison     82    255
    ## 311           Brandan Wright     82    210
    ## 312         Chandler Parsons     82    230
    ## 316            Jarell Martin     82    239
    ## 329                 Ed Davis     82    240
    ## 335              Noah Vonleh     82    240
    ## 339         Danilo Gallinari     82    225
    ## 350             Nikola Jokic     82    250
    ## 355            Anthony Davis     82    253
    ## 398            Adreian Payne     82    237
    ## 403              Jordan Hill     82    235
    ## 406          Nemanja Bjelica     82    240
    ## 424          Thomas Robinson     82    237
    ## 437          Marquese Chriss     82    233
    ## 2               Amir Johnson     81    240
    ## 30          Tristan Thompson     81    238
    ## 31             Bruno Caboclo     81    218
    ## 43             Pascal Siakam     81    230
    ## 44         Patrick Patterson     81    230
    ## 66            Kris Humphries     81    235
    ## 68             Mike Dunleavy     81    230
    ## 82           Michael Beasley     81    235
    ## 83           Mirza Teletovic     81    242
    ## 94            Kevin Seraphin     81    285
    ## 96               Lavoy Allen     81    260
    ## 99               Paul George     81    220
    ## 100         Rakeem Christmas     81    250
    ## 120            James Johnson     81    250
    ## 124             Luke Babbitt     81    225
    ## 140            Marcus Morris     81    235
    ## 145            Tobias Harris     81    235
    ## 152          Johnny O'Bryant     81    257
    ## 155          Marvin Williams     81    237
    ## 171            Maurice Ndour     81    200
    ## 172     Mindaugas Kuzminskas     81    215
    ## 176             Aaron Gordon     81    220
    ## 177          Bismack Biyombo     81    255
    ## 183               Jeff Green     81    235
    ## 200         Robert Covington     81    215
    ## 202               Shawn Long     81    255
    ## 206         Andrew Nicholson     81    250
    ## 223               David West     81    250
    ## 226     James Michael McAdoo     81    230
    ## 228             Kevin Durant     81    240
    ## 229             Kevon Looney     81    220
    ## 238                David Lee     81    245
    ## 242             Joel Anthony     81    245
    ## 245            Kyle Anderson     81    230
    ## 262               Sam Dekker     81    230
    ## 289            Joel Bolomboy     81    235
    ## 308               Taj Gibson     81    225
    ## 315           JaMychal Green     81    227
    ## 324            Zach Randolph     81    260
    ## 325          Al-Farouq Aminu     81    220
    ## 331              Jake Layman     81    210
    ## 333         Maurice Harkless     81    215
    ## 340           Darrell Arthur     81    235
    ## 345         Juan Hernangomez     81    230
    ## 357            Cheick Diallo     81    220
    ## 376            Jarrod Uthoff     81    221
    ## 407              Omri Casspi     81    225
    ## 412           Brandon Ingram     81    190
    ## 413             Corey Brewer     81    186
    ## 418            Julius Randle     81    250
    ## 419          Larry Nance Jr.     81    230
    ## 420                Luol Deng     81    220
    ## 423              Tarik Black     81    250
    ## 11             Jordan Mickey     80    235
    ## 19          Derrick Williams     80    240
    ## 23               James Jones     80    218
    ## 28              LeBron James     80    250
    ## 35           DeMarre Carroll     80    215
    ## 46          Bojan Bogdanovic     80    216
    ## 56               Otto Porter     80    198
    ## 70              Paul Millsap     80    246
    ## 76             Jabari Parker     80    250
    ## 79           Khris Middleton     80    234
    ## 91             Georges Niang     80    230
    ## 101           Thaddeus Young     80    221
    ## 114              Paul Zipser     80    215
    ## 125              Okaro White     80    204
    ## 128            Udonis Haslem     80    235
    ## 158            Nicolas Batum     80    200
    ## 161          Carmelo Anthony     80    240
    ## 169             Lance Thomas     80    235
    ## 186            Mario Hezonja     80    215
    ## 220            Trevor Booker     80    228
    ## 259         Montrezl Harrell     80    240
    ## 263             Trevor Ariza     80    215
    ## 268             Brandon Bass     80    250
    ## 275         Luc Mbah a Moute     80    230
    ## 281               Boris Diaw     80    250
    ## 285           Gordon Hayward     80    226
    ## 287               Joe Ingles     80    226
    ## 291              Rodney Hood     80    206
    ## 298           Doug McDermott     80    225
    ## 300             Jerami Grant     80    210
    ## 302             Kyle Singler     80    228
    ## 346           Kenneth Faried     80    228
    ## 349              Mike Miller     80    218
    ## 353          Wilson Chandler     80    225
    ## 358         Dante Cunningham     80    230
    ## 372      Dorian Finney-Smith     80    220
    ## 374          Harrison Barnes     80    210
    ## 383         Anthony Tolliver     80    240
    ## 393                 Rudy Gay     80    230
    ## 399           Andrew Wiggins     80    199
    ## 427            Alan Williams     80    260
    ## 439              T.J. Warren     80    230
    ## 5               Gerald Green     79    205
    ## 9               Jaylen Brown     79    225
    ## 26               Kyle Korver     79    212
    ## 29         Richard Jefferson     79    233
    ## 34             DeMar DeRozan     79    221
    ## 58          Tomas Satoransky     79    210
    ## 72           Thabo Sefolosha     79    220
    ## 87                Tony Snell     79    200
    ## 110             Jimmy Butler     79    220
    ## 123          Justise Winslow     79    225
    ## 141          Michael Gbinije     79    200
    ## 142           Reggie Bullock     79    205
    ## 144          Stanley Johnson     79    245
    ## 156   Michael Kidd-Gilchrist     79    232
    ## 174            Sasha Vujacic     79    195
    ## 182            Evan Fournier     79    205
    ## 190            Terrence Ross     79    206
    ## 191           Alex Poythress     79    238
    ## 209             Caris LeVert     79    203
    ## 215               Quincy Acy     79    240
    ## 217  Rondae Hollis-Jefferson     79    220
    ## 224           Draymond Green     79    230
    ## 230            Klay Thompson     79    215
    ## 231              Matt Barnes     79    226
    ## 232            Patrick McCaw     79    185
    ## 233         Shaun Livingston     79    192
    ## 244            Kawhi Leonard     79    230
    ## 264            Troy Williams     79    218
    ## 277              Paul Pierce     79    235
    ## 279           Wesley Johnson     79    215
    ## 288              Joe Johnson     79    240
    ## 296           Andre Roberson     79    210
    ## 301             Josh Huestis     79    230
    ## 314              James Ennis     79    210
    ## 330              Evan Turner     79    220
    ## 356             Axel Toupane     79    197
    ## 366             Solomon Hill     79    225
    ## 378         Nicolas Brussino     79    195
    ## 422               Nick Young     79    210
    ## 430            Derrick Jones     79    190
    ## 435             Jared Dudley     79    225
    ## 7                Jae Crowder     78    235
    ## 8                James Young     78    215
    ## 17             Dahntay Jones     78    225
    ## 22                J.R. Smith     78    225
    ## 42               P.J. Tucker     78    245
    ## 60           DeAndre' Bembry     78    210
    ## 73              Tim Hardaway     78    205
    ## 84             Rashad Vaughn     78    202
    ## 90                C.J. Miles     78    225
    ## 106         Denzel Valentine     78    212
    ## 112  Michael Carter-Williams     78    190
    ## 122          Josh Richardson     78    200
    ## 135          Darrun Hilliard     78    205
    ## 160           Treveon Graham     78    220
    ## 166           Justin Holiday     78    185
    ## 188          Patricio Garino     78    210
    ## 197          Justin Anderson     78    228
    ## 198             Nik Stauskas     78    205
    ## 205  Timothe Luwawu-Cabarrot     78    205
    ## 212               Joe Harris     78    219
    ## 214           K.J. McDaniels     78    205
    ## 219        Spencer Dinwiddie     78    200
    ## 221           Andre Iguodala     78    215
    ## 237              Danny Green     78    215
    ## 243         Jonathon Simmons     78    195
    ## 247            Manu Ginobili     78    205
    ## 265            Alan Anderson     78    220
    ## 280               Alec Burks     78    214
    ## 282               Dante Exum     78    190
    ## 295             Alex Abrines     78    190
    ## 310          Andrew Harrison     78    213
    ## 321             Vince Carter     78    220
    ## 326             Allen Crabbe     78    210
    ## 338           Tim Quarterman     78    195
    ## 352              Will Barton     78    175
    ## 369          DeAndre Liggins     78    209
    ## 388           Garrett Temple     78    195
    ## 392       Malachi Richardson     78    205
    ## 396             Tyreke Evans     78    220
    ## 400             Brandon Rush     78    220
    ## 409         Shabazz Muhammad     78    223
    ## 421        Metta World Peace     78    260
    ## 431             Devin Booker     78    206
    ## 433           Elijah Millsap     78    225
    ## 21             Iman Shumpert     77    220
    ## 33              Delon Wright     77    183
    ## 47              Bradley Beal     77    207
    ## 57         Sheldon McClellan     77    200
    ## 65             Kent Bazemore     77    201
    ## 80           Malcolm Brogdon     77    215
    ## 95          Lance Stephenson     77    230
    ## 102           Anthony Morrow     77    210
    ## 139 Kentavious Caldwell-Pope     77    205
    ## 151              Jeremy Lamb     77    185
    ## 154          Marco Belinelli     77    210
    ## 163             Courtney Lee     77    200
    ## 185      Marcus Georges-Hunt     77    216
    ## 193         Gerald Henderson     77    215
    ## 207           Archie Goodwin     77    200
    ## 240          Dejounte Murray     77    170
    ## 256             James Harden     77    220
    ## 274           Jamal Crawford     77    200
    ## 323             Wayne Selden     77    230
    ## 336          Pat Connaughton     77    206
    ## 341          Emmanuel Mudiay     77    200
    ## 347            Malik Beasley     77    196
    ## 381          Wesley Matthews     77    220
    ## 384            Arron Afflalo     77    210
    ## 385             Ben McLemore     77    195
    ## 411              Zach LaVine     77    189
    ## 414         D'Angelo Russell     77    195
    ## 417          Jordan Clarkson     77    194
    ## 13              Marcus Smart     76    220
    ## 41             Norman Powell     76    215
    ## 53                 John Wall     76    195
    ## 81       Matthew Dellavedova     76    198
    ## 107              Dwyane Wade     76    220
    ## 109             Jerian Grant     76    195
    ## 117             Dion Waiters     76    225
    ## 126          Rodney McGruder     76    205
    ## 127            Tyler Johnson     76    186
    ## 129          Wayne Ellington     76    200
    ## 173                Ron Baker     76    220
    ## 181            Elfrid Payton     76    185
    ## 184              Jodie Meeks     76    210
    ## 210         Isaiah Whitehead     76    213
    ## 216               Randy Foye     76    213
    ## 218          Sean Kilpatrick     76    210
    ## 254              Eric Gordon     76    215
    ## 266            Austin Rivers     76    200
    ## 273              J.J. Redick     76    190
    ## 309           Victor Oladipo     76    210
    ## 319               Tony Allen     76    213
    ## 320             Troy Daniels     76    205
    ## 322             Wade Baldwin     76    202
    ## 327            C.J. McCollum     76    200
    ## 342              Gary Harris     76    210
    ## 343             Jamal Murray     76    207
    ## 361            E'Twaun Moore     76    191
    ## 362          Jordan Crawford     76    195
    ## 363             Jrue Holiday     76    205
    ## 386              Buddy Hield     76    214
    ## 405                Kris Dunn     76    210
    ## 408              Ricky Rubio     76    194
    ## 415              David Nwaba     76    209
    ## 18            Deron Williams     75    200
    ## 27              Kyrie Irving     75    193
    ## 32               Cory Joseph     75    193
    ## 64             Jose Calderon     75    200
    ## 67           Malcolm Delaney     75    190
    ## 97               Monta Ellis     75    185
    ## 104            Cameron Payne     75    185
    ## 118             Goran Dragic     75    190
    ## 133               Beno Udrih     75    205
    ## 143           Reggie Jackson     75    208
    ## 159           Ramon Sessions     75    190
    ## 164             Derrick Rose     75    190
    ## 195           Jerryd Bayless     75    200
    ## 201         Sergio Rodriguez     75    176
    ## 211               Jeremy Lin     75    200
    ## 225                Ian Clark     75    175
    ## 234            Stephen Curry     75    190
    ## 236              Bryn Forbes     75    190
    ## 255            Isaiah Taylor     75    170
    ## 284              George Hill     75    188
    ## 293             Shelvin Mack     75    203
    ## 305        Russell Westbrook     75    200
    ## 306           Semaj Christon     75    190
    ## 328           Damian Lillard     75    195
    ## 370             Devin Harris     75    192
    ## 426              Tyler Ennis     75    194
    ## 429           Brandon Knight     75    189
    ## 436          Leandro Barbosa     75    194
    ## 3              Avery Bradley     74    180
    ## 14              Terry Rozier     74    190
    ## 77               Jason Terry     74    185
    ## 92               Jeff Teague     74    186
    ## 93                 Joe Young     74    180
    ## 147            Briante Weber     74    165
    ## 162           Chasson Randle     74    185
    ## 178              C.J. Watson     74    175
    ## 203           T.J. McConnell     74    200
    ## 250              Tony Parker     74    185
    ## 251              Bobby Brown     74    175
    ## 304              Norris Cole     74    175
    ## 365               Quinn Cook     74    184
    ## 380               Seth Curry     74    185
    ## 391        Langston Galloway     74    200
    ## 410               Tyus Jones     74    195
    ## 438             Ronnie Price     74    190
    ## 4          Demetrius Jackson     73    201
    ## 48          Brandon Jennings     73    170
    ## 59                Trey Burke     73    191
    ## 61           Dennis Schroder     73    172
    ## 115              Rajon Rondo     73    186
    ## 146            Brian Roberts     73    173
    ## 153             Kemba Walker     73    172
    ## 258             Lou Williams     73    175
    ## 260         Patrick Beverley     73    185
    ## 278           Raymond Felton     73    205
    ## 290                Raul Neto     73    179
    ## 318              Mike Conley     73    175
    ## 337           Shabazz Napier     73    175
    ## 367              Tim Frazier     73    170
    ## 434             Eric Bledsoe     73    190
    ## 36             Fred VanVleet     72    195
    ## 39                Kyle Lowry     72    205
    ## 88              Aaron Brooks     72    161
    ## 108            Isaiah Canaan     72    201
    ## 137                Ish Smith     72    175
    ## 179            D.J. Augustin     72    183
    ## 248              Patty Mills     72    185
    ## 270               Chris Paul     72    175
    ## 344            Jameer Nelson     72    190
    ## 375               J.J. Barea     72    185
    ## 382             Yogi Ferrell     72    180
    ## 387          Darren Collison     72    175
    ## 395                Ty Lawson     71    195
    ## 440               Tyler Ulis     70    150
    ## 6              Isaiah Thomas     69    185
    ## 24                Kay Felder     69    176

Display the player name, team, and salary, of the top 5 highest-paid
players (hint: see ?sort and
?order)

``` r
head(dat[order(dat$salary, decreasing = TRUE),])[-5,c("player","team", "salary")]
```

    ##                player team   salary
    ## 28       LeBron James  CLE 30963450
    ## 1          Al Horford  BOS 26540100
    ## 34      DeMar DeRozan  TOR 26540100
    ## 228      Kevin Durant  GSW 26540100
    ## 305 Russell Westbrook  OKC 26540100

Display the player name, team, and points3, of the top 10 three-point
players (hint: see ?sort and
?order)

``` r
dat[order(dat$points3, decreasing = TRUE),][1:10,c("player","team","points3")]
```

    ##             player team points3
    ## 234  Stephen Curry  GSW     324
    ## 230  Klay Thompson  GSW     268
    ## 256   James Harden  HOU     262
    ## 254    Eric Gordon  HOU     246
    ## 6    Isaiah Thomas  BOS     245
    ## 153   Kemba Walker  CHO     240
    ## 47    Bradley Beal  WAS     223
    ## 328 Damian Lillard  POR     214
    ## 261  Ryan Anderson  HOU     204
    ## 273    J.J. Redick  LAC     201

# Group By

Group-by operations are very common in data analytics. Without dedicated
functions, these operations tend to be very hard (labor intensive).

So what functions can you use in R to perform group by operations? In
base R, the main function for group-by operations is aggregate().

Here’s an example using aggregate() to get the median salary, grouped by
team:

``` r
aggregate(dat$salary, by = list(dat$team), FUN = median)
```

    ##    Group.1       x
    ## 1      ATL 3279291
    ## 2      BOS 4743000
    ## 3      BRK 1790902
    ## 4      CHI 2112480
    ## 5      CHO 6000000
    ## 6      CLE 5239437
    ## 7      DAL 2898000
    ## 8      DEN 3500000
    ## 9      DET 4625000
    ## 10     GSW 1551659
    ## 11     HOU 1508400
    ## 12     IND 4000000
    ## 13     LAC 3500000
    ## 14     LAL 5281680
    ## 15     MEM 3332940
    ## 16     MIA 3449000
    ## 17     MIL 4184870
    ## 18     MIN 3650000
    ## 19     NOP 3789125
    ## 20     NYK 2898000
    ## 21     OKC 3140517
    ## 22     ORL 5000000
    ## 23     PHI 2318280
    ## 24     PHO 2941440
    ## 25     POR 4943123
    ## 26     SAC 5200000
    ## 27     SAS 2898000
    ## 28     TOR 5300000
    ## 29     UTA 2433334
    ## 30     WAS 4365326

The same example above can also be obtained with aggreagte() using
formula notation like this:

``` r
aggregate(salary ~ team, data = dat, FUN = median)
```

    ##    team  salary
    ## 1   ATL 3279291
    ## 2   BOS 4743000
    ## 3   BRK 1790902
    ## 4   CHI 2112480
    ## 5   CHO 6000000
    ## 6   CLE 5239437
    ## 7   DAL 2898000
    ## 8   DEN 3500000
    ## 9   DET 4625000
    ## 10  GSW 1551659
    ## 11  HOU 1508400
    ## 12  IND 4000000
    ## 13  LAC 3500000
    ## 14  LAL 5281680
    ## 15  MEM 3332940
    ## 16  MIA 3449000
    ## 17  MIL 4184870
    ## 18  MIN 3650000
    ## 19  NOP 3789125
    ## 20  NYK 2898000
    ## 21  OKC 3140517
    ## 22  ORL 5000000
    ## 23  PHI 2318280
    ## 24  PHO 2941440
    ## 25  POR 4943123
    ## 26  SAC 5200000
    ## 27  SAS 2898000
    ## 28  TOR 5300000
    ## 29  UTA 2433334
    ## 30  WAS 4365326

Here’s another example using aggregate() to get the average height and
average weight, grouped by
position:

``` r
aggregate(dat[ ,c('height', 'weight')], by = list(dat$position), FUN = mean)
```

    ##   Group.1   height   weight
    ## 1       C 83.25843 250.7978
    ## 2      PF 81.50562 235.8539
    ## 3      PG 74.30588 188.5765
    ## 4      SF 79.63855 220.4699
    ## 5      SG 77.02105 204.7684

The same example above can also be obtained with aggreagte() using
formula notation like
this:

``` r
aggregate(. ~ position, data = dat[ ,c('position', 'height', 'weight')], 
          FUN = mean)
```

    ##   position   height   weight
    ## 1        C 83.25843 250.7978
    ## 2       PF 81.50562 235.8539
    ## 3       PG 74.30588 188.5765
    ## 4       SF 79.63855 220.4699
    ## 5       SG 77.02105 204.7684

## Your turn

Create a data frame with the average height, average weight, and average
age, grouped by
position

``` r
aggregate(. ~ position, data = dat[ ,c('position', 'height', 'weight','age')], 
          FUN = mean)
```

    ##   position   height   weight      age
    ## 1        C 83.25843 250.7978 25.93258
    ## 2       PF 81.50562 235.8539 25.93258
    ## 3       PG 74.30588 188.5765 26.38824
    ## 4       SF 79.63855 220.4699 27.07229
    ## 5       SG 77.02105 204.7684 26.20000

Create a data frame with the average height, average weight, and average
age, grouped by team

``` r
aggregate(. ~ team, data = dat[ ,c('team', 'height', 'weight','age')], 
          FUN = mean)
```

    ##    team   height   weight      age
    ## 1   ATL 79.14286 219.9286 28.42857
    ## 2   BOS 78.20000 219.8667 25.26667
    ## 3   BRK 78.66667 222.4000 25.46667
    ## 4   CHI 78.53333 215.6000 25.80000
    ## 5   CHO 78.80000 212.8000 25.86667
    ## 6   CLE 78.86667 226.4000 29.60000
    ## 7   DAL 79.13333 215.6667 26.93333
    ## 8   DEN 79.40000 220.2667 25.80000
    ## 9   DET 79.53333 228.0000 25.46667
    ## 10  GSW 79.86667 223.5333 27.73333
    ## 11  HOU 78.28571 214.8571 25.64286
    ## 12  IND 78.50000 226.0714 27.00000
    ## 13  LAC 78.80000 225.0667 29.53333
    ## 14  LAL 80.00000 224.3333 25.53333
    ## 15  MEM 79.26667 221.7333 27.40000
    ## 16  MIA 79.00000 219.2857 26.71429
    ## 17  MIL 80.35714 224.1429 25.71429
    ## 18  MIN 79.71429 221.5714 25.07143
    ## 19  NOP 79.50000 218.9286 25.78571
    ## 20  NYK 80.00000 218.3333 26.60000
    ## 21  OKC 79.26667 219.2000 25.73333
    ## 22  ORL 78.93333 216.2000 25.20000
    ## 23  PHI 79.33333 225.0000 24.73333
    ## 24  PHO 78.53333 213.8000 25.40000
    ## 25  POR 79.42857 217.9286 24.21429
    ## 26  SAC 78.46667 216.6000 25.86667
    ## 27  SAS 79.13333 217.3333 28.86667
    ## 28  TOR 79.06667 222.6000 25.20000
    ## 29  UTA 79.46667 222.1333 26.20000
    ## 30  WAS 79.50000 215.1429 25.85714

Create a data frame with the average height, average weight, and average
age, grouped by team and
position.

``` r
aggregate(dat[ ,c('height', 'weight','age')], by = list(dat$position, dat$team), FUN = mean)
```

    ##     Group.1 Group.2   height   weight      age
    ## 1         C     ATL 83.00000 252.5000 28.00000
    ## 2        PF     ATL 81.50000 236.5000 29.00000
    ## 3        PG     ATL 74.33333 187.3333 28.33333
    ## 4        SF     ATL 78.75000 215.2500 29.25000
    ## 5        SG     ATL 78.00000 205.0000 24.00000
    ## 6         C     BOS 83.33333 245.3333 27.33333
    ## 7        PF     BOS 81.00000 235.3333 26.66667
    ## 8        PG     BOS 72.00000 192.0000 23.66667
    ## 9        SF     BOS 78.66667 221.6667 25.66667
    ## 10       SG     BOS 76.00000 205.0000 23.00000
    ## 11        C     BRK 84.00000 267.5000 27.00000
    ## 12       PF     BRK 80.00000 239.3333 27.33333
    ## 13       PG     BRK 76.33333 204.3333 24.00000
    ## 14       SF     BRK 78.66667 209.3333 22.33333
    ## 15       SG     BRK 76.75000 210.5000 26.75000
    ## 16        C     CHI 83.00000 250.0000 25.66667
    ## 17       PF     CHI 82.50000 225.0000 23.00000
    ## 18       PG     CHI 75.50000 189.0000 25.25000
    ## 19       SF     CHI 79.50000 217.5000 24.50000
    ## 20       SG     CHI 75.75000 210.7500 28.50000
    ## 21        C     CHO 83.50000 245.5000 25.50000
    ## 22       PF     CHO 82.25000 238.5000 24.50000
    ## 23       PG     CHO 73.75000 175.0000 27.75000
    ## 24       SF     CHO 79.00000 232.0000 23.00000
    ## 25       SG     CHO 78.00000 203.7500 26.25000
    ## 26        C     CLE 83.66667 251.0000 27.33333
    ## 27       PF     CLE 81.00000 245.5000 26.50000
    ## 28       PG     CLE 73.00000 189.6667 25.66667
    ## 29       SF     CLE 79.25000 231.5000 35.00000
    ## 30       SG     CLE 78.00000 219.0000 30.66667
    ## 31        C     DAL 83.75000 243.2500 25.25000
    ## 32       PF     DAL 81.25000 224.0000 27.00000
    ## 33       PG     DAL 73.25000 185.5000 28.50000
    ## 34       SF     DAL 79.00000 195.0000 23.00000
    ## 35       SG     DAL 77.50000 214.5000 29.00000
    ## 36        C     DEN 83.66667 255.0000 25.66667
    ## 37       PF     DEN 80.66667 231.0000 25.33333
    ## 38       PG     DEN 74.50000 195.0000 27.00000
    ## 39       SF     DEN 80.66667 222.6667 31.00000
    ## 40       SG     DEN 76.75000 197.0000 21.75000
    ## 41        C     DET 84.00000 276.3333 27.00000
    ## 42       PF     DET 82.00000 236.0000 23.66667
    ## 43       PG     DET 74.00000 196.0000 29.33333
    ## 44       SF     DET 79.66667 228.3333 24.00000
    ## 45       SG     DET 78.00000 203.3333 23.33333
    ## 46        C     GSW 82.60000 251.0000 27.60000
    ## 47       PF     GSW 80.00000 230.0000 25.00000
    ## 48       PG     GSW 77.00000 191.0000 29.50000
    ## 49       SF     GSW 79.33333 227.0000 32.33333
    ## 50       SG     GSW 77.66667 191.6667 24.00000
    ## 51        C     HOU 81.33333 241.6667 21.66667
    ## 52       PF     HOU 82.00000 240.0000 26.00000
    ## 53       PG     HOU 75.33333 188.3333 27.00000
    ## 54       SF     HOU 80.00000 221.0000 25.00000
    ## 55       SG     HOU 74.00000 191.6667 28.66667
    ## 56        C     IND 82.50000 266.0000 26.00000
    ## 57       PF     IND 80.60000 249.2000 26.00000
    ## 58       PG     IND 73.33333 175.6667 28.00000
    ## 59       SF     IND 79.50000 222.5000 27.50000
    ## 60       SG     IND 76.00000 207.5000 28.50000
    ## 61        C     LAC 82.66667 258.3333 25.33333
    ## 62       PF     LAC 81.33333 243.6667 26.66667
    ## 63       PG     LAC 72.50000 190.0000 31.50000
    ## 64       SF     LAC 79.00000 225.0000 33.00000
    ## 65       SG     LAC 76.33333 196.6667 30.66667
    ## 66        C     LAL 83.66667 263.3333 24.66667
    ## 67       PF     LAL 81.33333 239.0000 23.66667
    ## 68       PG     LAL 76.00000 194.5000 21.00000
    ## 69       SF     LAL 80.25000 214.0000 29.25000
    ## 70       SG     LAL 77.33333 204.3333 26.33333
    ## 71        C     MEM 84.00000 246.0000 26.00000
    ## 72       PF     MEM 81.50000 234.0000 28.00000
    ## 73       PG     MEM 75.66667 196.6667 23.66667
    ## 74       SF     MEM 79.66667 220.0000 31.33333
    ## 75       SG     MEM 76.33333 216.0000 27.33333
    ## 76        C     MIA 82.00000 240.0000 29.66667
    ## 77       PF     MIA 81.00000 231.3333 27.33333
    ## 78       PG     MIA 75.50000 188.0000 27.00000
    ## 79       SF     MIA 80.00000 225.0000 23.50000
    ## 80       SG     MIA 76.50000 207.5000 25.50000
    ## 81        C     MIL 83.66667 236.6667 23.66667
    ## 82       PF     MIL 81.75000 243.0000 27.00000
    ## 83       PG     MIL 76.00000 198.0000 26.00000
    ## 84       SF     MIL 81.50000 228.0000 23.50000
    ## 85       SG     MIL 77.00000 200.5000 27.00000
    ## 86        C     MIN 83.00000 243.0000 26.00000
    ## 87       PF     MIN 82.33333 239.3333 26.66667
    ## 88       PG     MIN 75.33333 199.6667 22.66667
    ## 89       SF     MIN 79.66667 215.6667 24.33333
    ## 90       SG     MIN 77.50000 204.5000 26.00000
    ## 91        C     NOP 83.75000 256.5000 26.75000
    ## 92       PF     NOP 82.50000 221.0000 23.00000
    ## 93       PG     NOP 74.33333 186.3333 25.00000
    ## 94       SF     NOP 79.33333 217.3333 26.00000
    ## 95       SG     NOP 76.00000 193.0000 27.50000
    ## 96        C     NYK 83.00000 242.5000 25.75000
    ## 97       PF     NYK 82.66667 225.0000 24.33333
    ## 98       PG     NYK 74.50000 187.5000 25.50000
    ## 99       SF     NYK 80.50000 227.5000 29.50000
    ## 100      SG     NYK 77.50000 200.0000 28.25000
    ## 101       C     OKC 83.50000 250.0000 23.50000
    ## 102      PF     OKC 81.25000 237.5000 28.00000
    ## 103      PG     OKC 74.66667 188.3333 26.66667
    ## 104      SF     OKC 79.75000 218.2500 25.00000
    ## 105      SG     OKC 77.00000 200.0000 23.50000
    ## 106       C     ORL 83.00000 251.6667 23.33333
    ## 107      PF     ORL 81.00000 235.0000 30.00000
    ## 108      PG     ORL 74.00000 181.0000 27.66667
    ## 109      SF     ORL 80.50000 217.2500 24.25000
    ## 110      SG     ORL 77.50000 210.2500 24.50000
    ## 111       C     PHI 82.60000 254.0000 24.40000
    ## 112      PF     PHI 80.50000 230.5000 22.50000
    ## 113      PG     PHI 74.66667 192.0000 27.33333
    ## 114      SF     PHI 79.00000 216.0000 23.33333
    ## 115      SG     PHI 77.50000 210.0000 26.00000
    ## 116       C     PHO 83.33333 253.3333 27.00000
    ## 117      PF     PHO 82.00000 227.6667 23.00000
    ## 118      PG     PHO 72.33333 176.6667 27.00000
    ## 119      SF     PHO 79.50000 210.0000 21.00000
    ## 120      SG     PHO 76.50000 203.5000 27.00000
    ## 121       C     POR 84.00000 280.0000 22.00000
    ## 122      PF     POR 83.00000 241.6667 24.00000
    ## 123      PG     POR 74.00000 185.0000 25.50000
    ## 124      SF     POR 80.50000 216.2500 24.75000
    ## 125      SG     POR 77.25000 202.7500 23.75000
    ## 126       C     SAC 84.33333 248.3333 23.00000
    ## 127      PF     SAC 81.50000 232.5000 25.50000
    ## 128      PG     SAC 72.33333 190.0000 27.66667
    ## 129      SF     SAC 79.00000 225.0000 28.50000
    ## 130      SG     SAC 77.20000 203.8000 25.60000
    ## 131       C     SAS 83.00000 246.6667 32.33333
    ## 132      PF     SAS 82.00000 238.3333 29.33333
    ## 133      PG     SAS 74.33333 180.0000 27.33333
    ## 134      SF     SAS 79.00000 230.0000 25.00000
    ## 135      SG     SAS 78.00000 207.0000 28.20000
    ## 136       C     TOR 84.00000 251.3333 23.00000
    ## 137      PF     TOR 81.33333 231.6667 25.33333
    ## 138      PG     TOR 73.66667 194.3333 25.33333
    ## 139      SF     TOR 79.66667 226.0000 27.33333
    ## 140      SG     TOR 76.66667 209.6667 25.00000
    ## 141       C     UTA 84.50000 238.0000 25.00000
    ## 142      PF     UTA 81.25000 246.0000 25.75000
    ## 143      PG     UTA 75.25000 190.0000 25.25000
    ## 144      SF     UTA 79.66667 230.6667 30.00000
    ## 145      SG     UTA 79.00000 210.0000 24.50000
    ## 146       C     WAS 83.25000 245.0000 28.75000
    ## 147      PF     WAS 82.50000 222.5000 24.00000
    ## 148      PG     WAS 74.00000 185.3333 25.66667
    ## 149      SF     WAS 80.00000 207.0000 25.00000
    ## 150      SG     WAS 77.66667 205.6667 24.00000

Difficult: Create a data frame with the minimum salary, median salary,
mean salary, and maximum salary, grouped by team and
position.

``` r
aggregate(dat[ ,c('salary')], by = list(dat$position, dat$team), FUN = function(x) c("min" =min(x), "median" = median(x), "mean" = mean(x), "max" = max(x)))
```

    ##     Group.1 Group.2      x.min   x.median     x.mean      x.max
    ## 1         C     ATL  1015696.0 12097985.5 12097985.5 23180275.0
    ## 2        PF     ATL   418228.0  6200000.0  8222565.2 20072033.0
    ## 3        PG     ATL   392478.0  2500000.0  1867020.0  2708582.0
    ## 4        SF     ATL  1499760.0  4343750.0  6479399.5 15730338.0
    ## 5        SG     ATL  2281605.0  2281605.0  2281605.0  2281605.0
    ## 6         C     BOS  3094014.0  8000000.0 12544704.7 26540100.0
    ## 7        PF     BOS  1223653.0  5000000.0  6074551.0 12000000.0
    ## 8        PG     BOS  1450000.0  1906440.0  3314524.0  6587132.0
    ## 9        SF     BOS  1410598.0  4743000.0  4146668.7  6286408.0
    ## 10       SG     BOS  1825200.0  3578880.0  4557914.3  8269663.0
    ## 11        C     BRK  3000000.0 12082837.5 12082837.5 21165675.0
    ## 12       PF     BRK  1790902.0  6088993.0  5709965.0  9250000.0
    ## 13       PG     BRK   726672.0  1074145.0  4428023.7 11483254.0
    ## 14       SF     BRK  1395600.0  1562280.0  2097071.0  3333333.0
    ## 15       SG     BRK   119494.0   980431.0  1145089.0  2500000.0
    ## 16        C     CHI   874636.0  1709720.0  5267868.7 13219250.0
    ## 17       PF     CHI  1453680.0  3618065.0  3618065.0  5782450.0
    ## 18       PG     CHI  1643040.0  2648003.0  5234761.5 14000000.0
    ## 19       SF     CHI   750000.0  9151104.5  9151104.5 17552209.0
    ## 20       SG     CHI  1015696.0  2790100.0  7448974.0 23200000.0
    ## 21        C     CHO  2730000.0  7615000.0  7615000.0 12500000.0
    ## 22       PF     CHO   161483.0  3096474.5  4651108.0 12250000.0
    ## 23       PG     CHO   102898.0  3525480.5  4788464.8 12000000.0
    ## 24       SF     CHO 13000000.0 13000000.0 13000000.0 13000000.0
    ## 25       SG     CHO   543471.0  6422480.5  8564499.5 20869566.0
    ## 26        C     CLE     5145.0  7806971.0  7714183.7 15330435.0
    ## 27       PF     CLE   268029.0 10716852.0 10716852.0 21165675.0
    ## 28       PG     CLE   259626.0   543471.0  6147053.3 17638063.0
    ## 29       SF     CLE    18255.0  2025829.5  8758341.0 30963450.0
    ## 30       SG     CLE  5239437.0  9700000.0  9246479.0 12800000.0
    ## 31        C     DAL   650000.0  2629563.0  3571031.5  8375000.0
    ## 32       PF     DAL    63938.0 11330110.5 11931039.8 25000000.0
    ## 33       PG     DAL   207798.0  3497475.0  2857687.0  4228000.0
    ## 34       SF     DAL   543471.0   543471.0   543471.0   543471.0
    ## 35       SG     DAL  1015696.0  9057848.0  9057848.0 17100000.0
    ## 36        C     DEN  1358500.0  2328530.0  2895676.7  5000000.0
    ## 37       PF     DEN  1987440.0  8070175.0  7378755.7 12078652.0
    ## 38       PG     DEN  3241800.0  3891162.5  3891162.5  4540525.0
    ## 39       SF     DEN  3500000.0 11200000.0  9916666.7 15050000.0
    ## 40       SG     DEN  1627320.0  2433360.0  2506843.2  3533333.0
    ## 41        C     DET  6500000.0  7000000.0 11872250.0 22116750.0
    ## 42       PF     DET  1704120.0 10991957.0  9965359.0 17200000.0
    ## 43       PG     DET  1551659.0  6000000.0  7502727.0 14956522.0
    ## 44       SF     DET  2255644.0  2969880.0  3283508.0  4625000.0
    ## 45       SG     DET   650000.0   874060.0  1734126.3  3678319.0
    ## 46        C     GSW  1171560.0  1403611.0  1641534.0  2898000.0
    ## 47       PF     GSW   980431.0  8155433.0  8155433.0 15330435.0
    ## 48       PG     GSW  5782450.0  8947404.5  8947404.5 12112359.0
    ## 49       SF     GSW   383351.0 11131368.0 12684939.7 26540100.0
    ## 50       SG     GSW   543471.0  1015696.0  6074247.3 16663575.0
    ## 51        C     HOU   543471.0  1000000.0   946570.3  1296240.0
    ## 52       PF     HOU   543471.0  9639417.5  9639417.5 18735364.0
    ## 53       PG     HOU   255000.0   680534.0  9158544.7 26540100.0
    ## 54       SF     HOU   150000.0  1720560.0  3225843.7  7806971.0
    ## 55       SG     HOU  6000000.0  7000000.0  8461788.0 12385364.0
    ## 56        C     IND  2463840.0  6347009.5  6347009.5 10230179.0
    ## 57       PF     IND   650000.0  1800000.0  4331198.8 14153652.0
    ## 58       PG     IND  1052342.0  2700000.0  4184114.0  8800000.0
    ## 59       SF     IND  4583450.0 11448991.0 11448991.0 18314532.0
    ## 60       SG     IND  4000000.0  7385000.0  7385000.0 10770000.0
    ## 61        C     LAC   543471.0  1403611.0  7704252.3 21165675.0
    ## 62       PF     LAC  1273920.0  1551659.0  7655472.3 20140838.0
    ## 63       PG     LAC  1551659.0 12210243.5 12210243.5 22868828.0
    ## 64       SF     LAC  1315448.0  2851500.0  3161612.0  5628000.0
    ## 65       SG     LAC  7377500.0 11000000.0 10543504.0 13253012.0
    ## 66        C     LAL  1034956.0  6191000.0  7741985.3 16000000.0
    ## 67       PF     LAL  1050961.0  1207680.0  1841920.3  3267120.0
    ## 68       PG     LAL  1733880.0  3533340.0  3533340.0  5332800.0
    ## 69       SF     LAL  1551659.0  6440840.0  8108334.8 18000000.0
    ## 70       SG     LAL    73528.0  5443918.0  6005815.3 12500000.0
    ## 71        C     MEM  1369229.0 11267452.0 11267452.0 21165675.0
    ## 72       PF     MEM   980431.0  3493080.0  4582009.0 10361445.0
    ## 73       PG     MEM   945000.0  1793760.0  9759620.0 26540100.0
    ## 74       SF     MEM  2898000.0  4264057.0  9759602.3 22116750.0
    ## 75       SG     MEM    83119.0  3332940.0  2973892.3  5505618.0
    ## 76        C     MIA  1015696.0  4000000.0  9044148.7 22116750.0
    ## 77       PF     MIA   210995.0  4000000.0  3331148.3  5782450.0
    ## 78       PG     MIA  5628000.0 10759000.0 10759000.0 15890000.0
    ## 79       SF     MIA  1227000.0  1910220.0  1910220.0  2593440.0
    ## 80       SG     MIA   543471.0  1886318.0  2579026.8  6000000.0
    ## 81        C     MIL  2568600.0 12517606.0 10728735.3 17100000.0
    ## 82       PF     MIL  1403611.0  5861539.5  5906672.5 10500000.0
    ## 83       PG     MIL  9607500.0  9607500.0  9607500.0  9607500.0
    ## 84       SF     MIL  2995421.0  9097710.5  9097710.5 15200000.0
    ## 85       SG     MIL   925000.0  1681349.5  1664006.5  2368327.0
    ## 86        C     MIN  3911380.0  5960160.0  5838506.3  7643979.0
    ## 87       PF     MIN  2022240.0  2348783.0  2723674.3  3800000.0
    ## 88       PG     MIN  1339680.0  3872520.0  6254066.7 13550000.0
    ## 89       SF     MIN   138414.0  3046299.0  3063771.0  6006600.0
    ## 90       SG     MIN  2240880.0  2870440.0  2870440.0  3500000.0
    ## 91        C     NOP  4600000.0 13431197.0 13394786.0 22116750.0
    ## 92       PF     NOP   543471.0   560097.5   560097.5   576724.0
    ## 93       PG     NOP    63938.0  2090000.0  4480152.0 11286518.0
    ## 94       SF     NOP    20580.0  2978250.0  4746682.7 11241218.0
    ## 95       SG     NOP   173094.0  4127228.5  4127228.5  8081363.0
    ## 96        C     NYK   543471.0  2637500.0  5704617.8 17000000.0
    ## 97       PF     NYK   543471.0  4317720.0  3684063.7  6191000.0
    ## 98       PG     NYK   143860.0 10733555.0 10733555.0 21323250.0
    ## 99       SF     NYK  2898000.0 13728690.0 13728690.0 24559380.0
    ## 100      SG     NYK   543471.0  1213147.0  3552941.2 11242000.0
    ## 101       C     OKC  3140517.0 10143177.5 10143177.5 17145838.0
    ## 102      PF     OKC  1191480.0  3095100.0  4082920.0  8950000.0
    ## 103      PG     OKC   247991.0   543471.0  9110520.7 26540100.0
    ## 104      SF     OKC   980431.0  2333056.0  2621010.8  4837500.0
    ## 105      SG     OKC  5994764.0  6273862.0  6273862.0  6552960.0
    ## 106       C     ORL   950000.0 11750000.0  9900000.0 17000000.0
    ## 107      PF     ORL 15000000.0 15000000.0 15000000.0 15000000.0
    ## 108      PG     ORL  2613600.0  5000000.0  4954533.3  7250000.0
    ## 109      SF     ORL   980431.0  4130580.0  4810397.8 10000000.0
    ## 110      SG     ORL    31969.0  3285984.5  5900984.5 17000000.0
    ## 111       C     PHI    89513.0  4788840.0  3856068.8  8550000.0
    ## 112      PF     PHI    31969.0  1175124.5  1175124.5  2318280.0
    ## 113      PG     PHI   874636.0  8000000.0  6099573.3  9424084.0
    ## 114      SF     PHI  1015696.0  1326960.0  1285605.3  1514160.0
    ## 115      SG     PHI  2993040.0  5996520.0  5996520.0  9000000.0
    ## 116       C     PHO   874636.0  4823621.0  6037752.3 12415000.0
    ## 117      PF     PHO  2941440.0  4276320.0  5895920.0 10470000.0
    ## 118      PG     PHO   282595.0   918369.0  5066988.0 14000000.0
    ## 119      SF     PHO   543471.0  1336195.5  1336195.5  2128920.0
    ## 120      SG     PHO    23069.0  3111800.0  4713229.8 12606250.0
    ## 121       C     POR  1921320.0  1921320.0  1921320.0  1921320.0
    ## 122      PF     POR  2751360.0  6666667.0  6210503.7  9213484.0
    ## 123      PG     POR  1350120.0 12839272.5 12839272.5 24328425.0
    ## 124      SF     POR   600000.0  8334864.5  8415793.0 16393443.0
    ## 125      SG     POR   543471.0  2047107.5  5784421.5 18500000.0
    ## 126       C     SAC  2202240.0  3551160.0  4599966.7  8046500.0
    ## 127      PF     SAC  1188840.0  4594420.0  4594420.0  8000000.0
    ## 128      PG     SAC  1315448.0  5200000.0  3914967.3  5229454.0
    ## 129      SF     SAC 10661286.0 11997309.5 11997309.5 13333333.0
    ## 130      SG     SAC  1439880.0  4008882.0  5893192.4 12500000.0
    ## 131       C     SAS   165952.0  2898000.0  6187984.0 15500000.0
    ## 132      PF     SAS   543471.0  1551659.0  7556711.7 20575005.0
    ## 133      PG     SAS  1180080.0  3578948.0  6401447.0 14445313.0
    ## 134      SF     SAS 17638063.0 17638063.0 17638063.0 17638063.0
    ## 135      SG     SAS   543471.0  1192080.0  5322037.4 14000000.0
    ## 136       C     TOR  1921320.0  2703960.0  6335767.3 14382022.0
    ## 137      PF     TOR  1196040.0  6050000.0  6498680.0 12250000.0
    ## 138      PG     TOR   543471.0  1577280.0  4706917.0 12000000.0
    ## 139      SF     TOR  1589640.0  5300000.0  7029880.0 14200000.0
    ## 140      SG     TOR   874636.0  7330000.0 11581578.7 26540100.0
    ## 141       C     UTA  1015696.0  1568492.0  1568492.0  2121288.0
    ## 142      PF     UTA   600000.0  4670300.0  5247650.0 11050000.0
    ## 143      PG     UTA   937800.0  3186827.0  3827863.5  8000000.0
    ## 144      SF     UTA  2250000.0 11000000.0  9774380.0 16073140.0
    ## 145      SG     UTA  1406520.0  5780507.5  5780507.5 10154495.0
    ## 146       C     WAS   543471.0  8500000.0  8371906.2 15944154.0
    ## 147      PF     WAS  1191480.0  4295740.0  4295740.0  7400000.0
    ## 148      PG     WAS  1200000.0  3386598.0  7181499.3 16957900.0
    ## 149      SF     WAS  3730653.0  4812317.0  4812317.0  5893981.0
    ## 150      SG     WAS   543471.0  2870813.0  8510344.7 22116750.0
