Lab 6: More data wrangling and outputs
================
Amy Kim

# Manipulating and Visualizing Data Frames

In this lab, you will continue manipulating data frames with “dplyr”,
and plotting graphics with “ggplot2”. In addition, you will also use
various functions to export (or save) tables, images, and R output to
external files.

## Filestructure

To help you better prepare for HW02, we want you to practice working
with a more sophisticated file structure. Follow the steps listed below
to create the necessary subdirectories like those depicted in this
scheme:

``` r
#lab06/
#       README.md
#       data/
#       code/
#       output/
#       images/
```

  - Open a shell terminal (e.g. command line or GitBash)

  - Change your working directory to a location where you will store all
    the materials for this lab

  - Use mkdir to create a directory lab06

  - cd to lab06

  - Use mkdir to create other subdirectories: data, code, output, images

  - List the contents of lab06 to confirm that you have all the
    subdirectories

  - Use touch to create an empty README.md text file.

  - Open the README.md file with a text editor (e.g. the one in RStudio)
    and add a brief description of what this lab is about. Save the
    changes.

  - cd to data/

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
#      442    1632   39752 nba2017-players.csv
```

  - Take a peek at the first rows of the csv file with
head

<!-- end list -->

``` r
#"player","team","position","height","weight","age","experience","college","salary","games","minutes","points","points3","points2","points1"
#"Al Horford","BOS","C",82,245,30,9,"University of Florida",26540100,68,2193,952,86,293,108
#"Amir Johnson","BOS","PF",81,240,29,11,"",1.2e+07,80,1608,520,27,186,67
#"Avery Bradley","BOS","SG",74,180,26,6,"University of Texas at #Austin",8269663,55,1835,894,108,251,68
#"Demetrius Jackson","BOS","PG",73,201,22,0,"University of Notre Dame",1450000,5,17,10,1,2,3
#"Gerald Green","BOS","SF",79,205,31,9,"",1410598,47,538,262,39,56,33
#"Isaiah Thomas","BOS","PG",69,185,27,5,"University of Washington",6587132,76,2569,2199,245,437,590
#"Jae Crowder","BOS","SF",78,235,26,4,"Marquette University",6286408,72,2335,999,157,176,176
#"James Young","BOS","SG",78,215,21,2,"University of Kentucky",1825200,29,220,68,12,13,6
#"Jaylen Brown","BOS","SF",79,225,20,0,"University of California",4743000,78,1341,515,46,146,85
```

  - Take a peek at the last 5 rows of the csv file with tail

<!-- end list -->

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

# R script file

  - Once you have the filestructure for this lab, go to RStudio and open
    a new R script file (do NOT confuse with an Rmd file).

  - Save the R script file as lab06-script.R in the code/ folder of
    lab06/

  - R script files are used to write R code only, using R syntax. In
    other words, you should NOT use Markdown or LaTeX syntax inside an R
    script file. Why? Because if you run the entire script, R will try
    to execute all the commands, and won’t be able to recognize
    Markdown, LaTeX, yaml, or other syntaxes.

## File Header

Let’s start with some good coding practices by adding a header to the R
script file in the form of R comments. In general, the header section
should contain a title, a description of what the script is about, what
are the inputs, and what are the main outputs produced when executing
the code in the script. Optionally, you can also include the name of the
author, the date, and other details. Something like this:

``` r
# Title: Short title (one sentence)
# Description: what the script is about (one paragraph or two)
# Input(s): what are the main inputs (list of inputs)
# Output(s): what are the main outputs (list of outputs)
# Author(s): First Last
# Date: mm-dd-yyyy
```

Think of the header of a script file as the yaml header used in Rmd
files. The header should be the very first thing that appears at the top
of the script file. Personally, I like to surround the header in my R
script files with some delimiting characters that help the reader to
visually identify main parts of the script. Here’s a hypothetical
example of a header:

``` r
# ===================================================================
# Title: Cleaning Data
# Description:
#   More data wrangling and outputs on csv file
# Input(s): data file 'raw-data.csv'
# Output(s): data file 'clean-data.csv'
# Author: Gaston Sanchez
# Date: 2-27-2018
# ===================================================================
```

Another good coding practice is to avoid writing very long lines of
code. Most coding style guides stick to a maximum line width of 80
characters, and this is the magic number that I also use for my scripts.

**Your turn**: Include a header in your R script file, respecting the
width limit of 80 characters. Save this file in the code/ folder.

``` r
# ===================================================================
# Title: lab 6 
# Description:
#   This script performs cleaning tasks and transformations on 
#   various columns of the raw data file.
# Input(s): data file 'nba2017-players.csv'
# Output(s): data file 'lab6-scrip.R' and ggplot
# Author: Amy Kim 
# Date: 2-27-2018
# ===================================================================
```

## Required Packages

The next thing that you need to include in your script file are the
required packages. Not all script files need packages, but many do. When
this is the case, loading the packages should be the first lines of code
to be executed.

Include the commands to load the following packages in your script:

``` r
# packages
library(readr)    # importing data
```

    ## Registered S3 methods overwritten by 'tibble':
    ##   method     from  
    ##   format.tbl pillar
    ##   print.tbl  pillar

``` r
library(dplyr)    # data wrangling
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ggplot2)  # graphics
```

In addition to loading the packages, sometimes you will also need to
load code from other script files. We won’t do that today, but you
should know that this is very common as the complexity and size of your
projects grow.

## Exporting some data tables

After the header, and the loading-packages sections, the next part in
your lab script involves importing the data. In addition to importing a
data table, you are also going to practice exporting tables. That is,
writing data tables to external files.

  - We want you to work with relative paths. To execute the commands
    that read input(s) and write output(s), you will need to set the
    working directory. On the menu bar go to Session, then select the
    option Set Working Directory, and choose To Source File Location.

  - Use read\_csv() from the package “readr” to import the data
    nba2017-players.csv in R. Do this by specifying a relative
path.

<!-- end list -->

``` r
dat <- read_csv('/Users/akii_my/Desktop/school/stat133/labs/lab6/data/nba2017-players.csv')
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

  - Use the imported tibble to create a data frame warriors by selecting
    rows—e.g. filter()—of Golden State Warriors, arranging rows by
    salary in increasing order.

