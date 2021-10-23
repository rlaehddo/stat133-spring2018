Lab 5: First contact with dplyr and ggplot2
================
Amy Kim

## Manipulating and Visualizing Data Frames

Last week you started to manipulate data tables (under the class of
“data.frame” objects) using bracket notation, dat\[ , \], and the
dollar operator, dat$name, in order to select specific rows, columns, or
cells. In addition, you have been creating charts with functions like
plot(), boxplot(), and barplot(), which are part of the “graphics”
package.

In this lab, you will start learning about other approaches to
manipulate tables and create statistical charts. We are going to use the
functionality of the package “dplyr” to work with tabular data in a more
consistent way. This is a fairly recent package introduced a couple of
years ago, but it is based on more than a decade of research and work
lead by Hadley Wickham.

Likewise, to create graphics in a more consistent and visually pleasing
way, we are going to use the package “ggplot2”, also originally authored
by Hadley Wickham, and developed as part of his PhD more than a decade
ago.

Use the first hour of the lab to get as far as possible with the
material associated to “dplyr”. Then use the second hour of the lab to
work on graphics with “ggplot2”.

## Filestructure and Shell Commands

We want you to keep practicing with the command line (e.g. Mac Terminal,
Gitbash). Follow the steps listed below to create the necessary
subdirectories like those depicted in this scheme:

``` r
#    lab05/
#      README.md
#      data/
#        nba2017-players.csv
#      report/
#        lab05.Rmd
#        lab05.html
#      images/
#        ... # all the plot files
```

  - Open a command line interface (e.g. Terminal or GitBash)

  - Change your working directory to a location where you will store all
    the materials for this lab

  - Use mkdir to create a directory lab05 for the lab materials

  - Use cd to change directory to (i.e. move inside) lab05

  - Create other subdirectories: data, report, images

  - Use ls to list the contents of lab05 and confirm that you have all
    the subdirectories.

  - Use touch to create an empty README.md text file

  - Use a text editor (e.g. the one in RStudio) to open the README.md
    file, and then add a brief description of today’s lab, using
    markdown syntax.

  - Change directory to the data/ folder.

  - Download the data file with the command curl, and the -O option
    (letter
O)

<!-- end list -->

``` r
# curl -O https://raw.githubusercontent.com/ucb-stat133/stat133-spring-2018/master/data/nba2017-players.csv
```

  - Use ls to confirm that the csv file is in data/

  - Use word count wc to count the lines of the csv file

<!-- end list -->

``` r
#wc nba2017-players.csv
#  442    1632   39752 nba2017-players.csv
```

  - Take a peek at the first rows of the csv file with
head

<!-- end list -->

``` r
#"player","team","position","height","weight","age","experience","college","salary","games","minutes","points","points3","points2","points1"
#"Al Horford","BOS","C",82,245,30,9,"University of Florida",26540100,68,2193,952,86,293,108
#"Amir Johnson","BOS","PF",81,240,29,11,"",1.2e+07,80,1608,520,27,186,67
#"Avery Bradley","BOS","SG",74,180,26,6,"University of Texas at Austin",8269663,55,1835,894,108,251,68
#"Demetrius Jackson","BOS","PG",73,201,22,0,"University of Notre Dame",1450000,5,17,10,1,2,3
#"Gerald Green","BOS","SF",79,205,31,9,"",1410598,47,538,262,39,56,33
#"Isaiah Thomas","BOS","PG",69,185,27,5,"University of Washington",6587132,76,2569,2199,245,437,590
#"Jae Crowder","BOS","SF",78,235,26,4,"Marquette University",6286408,72,2335,999,157,176,176
#"James Young","BOS","SG",78,215,21,2,"University of Kentucky",1825200,29,220,68,12,13,6
#"Jaylen Brown","BOS","SF",79,225,20,0,"University of California",4743000,78,1341,515,46,146,85
```

Take a peek at the last 5 rows of the csv file with tail

``` r
#"Dragan Bender","PHO","PF",85,225,19,0,"",4276320,43,574,146,28,29,4
#"Elijah Millsap","PHO","SG",78,225,29,2,"University of Alabama at Birmingham",23069,2,23,3,0,1,1
#"Eric Bledsoe","PHO","PG",73,190,27,6,"University of Kentucky",1.4e+07,66,2176,1390,104,345,388
#"Jared Dudley","PHO","PF",79,225,31,9,"Boston College",10470000,64,1362,434,77,80,43
#"Leandro Barbosa","PHO","SG",75,194,34,13,"",4e+06,67,963,419,35,137,40
#"Marquese Chriss","PHO","PF",82,233,19,0,"University of Washington",2941440,82,1743,753,72,212,113
#"Ronnie Price","PHO","PG",74,190,33,11,"Utah Valley State College",282595,14,134,14,3,1,3
#"T.J. Warren","PHO","SF",80,230,23,2,"North Carolina State University",2128920,66,2048,951,26,377,119
#"Tyler Ulis","PHO","PG",70,150,21,0,"University of Kentucky",918369,61,1123,444,21,163,55
#"Tyson Chandler","PHO","C",85,240,34,15,"",12415000,47,1298,397,0,153,91
```

## Installing packages

I’m assuming that you already installed the packages “dplyr” and
“ggplot2”. If that’s not the case then run on the console the command
below (do NOT include this command in your Rmd)

Remember that you only need to install a package once\! After a package
has been installed in your machine, there is no need to call
install.packages() again on the same package. What you should always
invoke in order to use the functions in a package is the library()
function:

``` r
library(dplyr)
```

    ## Registered S3 methods overwritten by 'tibble':
    ##   method     from  
    ##   format.tbl pillar
    ##   print.tbl  pillar

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ggplot2)
```

**About loading packages**: Another rule to keep in mind is to always
load any required packages at the very top of your script files (.R or
.Rmd or .Rnw files). Avoid calling the library() function in the middle
of a script. Instead, load all the packages before anything else.

## Path for Images

The other important specification to include in your Rmd file is a
global chunk option to specify the location of plots and graphics. This
is done by setting the fig.path argument inside the
knitr::opts\_chunk$set() function.

If you don’t specify fig.path, “knitr” will create a default directory
to store all the plots produced when knitting an Rmd file. This time,
however, we want to have more control over where things are placed.
Because you already have a folder images/ as part of the filestructure,
this is where we want “knitr” to save all the generated graphics.

Notice the use of a relative path fig.path = ‘../images/’. This is
because your Rmd file should be inside the folder report/, but the
folder images/ is outside report/ (i.e. in the same parent directory of
report/).

# NBA Players Data

The data file for this lab is the same you used last week:
nba2017-players.csv.

To import the data in R you can use the base function read.csv(), or you
can also use read\_csv() from the package “readr”:

``` r
# with "base" read.csv()
dat <- read.csv('~/Desktop/school/stat133/labs/lab5/data/nba2017-players.csv', stringsAsFactors = FALSE)

library(readr)
# with "readr" read_csv()
dat <- read_csv('~/Desktop/school/stat133/labs/lab5/data/nba2017-players.csv')
```

    ## Parsed with column specification:
    ## cols(
    ##   player = col_character(),
    ##   team = col_character(),
    ##   position = col_character(),
    ##   height = col_double(),
    ##   weight = col_double(),
    ##   age = col_double(),
    ##   experience = col_double(),
    ##   college = col_character(),
    ##   salary = col_double(),
    ##   games = col_double(),
    ##   minutes = col_double(),
    ##   points = col_double(),
    ##   points3 = col_double(),
    ##   points2 = col_double(),
    ##   points1 = col_double()
    ## )

# Basic “dplyr” verbs

To make the learning process of “dplyr” gentler, Hadley Wickham proposes
beginning with a set of five basic verbs or operations for data frames
(each verb corresponds to a function in “dplyr”):

  - filter: keep rows matching criteria
  - select: pick columns by name
  - mutate: add new variables
  - arrange: reorder rows
  - summarise: reduce variables to values

I’ve slightly modified Hadley’s list of verbs:

  - filter(), slice(), and select(): subsetting and selecting rows and
    columns
  - mutate(): add new variables
  - arrange(): reorder rows
  - summarise(): reduce variables to values
  - group\_by(): grouped (aggregate) operations

# Filtering, slicing, and selecting

slice() allows you to select rows by position:

``` r
# first three rows
three_rows <- slice(dat, 1:3)
three_rows
```

    ## # A tibble: 3 x 15
    ##   player team  position height weight   age experience college salary games
    ##   <chr>  <chr> <chr>     <dbl>  <dbl> <dbl>      <dbl> <chr>    <dbl> <dbl>
    ## 1 Al Ho… BOS   C            82    245    30          9 Univer… 2.65e7    68
    ## 2 Amir … BOS   PF           81    240    29         11 NA      1.2 e7    80
    ## 3 Avery… BOS   SG           74    180    26          6 Univer… 8.27e6    55
    ## # … with 5 more variables: minutes <dbl>, points <dbl>, points3 <dbl>,
    ## #   points2 <dbl>, points1 <dbl>

filter() allows you to select rows by condition:

``` r
# subset rows given a condition
# (height greater than 85 inches)
gt_85 <- filter(dat, height > 85)
gt_85
```

    ## # A tibble: 5 x 15
    ##   player team  position height weight   age experience college salary games
    ##   <chr>  <chr> <chr>     <dbl>  <dbl> <dbl>      <dbl> <chr>    <dbl> <dbl>
    ## 1 Edy T… CLE   C            87    260    24          1 NA      5.14e3     1
    ## 2 Boban… DET   C            87    290    28          1 NA      7   e6    35
    ## 3 Krist… NYK   PF           87    240    21          1 NA      4.32e6    66
    ## 4 Roy H… DEN   C            86    270    30          8 George… 5   e6     6
    ## 5 Alexi… NOP   C            86    248    28          6 NA      4.6 e6    39
    ## # … with 5 more variables: minutes <dbl>, points <dbl>, points3 <dbl>,
    ## #   points2 <dbl>, points1 <dbl>

select() allows you to select columns by name:

``` r
# columns by name
player_height <- select(dat, player, height)
```

## Your turn:

  - use slice() to subset the data by selecting the first 5 rows.

<!-- end list -->

``` r
slice(dat, n = 1:5)
```

    ## # A tibble: 5 x 15
    ##   player team  position height weight   age experience college salary games
    ##   <chr>  <chr> <chr>     <dbl>  <dbl> <dbl>      <dbl> <chr>    <dbl> <dbl>
    ## 1 Al Ho… BOS   C            82    245    30          9 Univer… 2.65e7    68
    ## 2 Amir … BOS   PF           81    240    29         11 NA      1.2 e7    80
    ## 3 Avery… BOS   SG           74    180    26          6 Univer… 8.27e6    55
    ## 4 Demet… BOS   PG           73    201    22          0 Univer… 1.45e6     5
    ## 5 Geral… BOS   SF           79    205    31          9 NA      1.41e6    47
    ## # … with 5 more variables: minutes <dbl>, points <dbl>, points3 <dbl>,
    ## #   points2 <dbl>, points1 <dbl>

  - use slice() to subset the data by selecting rows 10, 15, 20, …, 50.

<!-- end list -->

``` r
slice(dat, n = 10, 15, 20, 25, 30, 35, 40, 45, 50)
```

    ## # A tibble: 9 x 15
    ##   player team  position height weight   age experience college salary games
    ##   <chr>  <chr> <chr>     <dbl>  <dbl> <dbl>      <dbl> <chr>    <dbl> <dbl>
    ## 1 Jonas… BOS   PF           82    231    29          6 NA      5   e6    78
    ## 2 Tyler… BOS   C            84    253    27          4 Univer… 8   e6    51
    ## 3 Edy T… CLE   C            87    260    24          1 NA      5.14e3     1
    ## 4 Kevin… CLE   PF           82    251    28          8 Univer… 2.12e7    60
    ## 5 Trist… CLE   C            81    238    25          5 Univer… 1.53e7    78
    ## 6 DeMar… TOR   SF           80    215    30          7 Univer… 1.42e7    72
    ## 7 Lucas… TOR   C            84    241    24          2 NA      1.92e6    57
    ## 8 Serge… TOR   PF           82    235    27          7 NA      1.23e7    23
    ## 9 Danie… WAS   C            83    245    23          0 Villan… 5.43e5    19
    ## # … with 5 more variables: minutes <dbl>, points <dbl>, points3 <dbl>,
    ## #   points2 <dbl>, points1 <dbl>

  - use slice() to subset the data by selecting the last 5 rows.

<!-- end list -->

``` r
slice(dat, n = 436:441)
```

    ## # A tibble: 6 x 15
    ##   player team  position height weight   age experience college salary games
    ##   <chr>  <chr> <chr>     <dbl>  <dbl> <dbl>      <dbl> <chr>    <dbl> <dbl>
    ## 1 Leand… PHO   SG           75    194    34         13 NA      4   e6    67
    ## 2 Marqu… PHO   PF           82    233    19          0 Univer… 2.94e6    82
    ## 3 Ronni… PHO   PG           74    190    33         11 Utah V… 2.83e5    14
    ## 4 T.J. … PHO   SF           80    230    23          2 North … 2.13e6    66
    ## 5 Tyler… PHO   PG           70    150    21          0 Univer… 9.18e5    61
    ## 6 Tyson… PHO   C            85    240    34         15 NA      1.24e7    47
    ## # … with 5 more variables: minutes <dbl>, points <dbl>, points3 <dbl>,
    ## #   points2 <dbl>, points1 <dbl>

  - use filter() to subset those players with height less than 70 inches
    tall.

<!-- end list -->

``` r
dat %>%
  filter(height  < 70)