<!-- end list -->

``` r
gsw <- dat %>%
  filter(team == "GSW") %>%
  arrange(salary)
```

  - Use the function write.csv() to export (or save) the data frame
    warriors to a data file warriors.csv in the folder/ directory. You
    will need to use a relative path to specify the file argument. Also,
    see how to use the argument row.names to avoid including a first
    column of
numbers.

<!-- end list -->

``` r
write.csv(gsw, file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/data/warriors.csv', row.names = FALSE)
```

  - Create another data frame lakers by selecting rows of Los Angeles
    Lakers, this time arranging rows by experience (decreasingly).

<!-- end list -->

``` r
lakers <- dat %>% 
  filter(team == "Los Angeles Lakers") %>%
  arrange(desc(experience))
```

  - Now use the function write\_csv() to export (or save) the data frame
    lakers to a data file lakers.csv in the folder/ directory. You will
    also need to use a relative path to specify the file
argument.

<!-- end list -->

``` r
write.csv(gsw, file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/data/lakers.csv', row.names = FALSE)
```

  - Inspect the contents of the data/ folder and confirm that the csv
    files are there.

## Exporting some R output

After exporting the tables to the corresponding csv files, you will
produce some summary statistics, and then save the generated output to
external text files. To do this, you will have to learn about the sink()
function, which sends R output to a specified file.

Say you are interested in exporting the summary statistics of height and
weight, exactly in the same way they are displayed by R:

``` r
summary(dat[ ,c('height', 'weight')])
```

    ##      height          weight     
    ##  Min.   :69.00   Min.   :150.0  
    ##  1st Qu.:77.00   1st Qu.:200.0  
    ##  Median :79.00   Median :220.0  
    ##  Mean   :79.15   Mean   :220.2  
    ##  3rd Qu.:82.00   3rd Qu.:240.0  
    ##  Max.   :87.00   Max.   :290.0