```

    ## # A tibble: 2 x 15
    ##   player team  position height weight   age experience college salary games
    ##   <chr>  <chr> <chr>     <dbl>  <dbl> <dbl>      <dbl> <chr>    <dbl> <dbl>
    ## 1 Isaia… BOS   PG           69    185    27          5 Univer… 6.59e6    76
    ## 2 Kay F… CLE   PG           69    176    21          0 Oaklan… 5.43e5    42
    ## # … with 5 more variables: minutes <dbl>, points <dbl>, points3 <dbl>,
    ## #   points2 <dbl>, points1 <dbl>

  - use filter() to subset rows of Golden State Warriors (‘GSW’).

<!-- end list -->

``` r
dat %>%
  filter(team  == "GSW")
```

    ## # A tibble: 15 x 15
    ##    player team  position height weight   age experience college salary games
    ##    <chr>  <chr> <chr>     <dbl>  <dbl> <dbl>      <dbl> <chr>    <dbl> <dbl>
    ##  1 Andre… GSW   SF           78    215    33         12 Univer… 1.11e7    76
    ##  2 Damia… GSW   C            84    245    21          0 Vander… 1.17e6    10
    ##  3 David… GSW   C            81    250    36         13 Xavier… 1.55e6    68
    ##  4 Draym… GSW   PF           79    230    26          4 Michig… 1.53e7    76
    ##  5 Ian C… GSW   SG           75    175    25          3 Belmon… 1.02e6    77
    ##  6 James… GSW   PF           81    230    24          2 Univer… 9.80e5    52
    ##  7 JaVal… GSW   C            84    270    29          8 Univer… 1.40e6    77
    ##  8 Kevin… GSW   SF           81    240    28          9 Univer… 2.65e7    62
    ##  9 Kevon… GSW   C            81    220    20          1 Univer… 1.18e6    53
    ## 10 Klay … GSW   SG           79    215    26          5 Washin… 1.67e7    78
    ## 11 Matt … GSW   SF           79    226    36         13 Univer… 3.83e5    20
    ## 12 Patri… GSW   SG           79    185    21          0 Univer… 5.43e5    71
    ## 13 Shaun… GSW   PG           79    192    31         11 NA      5.78e6    76
    ## 14 Steph… GSW   PG           75    190    28          7 Davids… 1.21e7    79
    ## 15 Zaza … GSW   C            83    270    32         13 NA      2.90e6    70
    ## # … with 5 more variables: minutes <dbl>, points <dbl>, points3 <dbl>,
    ## #   points2 <dbl>, points1 <dbl>

  - use filter() to subset rows of GSW centers (‘C’).

<!-- end list -->

``` r
dat %>%
  filter(team  == "GSW" & position == "C")
```

    ## # A tibble: 5 x 15
    ##   player team  position height weight   age experience college salary games
    ##   <chr>  <chr> <chr>     <dbl>  <dbl> <dbl>      <dbl> <chr>    <dbl> <dbl>
    ## 1 Damia… GSW   C            84    245    21          0 Vander… 1.17e6    10
    ## 2 David… GSW   C            81    250    36         13 Xavier… 1.55e6    68
    ## 3 JaVal… GSW   C            84    270    29          8 Univer… 1.40e6    77
    ## 4 Kevon… GSW   C            81    220    20          1 Univer… 1.18e6    53
    ## 5 Zaza … GSW   C            83    270    32         13 NA      2.90e6    70
    ## # … with 5 more variables: minutes <dbl>, points <dbl>, points3 <dbl>,
    ## #   points2 <dbl>, points1 <dbl>

  - use filter() and then select(), to subset rows of lakers (‘LAL’),
    and then display their names.

<!-- end list -->

``` r
dat %>% 
  filter(team == "LAL") %>%
  select(player)
```

    ## # A tibble: 15 x 1
    ##    player           
    ##    <chr>            
    ##  1 Brandon Ingram   
    ##  2 Corey Brewer     
    ##  3 D'Angelo Russell 
    ##  4 David Nwaba      
    ##  5 Ivica Zubac      
    ##  6 Jordan Clarkson  
    ##  7 Julius Randle    
    ##  8 Larry Nance Jr.  
    ##  9 Luol Deng        
    ## 10 Metta World Peace
    ## 11 Nick Young       
    ## 12 Tarik Black      
    ## 13 Thomas Robinson  
    ## 14 Timofey Mozgov   
    ## 15 Tyler Ennis

  - use filter() and then select(), to display the name and salary, of
    GSW point guards

<!-- end list -->

``` r
dat %>% 
  filter(team == "GSW" & position == "PG") %>%
  select(player, salary)
```

    ## # A tibble: 2 x 2
    ##   player             salary
    ##   <chr>               <dbl>
    ## 1 Shaun Livingston  5782450
    ## 2 Stephen Curry    12112359

  - find how to select the name, age, and team, of players with more
    than 10 years of experience, making 10 million dollars or less.

<!-- end list -->

``` r
dat %>%
  filter(experience > 10 & salary < 10000000) %>%
  select(player, age, team)
```

    ## # A tibble: 32 x 3
    ##    player              age team 
    ##    <chr>             <dbl> <chr>
    ##  1 Dahntay Jones        36 CLE  
    ##  2 Deron Williams       32 CLE  
    ##  3 James Jones          36 CLE  
    ##  4 Kyle Korver          35 CLE  
    ##  5 Richard Jefferson    36 CLE  
    ##  6 Jose Calderon        35 ATL  
    ##  7 Kris Humphries       31 ATL  
    ##  8 Mike Dunleavy        36 ATL  
    ##  9 Jason Terry          39 MIL  
    ## 10 C.J. Miles           29 IND  
    ## # … with 22 more rows

  - find how to select the name, team, height, and weight, of rookie
    players, 20 years old, displaying only the first five occurrences
    (i.e. rows)

<!-- end list -->

``` r
dat %>%
  filter(experience < 1 & age == 20) %>%
  select(player, team, height, weight) %>%
  slice_tail(n = 5)