One naive option to “export” this output would be to manually copy the
text displayed on the console, and then paste it to a text file. While
this may work, it is labor intensive, error prone, and highly
irreproducible. A better way to achieve this task is with the sink()
function. Here’s how:

``` r
# divert output to the specified file
sink(file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/output/summary-height-weight.txt')
summary(dat[ ,c('height', 'weight')])
```

    ##      height          weight     
    ##  Min.   :69.00   Min.   :150.0  
    ##  1st Qu.:77.00   1st Qu.:200.0  
    ##  Median :79.00   Median :220.0  
    ##  Mean   :79.15   Mean   :220.2  
    ##  3rd Qu.:82.00   3rd Qu.:240.0  
    ##  Max.   :87.00   Max.   :290.0

``` r
sink()
```

The fist call to sink() opens a connection to the specified file, and
then all outputs are diverted to that location. The second call to
sink(), i.e. the one without any arguments, closes the connection.

While you are sink()ing output to a specified file, all the results will
be sent to such file. In other words, nothing will be printed on the
console. Only after the sinking process has finished and the connection
is closed, you will be able to execute commands and see results
displayed on R’s console.

### Why sinking?

Why would you ever want to sink() R outputs to a file? Why not simply
display them as part of your Rmd file? One good reason for diverting
output to an external file is for convenience. In practice, the reports
and documents (e.g. papers, executive summaries, slides) of a data
analysis project won’t contain everything that you tried, explored,
analyzed, and graphed. There will be many intermediate results that,
while relevant for a specific stage of the analysis cycle, are
innecessary for the final report. So a good way to keep these
intermediate outputs is by exporting them with sink().

#### Your turn:

  - Export the output of str() on the data frame with all the players.
    sink() the output, using a relative path, to a text file
    data-structure.txt, in the output/
folder.

<!-- end list -->

``` r
sink(file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/output/data-structure.txt')
str(dat)
```

    ## spec_tbl_df [441 × 15] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ player    : chr [1:441] "Al Horford" "Amir Johnson" "Avery Bradley" "Demetrius Jackson" ...
    ##  $ team      : chr [1:441] "BOS" "BOS" "BOS" "BOS" ...
    ##  $ position  : chr [1:441] "C" "PF" "SG" "PG" ...
    ##  $ height    : num [1:441] 82 81 74 73 79 69 78 78 79 82 ...
    ##  $ weight    : num [1:441] 245 240 180 201 205 185 235 215 225 231 ...
    ##  $ age       : num [1:441] 30 29 26 22 31 27 26 21 20 29 ...
    ##  $ experience: num [1:441] 9 11 6 0 9 5 4 2 0 6 ...
    ##  $ college   : chr [1:441] "University of Florida" NA "University of Texas at Austin" "University of Notre Dame" ...
    ##  $ salary    : num [1:441] 26540100 12000000 8269663 1450000 1410598 ...
    ##  $ games     : num [1:441] 68 80 55 5 47 76 72 29 78 78 ...
    ##  $ minutes   : num [1:441] 2193 1608 1835 17 538 ...
    ##  $ points    : num [1:441] 952 520 894 10 262 ...
    ##  $ points3   : num [1:441] 86 27 108 1 39 245 157 12 46 45 ...
    ##  $ points2   : num [1:441] 293 186 251 2 56 437 176 13 146 69 ...
    ##  $ points1   : num [1:441] 108 67 68 3 33 590 176 6 85 26 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   player = col_character(),
    ##   ..   team = col_character(),
    ##   ..   position = col_character(),
    ##   ..   height = col_double(),
    ##   ..   weight = col_double(),
    ##   ..   age = col_double(),
    ##   ..   experience = col_double(),
    ##   ..   college = col_character(),
    ##   ..   salary = col_double(),
    ##   ..   games = col_double(),
    ##   ..   minutes = col_double(),
    ##   ..   points = col_double(),
    ##   ..   points3 = col_double(),
    ##   ..   points2 = col_double(),
    ##   ..   points1 = col_double()
    ##   .. )