```

    ## # A tibble: 5 x 4
    ##   player          team  height weight
    ##   <chr>           <chr>  <dbl>  <dbl>
    ## 1 Deyonta Davis   MEM       83    237
    ## 2 Wade Baldwin    MEM       76    202
    ## 3 Malik Beasley   DEN       77    196
    ## 4 Cheick Diallo   NOP       81    220
    ## 5 Skal Labissiere SAC       83    225

# Adding new variables: mutate()

Another basic verb is mutate() which allows you to add new variables.
Let’s create a small data frame for the warriors with three columns:
player, height, and weight:

``` r
# creating a small data frame step by step
gsw <- filter(dat, team == 'GSW')
gsw <- select(gsw, player, height, weight)
gsw <- slice(gsw, c(4, 8, 10, 14, 15))
gsw
```

    ## # A tibble: 5 x 3
    ##   player         height weight
    ##   <chr>           <dbl>  <dbl>
    ## 1 Draymond Green     79    230
    ## 2 Kevin Durant       81    240
    ## 3 Klay Thompson      79    215
    ## 4 Stephen Curry      75    190
    ## 5 Zaza Pachulia      83    270

Now, let’s use mutate() to (temporarily) add a column with the ratio
height / weight:

``` r
mutate(gsw, height / weight)
```

    ## # A tibble: 5 x 4
    ##   player         height weight `height/weight`
    ##   <chr>           <dbl>  <dbl>           <dbl>
    ## 1 Draymond Green     79    230           0.343
    ## 2 Kevin Durant       81    240           0.338
    ## 3 Klay Thompson      79    215           0.367
    ## 4 Stephen Curry      75    190           0.395
    ## 5 Zaza Pachulia      83    270           0.307

You can also give a new name, like: ht\_wt = height / weight:

``` r
mutate(gsw, ht_wt = height / weight)
```

    ## # A tibble: 5 x 4
    ##   player         height weight ht_wt
    ##   <chr>           <dbl>  <dbl> <dbl>
    ## 1 Draymond Green     79    230 0.343
    ## 2 Kevin Durant       81    240 0.338
    ## 3 Klay Thompson      79    215 0.367
    ## 4 Stephen Curry      75    190 0.395
    ## 5 Zaza Pachulia      83    270 0.307

In order to permanently change the data, you need to assign the changes
to an object:

``` r
gsw2 <- mutate(gsw, ht_m = height * 0.0254, wt_kg = weight * 0.4536)
gsw2
```

    ## # A tibble: 5 x 5
    ##   player         height weight  ht_m wt_kg
    ##   <chr>           <dbl>  <dbl> <dbl> <dbl>
    ## 1 Draymond Green     79    230  2.01 104. 
    ## 2 Kevin Durant       81    240  2.06 109. 
    ## 3 Klay Thompson      79    215  2.01  97.5
    ## 4 Stephen Curry      75    190  1.90  86.2
    ## 5 Zaza Pachulia      83    270  2.11 122.

# Reordering rows: arrange()

The next basic verb of “dplyr” is arrange() which allows you to reorder
rows. For example, here’s how to arrange the rows of gsw by height

``` r
# order rows by height (increasingly)
arrange(gsw, height)
```

    ## # A tibble: 5 x 3
    ##   player         height weight
    ##   <chr>           <dbl>  <dbl>
    ## 1 Stephen Curry      75    190
    ## 2 Draymond Green     79    230
    ## 3 Klay Thompson      79    215
    ## 4 Kevin Durant       81    240
    ## 5 Zaza Pachulia      83    270

By default arrange() sorts rows in increasing order. To arrange rows in
descending order you need to use the auxiliary function desc().

``` r
# order rows by height (decreasingly)
arrange(gsw, desc(height))
```

    ## # A tibble: 5 x 3
    ##   player         height weight
    ##   <chr>           <dbl>  <dbl>
    ## 1 Zaza Pachulia      83    270
    ## 2 Kevin Durant       81    240
    ## 3 Draymond Green     79    230
    ## 4 Klay Thompson      79    215
    ## 5 Stephen Curry      75    190

``` r
# order rows by height, and then weight
arrange(gsw, height, weight)
```

    ## # A tibble: 5 x 3
    ##   player         height weight
    ##   <chr>           <dbl>  <dbl>
    ## 1 Stephen Curry      75    190
    ## 2 Klay Thompson      79    215
    ## 3 Draymond Green     79    230
    ## 4 Kevin Durant       81    240
    ## 5 Zaza Pachulia      83    270

## Your Turn

  - using the data frame gsw, add a new variable product with the
    product of height and weight.

<!-- end list -->

``` r
mutate(gsw, h_w = height * weight)
```

    ## # A tibble: 5 x 4
    ##   player         height weight   h_w
    ##   <chr>           <dbl>  <dbl> <dbl>
    ## 1 Draymond Green     79    230 18170
    ## 2 Kevin Durant       81    240 19440
    ## 3 Klay Thompson      79    215 16985
    ## 4 Stephen Curry      75    190 14250
    ## 5 Zaza Pachulia      83    270 22410

  - create a new data frame gsw3, by adding columns log\_height and
    log\_weight with the log transformations of height and weight.

<!-- end list -->

``` r
gsw3 <- mutate(gsw, log_height = log(height), log_weight = log(weight))
gsw3
```

    ## # A tibble: 5 x 5
    ##   player         height weight log_height log_weight
    ##   <chr>           <dbl>  <dbl>      <dbl>      <dbl>
    ## 1 Draymond Green     79    230       4.37       5.44
    ## 2 Kevin Durant       81    240       4.39       5.48
    ## 3 Klay Thompson      79    215       4.37       5.37
    ## 4 Stephen Curry      75    190       4.32       5.25
    ## 5 Zaza Pachulia      83    270       4.42       5.60

  - use the original data frame to filter() and arrange() those players
    with height less than 71 inches tall, in increasing order.

<!-- end list -->

``` r
dat %>%
  filter(height < 71) %>%
  arrange(height)
```

    ## # A tibble: 3 x 15
    ##   player team  position height weight   age experience college salary games
    ##   <chr>  <chr> <chr>     <dbl>  <dbl> <dbl>      <dbl> <chr>    <dbl> <dbl>
    ## 1 Isaia… BOS   PG           69    185    27          5 Univer… 6.59e6    76
    ## 2 Kay F… CLE   PG           69    176    21          0 Oaklan… 5.43e5    42
    ## 3 Tyler… PHO   PG           70    150    21          0 Univer… 9.18e5    61
    ## # … with 5 more variables: minutes <dbl>, points <dbl>, points3 <dbl>,
    ## #   points2 <dbl>, points1 <dbl>

  - display the name, team, and salary, of the top-5 highest paid
    players

<!-- end list -->

``` r
dat %>%
  arrange(desc(salary)) %>%
  slice(n = 1:5) %>%
  select(player, team, salary)
```

    ## # A tibble: 5 x 3
    ##   player        team    salary
    ##   <chr>         <chr>    <dbl>
    ## 1 LeBron James  CLE   30963450
    ## 2 Al Horford    BOS   26540100
    ## 3 DeMar DeRozan TOR   26540100
    ## 4 Kevin Durant  GSW   26540100
    ## 5 James Harden  HOU   26540100

  - display the name, team, and points3, of the top 10 three-point
    players

<!-- end list -->

``` r
dat %>%
  arrange(desc(points3)) %>%
  slice(n = 1:10) %>%
  select(player, team, points3)
```

    ## # A tibble: 10 x 3
    ##    player         team  points3
    ##    <chr>          <chr>   <dbl>
    ##  1 Stephen Curry  GSW       324
    ##  2 Klay Thompson  GSW       268
    ##  3 James Harden   HOU       262
    ##  4 Eric Gordon    HOU       246
    ##  5 Isaiah Thomas  BOS       245
    ##  6 Kemba Walker   CHO       240
    ##  7 Bradley Beal   WAS       223
    ##  8 Damian Lillard POR       214
    ##  9 Ryan Anderson  HOU       204
    ## 10 J.J. Redick    LAC       201

  - create a data frame gsw\_mpg of GSW players, that contains variables
    for player name, experience, and min\_per\_game (minutes per game),
    sorted by min\_per\_game (in descending order)

<!-- end list -->

``` r
gsw_mpg <- dat %>%
  filter(team == "GSW") %>%
  mutate(min_per_game = minutes / games) %>%
  arrange(desc(min_per_game)) %>%
  select(player, experience, min_per_game)
gsw_mpg
```

    ## # A tibble: 15 x 3
    ##    player               experience min_per_game
    ##    <chr>                     <dbl>        <dbl>
    ##  1 Klay Thompson                 5        34.0 
    ##  2 Stephen Curry                 7        33.4 
    ##  3 Kevin Durant                  9        33.4 
    ##  4 Draymond Green                4        32.5 
    ##  5 Andre Iguodala               12        26.3 
    ##  6 Matt Barnes                  13        20.5 
    ##  7 Zaza Pachulia                13        18.1 
    ##  8 Shaun Livingston             11        17.7 
    ##  9 Patrick McCaw                 0        15.1 
    ## 10 Ian Clark                     3        14.8 
    ## 11 David West                   13        12.6 
    ## 12 JaVale McGee                  8         9.60
    ## 13 James Michael McAdoo          2         8.79
    ## 14 Damian Jones                  0         8.5 
    ## 15 Kevon Looney                  1         8.43

# Summarizing values with summarise()

The next verb is summarise(). Conceptually, this involves applying a
function on one or more columns, in order to summarize values. This is
probably easier to understand with one example.

Say you are interested in calculating the average salary of all NBA
players. To do this “a la dplyr” you use summarise(), or its synonym
function summarize():

``` r
# average salary of NBA players
summarise(dat, avg_salary = mean(salary))
```

    ## # A tibble: 1 x 1
    ##   avg_salary
    ##        <dbl>
    ## 1   6187014.

Calculating an average like this seems a bit verbose, especially when
you can directly use mean() like this:

``` r
mean(dat$salary)
```

    ## [1] 6187014

So let’s make things a bit more interessting. What if you want to
calculate some summary statistics for salary: min, median, mean, and
max?

``` r
# some stats for salary (dplyr)
summarise(
  dat, 
  min = min(salary),
  median = median(salary),
  avg = mean(salary),
  max = max(salary)
)
```

    ## # A tibble: 1 x 4
    ##     min  median      avg      max
    ##   <dbl>   <dbl>    <dbl>    <dbl>
    ## 1  5145 3500000 6187014. 30963450

Well, this may still look like not much. You can do the same in base R
(there are actually better ways to do this):

``` r
# some stats for salary (base R)
c(min = min(dat$salary), 
  median = median(dat$salary),
  median = mean(dat$salary),
  max = max(dat$salary))
```

    ##      min   median   median      max 
    ##     5145  3500000  6187014 30963450

# Grouped operations

To actually appreciate the power of summarise(), we need to introduce
the other major basic verb in “dplyr”: group\_by(). This is the function
that allows you to perform data aggregations, or grouped operations.

Let’s see the combination of summarise() and group\_by() to calculate
the average salary by team:

``` r
# average salary, grouped by team
summarise(
  group_by(dat, team),
  avg_salary = mean(salary)
)
```

    ## # A tibble: 30 x 2
    ##    team  avg_salary
    ##    <chr>      <dbl>
    ##  1 ATL     6491892.
    ##  2 BOS     6127673.
    ##  3 BRK     4363414 
    ##  4 CHI     6138459.
    ##  5 CHO     6683086.
    ##  6 CLE     8386014.
    ##  7 DAL     6139880 
    ##  8 DEN     5225533 
    ##  9 DET     6871594.
    ## 10 GSW     6579394.
    ## # … with 20 more rows

Here’s a similar example with the average salary by position:

``` r
# average salary, grouped by position
summarise(
  group_by(dat, position),
  avg_salary = mean(salary)
)
```

    ## # A tibble: 5 x 2
    ##   position avg_salary
    ##   <chr>         <dbl>
    ## 1 C          6987682.
    ## 2 PF         5890363.
    ## 3 PG         6069029.
    ## 4 SF         6513374.
    ## 5 SG         5535260

Here’s a more fancy example: average weight and height, by position,
displayed in desceding order by average height:

``` r
arrange(
  summarise(
    group_by(dat, position),
    avg_height = mean(height),
    avg_weight = mean(weight)),
  desc(avg_height)
)
```

    ## # A tibble: 5 x 3
    ##   position avg_height avg_weight
    ##   <chr>         <dbl>      <dbl>
    ## 1 C              83.3       251.
    ## 2 PF             81.5       236.
    ## 3 SF             79.6       220.
    ## 4 SG             77.0       205.
    ## 5 PG             74.3       189.

## Your turn:

  - use summarise() to get the largest height value.

<!-- end list -->

``` r
summarise(
  group_by(dat),
  max_height = max(height)
)
```

    ## # A tibble: 1 x 1
    ##   max_height
    ##        <dbl>
    ## 1         87

  - use summarise() to get the standard deviation of points3.

<!-- end list -->

``` r
summarise(
  group_by(dat),
  sd_points3 = sd(points3) 
)
```

    ## # A tibble: 1 x 1
    ##   sd_points3
    ##        <dbl>
    ## 1       56.0

  - use summarise() and group\_by() to display the median of
    three-points, by team.

<!-- end list -->

``` r
summarise(
  group_by(dat, team),
  median_points3 = median(points3)
)
```

    ## # A tibble: 30 x 2
    ##    team  median_points3
    ##    <chr>          <dbl>
    ##  1 ATL             32.5
    ##  2 BOS             46  
    ##  3 BRK             44  
    ##  4 CHI             32  
    ##  5 CHO             17  
    ##  6 CLE             62  
    ##  7 DAL             53  
    ##  8 DEN             53  
    ##  9 DET             28  
    ## 10 GSW             18  
    ## # … with 20 more rows

  - display the average triple points by team, in ascending order, of
    the bottom-5 teams (worst 3pointer teams)

<!-- end list -->

``` r
slice_tail(
  arrange(
    summarise(group_by(dat, team),mean_points3 = mean(points3))
    , mean_points3)
  , n = 5)