``` r
sink()
```

  - Export the summary() of the entire data frame warriors to a text
    file summary-warriors.txt, in the output/ folder (also use a
    relative
path).

<!-- end list -->

``` r
sink(file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/output/summary-warriors.txt')
summary(gsw)
```

    ##     player              team             position             height     
    ##  Length:15          Length:15          Length:15          Min.   :75.00  
    ##  Class :character   Class :character   Class :character   1st Qu.:79.00  
    ##  Mode  :character   Mode  :character   Mode  :character   Median :79.00  
    ##                                                           Mean   :79.87  
    ##                                                           3rd Qu.:81.00  
    ##                                                           Max.   :84.00  
    ##      weight           age          experience       college         
    ##  Min.   :175.0   Min.   :20.00   Min.   : 0.000   Length:15         
    ##  1st Qu.:203.5   1st Qu.:24.50   1st Qu.: 2.500   Class :character  
    ##  Median :226.0   Median :28.00   Median : 7.000   Mode  :character  
    ##  Mean   :223.5   Mean   :27.73   Mean   : 6.733                     
    ##  3rd Qu.:242.5   3rd Qu.:31.50   3rd Qu.:11.500                     
    ##  Max.   :270.0   Max.   :36.00   Max.   :13.000                     
    ##      salary             games         minutes         points      
    ##  Min.   :  383351   Min.   :10.0   Min.   :  85   Min.   :  19.0  
    ##  1st Qu.: 1093628   1st Qu.:57.5   1st Qu.: 598   1st Qu.: 214.5  
    ##  Median : 1551659   Median :71.0   Median :1137   Median : 426.0  
    ##  Mean   : 6579394   Mean   :63.0   Mean   :1309   Mean   : 631.5  
    ##  3rd Qu.:11621864   3rd Qu.:76.5   3rd Qu.:2034   3rd Qu.: 675.0  
    ##  Max.   :26540100   Max.   :79.0   Max.   :2649   Max.   :1999.0  
    ##     points3          points2         points1      
    ##  Min.   :  0.00   Min.   :  8.0   Min.   :  3.00  
    ##  1st Qu.:  1.50   1st Qu.: 62.5   1st Qu.: 25.00  
    ##  Median : 18.00   Median :155.0   Median : 44.00  
    ##  Mean   : 65.47   Mean   :169.3   Mean   : 96.47  
    ##  3rd Qu.: 72.50   3rd Qu.:199.5   3rd Qu.:124.50  
    ##  Max.   :324.00   Max.   :434.0   Max.   :336.00

``` r
sink()
```

  - Export another summary() of the entire data frame lakers to a text
    file summary-lakers.txt, in the output/ folder (using a relative
    path).

<!-- end list -->

``` r
sink(file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/output/summary-lakers.txt')
summary(lakers)
```

    ##     player              team             position             height   
    ##  Length:0           Length:0           Length:0           Min.   : NA  
    ##  Class :character   Class :character   Class :character   1st Qu.: NA  
    ##  Mode  :character   Mode  :character   Mode  :character   Median : NA  
    ##                                                           Mean   :NaN  
    ##                                                           3rd Qu.: NA  
    ##                                                           Max.   : NA  
    ##      weight         age        experience    college              salary   
    ##  Min.   : NA   Min.   : NA   Min.   : NA   Length:0           Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA   1st Qu.: NA   Class :character   1st Qu.: NA  
    ##  Median : NA   Median : NA   Median : NA   Mode  :character   Median : NA  
    ##  Mean   :NaN   Mean   :NaN   Mean   :NaN                      Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA                      3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA   Max.   : NA                      Max.   : NA  
    ##      games        minutes        points       points3       points2   
    ##  Min.   : NA   Min.   : NA   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA   Max.   : NA   Max.   : NA   Max.   : NA  
    ##     points1   
    ##  Min.   : NA  
    ##  1st Qu.: NA  
    ##  Median : NA  
    ##  Mean   :NaN  
    ##  3rd Qu.: NA  
    ##  Max.   : NA