```

    ## # A tibble: 5 x 2
    ##   team  mean_points3
    ##   <chr>        <dbl>
    ## 1 POR           60.9
    ## 2 GSW           65.5
    ## 3 BOS           65.7
    ## 4 CLE           67.5
    ## 5 HOU           81.5

  - obtain the mean and standard deviation of age, for Power Forwards,
    with 5 and 10 years (including) years of experience.

<!-- end list -->

``` r
dat %>%
  filter(position == "PF" & experience > 5 & experience < 10 | 
           experience == 5 | experience == 10) %>%
  summarise(mean_age = mean(age), sd_age = sd(age))
```

    ## # A tibble: 1 x 2
    ##   mean_age sd_age
    ##      <dbl>  <dbl>
    ## 1     27.8   2.38

# First contact with ggplot()

The package “ggplot2” is probably the most popular package in R to
create beautiful static graphics. Comapred to the functions in the base
package “graphcics”, the package “ggplot2” follows a somewhat different
philosophy, and it tries to be more consistent and modular as possible.

  - The main function in “ggplot2” is ggplot()
  - The main input to ggplot() is a data frame object.
  - You can use the internal function aes() to specify what columns of
    the data frame will be used for the graphical elements of the plot.
  - You must specify what kind of geometric objects or geoms will be
    displayed: e.g. geom\_point(), geom\_bar(), geom\_boxpot().
  - Pretty much anything else that you want to add to your plot is
    controlled by auxiliary functions, especially those things that have
    to do with the format, rather than the underlying data.
  - The construction of a ggplot is done by adding layers with the +
    operator.

## Scatterplots

Let’s start with a scatterplot of salary and points

``` r
# scatterplot (option 1)
ggplot(data = dat) +
  geom_point(aes(x = points, y = salary))
```

![](../images/unnamed-chunk-45-1.png)<!-- -->

  - ggplot() creates an object of class “ggplot”
  - the main input for ggplot() is data which must be a data frame
  - then we use the “+” operator to add a layer
  - the geometric object (geom) are points: geom\_points()
  - aes() is used to specify the x and y coordinates, by taking columns
    points and salary from the data frame

The same scatterplot can also be created with this alternative, and more
common use of ggplot()

``` r
# scatterplot (option 2)
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point()
```

![](../images/unnamed-chunk-46-1.png)<!-- -->

## Label your chunks\!

When including code for plots and graphics, we strongly recommend that
you create an individual code chunk for each plot, and that you give a
label to that chunk.

When including code for plots and graphics, we strongly recommend that
you create an individual code chunk for each plot, and that you give a
label to that chunk.

Note that the code chunk has a label scatterplot1; moreover, the code is
exclusively decidated to this plot. Why should you care? Because when
“knitr” creates the file of the plot, it will use the chunk label for
the graph. So it’s better to give meaningful names to those chunks
containing graphics.

## Adding color

Say you want to color code the points in terms of position

``` r
# colored scatterplot 
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position))
```

![](../images/unnamed-chunk-47-1.png)<!-- -->

Maybe you wan to modify the size of the dots in terms of points3:

``` r
# sized and colored scatterplot 
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position, size = points3))
```

![](../images/unnamed-chunk-48-1.png)<!-- -->

To add some transparency effect to the dots, you can use the alpha
parameter.

``` r
# sized and colored scatterplot 
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position, size = points3), alpha = 0.7)
```

![](../images/unnamed-chunk-49-1.png)<!-- -->

Notice that alpha was specified outside aes(). This is because we are
not using any column for the alpha transparency values.

## Your turn:

  - Open the ggplot2 cheatsheet

  - Use the data frame gsw to make a scatterplot of height and weight.

<!-- end list -->

``` r
ggplot(data = gsw, aes(x = height, y = weight)) + 
  geom_point()
```

![](../images/unnamed-chunk-50-1.png)<!-- -->

  - Find out how to make another scatterplot of height and weight, using
    geom\_text() to display the names of the players.

<!-- end list -->

``` r
ggplot(data = gsw, aes(x = height, y = weight)) + 
  geom_text(aes(label = player))
```

![](../images/unnamed-chunk-51-1.png)<!-- -->

  - Get a scatter plot of height and weight, for ALL the warriors,
    displaying their names with geom\_label().

<!-- end list -->

``` r
ggplot(data = gsw, aes(x = height, y = weight)) + 
  geom_label(aes(label = player))
```

![](../images/unnamed-chunk-52-1.png)<!-- -->

  - Get a density plot of salary (for all NBA players).

<!-- end list -->

``` r
ggplot(dat, aes(x = salary)) + 
  geom_density(kernel = "gaussian")
```

![](../images/unnamed-chunk-53-1.png)<!-- -->

  - Get a histogram of points2 with binwidth of 50 (for all NBA
    players).

<!-- end list -->

``` r
ggplot(dat, aes(x = points2)) + 
  geom_histogram(binwidth = 50)
```

![](../images/unnamed-chunk-54-1.png)<!-- -->

  - Get a barchart of the position frequencies (for all NBA players).

<!-- end list -->

``` r
ggplot(dat, aes(x = position)) + 
  geom_bar()
```

![](../images/unnamed-chunk-55-1.png)<!-- -->

  - Make a scatterplot of experience and salary of all Centers, and use
    geom\_smooth() to add a regression line.

<!-- end list -->

``` r
ggplot(filter(dat, position == "C"), aes(x = experience, y = salary)) + 
  geom_point() + 
  geom_smooth(method = lm)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](../images/unnamed-chunk-56-1.png)<!-- -->

  - Repeat the same scatterplot of experience and salary of all Centers,
    but now use geom\_smooth() to add a loess line (i.e. smooth line).

<!-- end list -->

``` r
ggplot(filter(dat, position == "C"), aes(x = experience, y = salary)) + 
  geom_point() + 
  geom_smooth(method = loess)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](../images/unnamed-chunk-57-1.png)<!-- -->

# Faceting

One of the most attractive features of “ggplot2” is the ability to
display multiple facets. The idea of facets is to divide a plot into
subplots based on the values of one or more categorical (or discrete)
variables.

Here’s an example. What if you want to get scatterplots of points and
salary separated (or grouped) by position? This is where faceting comes
handy, and you can use facet\_warp() for this purpose:

``` r
# scatterplot by position
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point() +
  facet_wrap(~ position)
```

![](../images/unnamed-chunk-58-1.png)<!-- -->

The other faceting function is facet\_grid(), which allows you to
control the layout of the facets (by rows, by columns, etc)

``` r
# scatterplot by position
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position), alpha = 0.7) +
  facet_grid(~ position) +
  geom_smooth(method = loess)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](../images/unnamed-chunk-59-1.png)<!-- -->

``` r
# scatterplot by position
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position), alpha = 0.7) +
  facet_grid(position ~ .) +
  geom_smooth(method = loess)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](../images/unnamed-chunk-60-1.png)<!-- -->

## Your turn:

  - Make scatterplots of experience and salary faceting by position

<!-- end list -->

``` r
ggplot(data = dat, aes(x = experience, y = salary)) +
  geom_point(aes(color = experience), alpha = 0.7) +
  facet_grid(position ~ .) 
```

![](../images/unnamed-chunk-61-1.png)<!-- -->

  - Make scatterplots of experience and salary faceting by team

<!-- end list -->

``` r
ggplot(data = dat, aes(x = experience, y = salary)) +
  geom_point() +
  facet_wrap(~ team)
```

![](../images/unnamed-chunk-62-1.png)<!-- -->

  - Make density plots of age faceting by team

<!-- end list -->

``` r
ggplot(data = dat, aes(x = age)) +
  geom_density() +
  facet_wrap(~ team)
```

![](../images/unnamed-chunk-63-1.png)<!-- -->

  - Make scatterplots of height and weight faceting by position

<!-- end list -->

``` r
ggplot(data = dat, aes(x = weight, y = height)) +
  geom_point() +
  facet_wrap(~ position)
```

![](../images/unnamed-chunk-64-1.png)<!-- -->

  - Make scatterplots of height and weight, with a 2-dimensional
    density, geom\_density2d(), faceting by position

<!-- end list -->

``` r
ggplot(data = dat, aes(x = height, y = weight)) +
  geom_point(aes(color = position), alpha = 0.7) +
  facet_grid(~position) +
  geom_density2d()
```

![](../images/unnamed-chunk-65-1.png)<!-- -->

  - Make a scatterplot of experience and salary for the Warriors, but
    this time add a layer with theme\_bw() to get a simpler
background

<!-- end list -->

``` r
ggplot(data = filter(dat, team == "GSW"), aes(x = experience, y = salary)) +
  geom_point(aes(color = position), alpha = 0.7) +
  facet_grid(~ position) +
  theme_bw()
```

![](../images/unnamed-chunk-66-1.png)<!-- -->

  - Repeat any of the previous plots but now adding a leyer with another
    theme e.g. theme\_minimal(), theme\_dark(), theme\_classic()

<!-- end list -->

``` r
ggplot(data = dat, aes(x = age)) +
  geom_density() +
  facet_wrap(~ team) + 
  theme_dark()
```

![](../images/unnamed-chunk-67-1.png)<!-- -->