``` r
sink()
```

## Exporting some “base” graphs

n the same way that R output, as it appears on the console, can be
exported to some files, you can do the same with graphics and plots.
Actually, saving plot images is much more common than sink()ing output.

Base R provides a wide array of functions to save images in most common
formats:

  - png()
  - jpeg()
  - tiff()
  - bmp()
  - svg()
  - pdf()

Similar to the writing table functions such as write.table() or
write.csv(), and the sink() function, the graphics device functions
require a file name to be provided. Here’s how to save a simple
scatterpot of height and weight in png format to the folder images/:

``` r
# saving a scatterplot in png format
png(filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/scatterplot-height-weight.png")
plot( y = dat$height, x = dat$weight, pch = 20, 
     xlab = 'Weight', ylab = 'Height')
dev.off()
```

    ## quartz_off_screen 
    ##                 2

  - The function png() tells R to save the image in PNG format, using
    the provided filename.
  - Invoking png() will open a graphics device; not the graphics device
    of RStudio, so you won’t be able to see the graphic.
  - The plot() function produces the scatterplot.
  - The function dev.off() closes the graphics device.

#### Your Turn:

  - Open the help documentation of png() and related graphic devices.

  - Use png() to save a scatterplot of height and weight with plot().
    Save the graph in the images/
folder.

<!-- end list -->

``` r
png(filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/scatterplot-height-weight.png")
plot( y = dat$height, x = dat$weight, pch = 20, 
     xlab = 'Weight', ylab = 'Height')
dev.off()
```

    ## quartz_off_screen 
    ##                 2

  - Save another version of the scatterplot between height and weight,
    but now try to get an image with higher resolution. Save the plot in
    images/.

<!-- end list -->

``` r
png(filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/high-scatterplot-height-weight.png", res = 110)
plot( y = dat$height, x = dat$weight, pch = 20, 
     xlab = 'Weight', ylab = 'Height')
dev.off()
```

    ## quartz_off_screen 
    ##                 2

  - Save a histogram in JPEG format of age with dimensions (width x
    height) 600 x 400 pixels. Save the plot in
images/.

<!-- end list -->

``` r
jpeg(filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/scatterplot-height-weight.jpeg", width = 600, height = 400, units = "px")
plot( y = dat$height, x = dat$weight, pch = 20, 
     xlab = 'Weight', ylab = 'Height')
dev.off()
```

    ## quartz_off_screen 
    ##                 2

  - Use pdf() to save the previous histogram of age in PDF format, with
    dimensions (width x height) 7 x 5
inches.

<!-- end list -->

``` r
pdf(file = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/scatterplot-height-weight.pdf", width = 7, height = 5)
plot(y = dat$height, x = dat$weight, pch = 20, 
     xlab = 'Weight', ylab = 'Height')
dev.off()
```

    ## quartz_off_screen 
    ##                 2

## Exporting some ggplots

The package “ggplot2” comes with a wrapper function ggsave() that allows
you to save ggplot graphics to a specified file. By default, ggsave()
saves images in PDF format.

  - Use ggplot() to make a scatterplot of points and salary, and store
    it in a ggplot object named gg\_pts\_salary. Then use ggsave() to
    save the plot with dimensions (width x height) 7 x 5 inches; in the
    images/ folder as points\_salary.pdf

<!-- end list -->

``` r
gg_pts_salary <- ggplot(dat, aes(x= points, y = salary)) + 
  geom_point()

ggsave(
  filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/points_salary.pdf",
  plot = last_plot(),
  device = "pdf",
  path = NULL,
  scale = 1,
  width = 7,
  height = 5,
  units = "in"
)
```

  - Use ggplot() to create a scatterplot of height and weight, faceting
    by position. Store this in a ggplot object gg\_ht\_wt\_positions
    Then use ggsave() to save the plot with dimensions (width x height)
    6 x 4 inches; in the images/ folder as
    height\_weight\_by\_position.pdf

<!-- end list -->

``` r
height_weight_by_position <- ggplot(dat, aes(x= weight, y = height)) + 
  geom_point() + 
  facet_grid(~ position)

ggsave(
  filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/height_weight_by_position.pdf",
  plot = last_plot(),
  device = "pdf",
  path = NULL,
  scale = 1,
  width = 6,
  height = 4,
  units = "in"
)
```

# More “dplyr”

The last part of this lab involves working the pipe operator %\>% which
allows you write function calls in a more human-readable way. This
becomes extremely useful in “dplyr” operations that require many steps.

The behavior of “dplyr” is functional in the sense that function calls
don’t have side-effects. You must always save their results in order to
keep them in an object (in memory). This doesn’t lead to particularly
elegant code, especially if you want to do many operations at once. You
either have to do it step-by-step:

``` r
# manipulation step-by-step
dat1 <- group_by(dat, team)
dat2 <- select(dat1, team, height, weight)
dat3 <- summarise(dat2,
  avg_height = mean(height, na.rm = TRUE),
  avg_weight = mean(weight, na.rm = TRUE))
dat4 <- arrange(dat3, avg_height)
dat4
```

    ## # A tibble: 30 x 3
    ##    team  avg_height avg_weight
    ##    <chr>      <dbl>      <dbl>
    ##  1 BOS         78.2       220.
    ##  2 HOU         78.3       215.
    ##  3 SAC         78.5       217.
    ##  4 IND         78.5       226.
    ##  5 CHI         78.5       216.
    ##  6 PHO         78.5       214.
    ##  7 BRK         78.7       222.
    ##  8 CHO         78.8       213.
    ##  9 LAC         78.8       225.
    ## 10 CLE         78.9       226.
    ## # … with 20 more rows

Or if you don’t want to name the intermediate results, you need to wrap
the function calls inside each other:

``` r
# inside-out style (hard to read)
arrange(
  summarise(
    select(
      group_by(dat, team),
      team, height, weight
    ),
    avg_height = mean(height, na.rm = TRUE),
    avg_weight = mean(weight, na.rm = TRUE)    
  ),
  avg_height
)
```

    ## # A tibble: 30 x 3
    ##    team  avg_height avg_weight
    ##    <chr>      <dbl>      <dbl>
    ##  1 BOS         78.2       220.
    ##  2 HOU         78.3       215.
    ##  3 SAC         78.5       217.
    ##  4 IND         78.5       226.
    ##  5 CHI         78.5       216.
    ##  6 PHO         78.5       214.
    ##  7 BRK         78.7       222.
    ##  8 CHO         78.8       213.
    ##  9 LAC         78.8       225.
    ## 10 CLE         78.9       226.
    ## # … with 20 more rows

This is difficult to read because the order of the operations is from
inside to out. Thus, the arguments are a long way away from the
function. To get around this problem, “dplyr” provides the %\>% operator
from “magrittr”.

x %\>% f(y) turns into f(x, y) so you can use it to rewrite multiple
operations that you can read left-to-right, top-to-bottom:

``` r
# using %>%
dat %>% 
  group_by(team) %>%
  select(team, height, weight) %>%
  summarise(
    avg_height = mean(height, na.rm = TRUE),
    avg_weight = mean(weight, na.rm = TRUE)) %>%
  arrange(avg_height)
```

    ## # A tibble: 30 x 3
    ##    team  avg_height avg_weight
    ##    <chr>      <dbl>      <dbl>
    ##  1 BOS         78.2       220.
    ##  2 HOU         78.3       215.
    ##  3 SAC         78.5       217.
    ##  4 IND         78.5       226.
    ##  5 CHI         78.5       216.
    ##  6 PHO         78.5       214.
    ##  7 BRK         78.7       222.
    ##  8 CHO         78.8       213.
    ##  9 LAC         78.8       225.
    ## 10 CLE         78.9       226.
    ## # … with 20 more rows

Use the piper operator “%\>%” to perform the following operations:

  - display the player names of Lakers ‘LAL’.

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

  - display the name and salary of GSW point guards ‘PG’.

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

  - dislay the name, age, and team, of players with more than 10 years
    of experience, making 10 million dollars or less.

<!-- end list -->

``` r
dat %>%
  filter(experience > 10 & salary < 1000000 | salary == 1000000) %>%
  select(player, age, team)
```

    ## # A tibble: 6 x 3
    ##   player             age team 
    ##   <chr>            <dbl> <chr>
    ## 1 Dahntay Jones       36 CLE  
    ## 2 Deron Williams      32 CLE  
    ## 3 Jose Calderon       35 ATL  
    ## 4 Matt Barnes         36 GSW  
    ## 5 Montrezl Harrell    23 HOU  
    ## 6 Ronnie Price        33 PHO

  - select the name, team, height, and weight, of rookie players, 20
    years old, displaying only the first five occurrences (i.e. rows).

<!-- end list -->

``` r
dat %>%
  filter(experience < 1 & age == 20) %>%
  select(player, team, height, weight) %>%
  slice(1:5)
```

    ## # A tibble: 5 x 4
    ##   player            team  height weight
    ##   <chr>             <chr>  <dbl>  <dbl>
    ## 1 Jaylen Brown      BOS       79    225
    ## 2 Henry Ellenson    DET       83    245
    ## 3 Stephen Zimmerman ORL       84    240
    ## 4 Dejounte Murray   SAS       77    170
    ## 5 Chinanu Onuaku    HOU       82    245

  - create a data frame gsw\_mpg of GSW players, that contains variables
    for player name, experience, and min\_per\_game (minutes per game),
    sorted by min\_per\_game (in descending order).

<!-- end list -->

``` r
dat %>%
  filter(team == "GSW") %>%
  summarise(player, experience, min_per_game = games/minutes) %>%
  arrange(desc(min_per_game))
```

    ## # A tibble: 15 x 3
    ##    player               experience min_per_game
    ##    <chr>                     <dbl>        <dbl>
    ##  1 Kevon Looney                  1       0.119 
    ##  2 Damian Jones                  0       0.118 
    ##  3 James Michael McAdoo          2       0.114 
    ##  4 JaVale McGee                  8       0.104 
    ##  5 David West                   13       0.0796
    ##  6 Ian Clark                     3       0.0677
    ##  7 Patrick McCaw                 0       0.0661
    ##  8 Shaun Livingston             11       0.0565
    ##  9 Zaza Pachulia                13       0.0552
    ## 10 Matt Barnes                  13       0.0488
    ## 11 Andre Iguodala               12       0.0380
    ## 12 Draymond Green                4       0.0308
    ## 13 Kevin Durant                  9       0.0300
    ## 14 Stephen Curry                 7       0.0299
    ## 15 Klay Thompson                 5       0.0294

  - display the average triple points by team, in ascending order, of
    the bottom-5 teams (worst 3pointer teams).

<!-- end list -->

``` r
dat %>%
  group_by(team) %>%
  summarise(ave_triple = mean(points3)) %>%
  arrange(ave_triple) %>%
  slice(5:10)
```

    ## # A tibble: 6 x 2
    ##   team  ave_triple
    ##   <chr>      <dbl>
    ## 1 LAL         39.5
    ## 2 OKC         40.7
    ## 3 ORL         40.9
    ## 4 TOR         41.7
    ## 5 DET         42.1
    ## 6 NYK         42.4

  - obtain the mean and standard deviation of age, for Power Forwards,
    with 5 and 10 years (including) of experience.

<!-- end list -->

``` r
dat %>%
  filter(position == "PF" & experience < 10 | experience > 5 | experience  == 10 | experience == 5) %>%
  summarise(mean_age = mean(age), sd_age = sd(age))
```

    ## # A tibble: 1 x 2
    ##   mean_age sd_age
    ##      <dbl>  <dbl>
    ## 1     28.6   4.18
