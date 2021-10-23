Lab 12: Getting Started with Web Scraping
================

# Required Packages

In this lab, you will have to load the following R packages:

``` r
library(XML)
library(xml2)
library(rvest)
```

    ## 
    ## Attaching package: 'rvest'

    ## The following object is masked from 'package:XML':
    ## 
    ##     xml

``` r
library(magrittr)
```

## Motivation

The goal of this lab is to extract the Roster Tables of all the NBA
teams from the website <https://www.basketball-reference.com/>

More specifically, you will extract the rosters of the season 2016-2017.
One example of such table is displayed in the image below with the
Roster of Golden State Warriors (GSW):

he GSW Roster table is in the URL:

<https://www.basketball-reference.com/teams/GSW/2017.html>

You can read this table in R via the “XML” function readHTMLTable():

``` r
# Assemble url (so it fits on screen)
basket <- "https://www.basketball-reference.com"
gsw <- "/teams/GSW/2017.html"
gsw_url <- paste0(basket, gsw)

# download HTML file to your working directory
download.file(gsw_url, 'gsw-roster-2017.html')

# Read GSW Roster html table
gsw_roster <- readHTMLTable('gsw-roster-2017.html')
```

If you inspect the contents of gsw\_roster you should be able to see
some content like
    this:

``` r
gsw_roster$roster
```

    ##    No.               Player Pos   Ht  Wt         Birth Date    Exp
    ## 1   22          Matt Barnes  SF  6-7 226      March 9, 1980 us  13
    ## 2   21            Ian Clark  SG  6-3 175      March 7, 1991 us   3
    ## 3   30        Stephen Curry  PG  6-3 185     March 14, 1988 us   7
    ## 4   35         Kevin Durant  PF 6-10 240 September 29, 1988 us   9
    ## 5   23       Draymond Green  PF  6-6 230      March 4, 1990 us   4
    ## 6    9       Andre Iguodala  SF  6-6 215   January 28, 1984 us  12
    ## 7   15         Damian Jones   C 6-11 245      June 30, 1995 us   R
    ## 8   34     Shaun Livingston  PG  6-7 192 September 11, 1985 us  11
    ## 9    5         Kevon Looney   C  6-9 222   February 6, 1996 us   1
    ## 10  20 James Michael McAdoo  PF  6-9 230    January 4, 1993 us   2
    ## 11   0        Patrick McCaw  SG  6-7 181   October 25, 1995 us   R
    ## 12   1         JaVale McGee   C  7-0 270   January 19, 1988 us   8
    ## 13  27        Zaza Pachulia   C 6-11 270  February 10, 1984 ge  13
    ## 14  11        Klay Thompson  SG  6-6 215   February 8, 1990 us   5
    ## 15  18     Anderson Varejão   C 6-10 273 September 28, 1982 br  12
    ## 16   2        Briante Weber  PG  6-2 165  December 29, 1992 us   1
    ## 17   3           David West   C  6-9 250    August 29, 1980 us  13
    ##             College
    ## 1              UCLA
    ## 2           Belmont
    ## 3          Davidson
    ## 4             Texas
    ## 5    Michigan State
    ## 6           Arizona
    ## 7        Vanderbilt
    ## 8                  
    ## 9              UCLA
    ## 10              UNC
    ## 11             UNLV
    ## 12           Nevada
    ## 13                 
    ## 14 Washington State
    ## 15                 
    ## 16              VCU
    ## 17           Xavier

## Roster tables

Say you are interested in obtaining the Roster table for the Boston
Celtics (BOS). You could get such table by adapting the code used to get
the GSW roster. The only thing you need to change is the team
abbreviation from GSW to BOS:

``` r
# Assemble url (so it fits on screen)
basket <- "https://www.basketball-reference.com"
bos <- "/teams/BOS/2017.html"
bos_url <- paste0(basket, bos)

# download HTML file to your working directory
download.file(bos_url, 'bos-roster-2017.html')

# Read BOS Roster html table
bos_roster <- readHTMLTable('bos-roster-2017.html')
```

In order to get the Roster tables of all the NBA teams, you would need
to repeat the same operation with the corresponding team abbreviations.
But how do you get these abbreviations in a programmatic way?

# 2016-17 NBA Season Summary

To get the team abbreviations in a programmatic way, you need to find
URLs of the form “/teams/GSW/2017.html”, “/teams/BOS/2017.html”, etc.
These pieces of information are available in the Basketball-Reference
website in several web pages.

One of those web pages is the 2016-17 NBA Season Summary which can be
accessed in the following URL:

<https://www.basketball-reference.com/leagues/NBA_2017.html>

In particular, this page contains information about the Conference
Standings displayed in two HTML tables

We don’t really care about the conference standings. What we care about
is that these two HTML tables contain both: the names of the NBA teams
(rendered on your browser), as well as the href attributes of the form:
“/teams/GSW/2017.html”.

If you use Google Chrome as your web browser, you can inspect the HTML
source code by right clicking on your mouse, and selecting the Inspect
option. For instance, place the cursor over the Boston Celtics link, and
then launch the inspector:

If you look at the HTML source, you will see the href attributes for
each team page. In other words, these are the links to each team’s web
page. And this is exactly the piece of information we are looking for:
the team abbreviations.

## Extracting HTML elements

So how do we extract these href attributes? The first step is to read
the contents of the html file:

<https://www.basketball-reference.com/leagues/NBA_2017.html>

This can be done with the function read\_html()

``` r
nba_html <- paste0(basket, "/leagues/NBA_2017.html")

xml_doc <- read_html(nba_html)
```

The object xml\_doc is an object of class “xml\_document”. If you are
curious about extracting all the content in a character vector, then use
the function html\_text(), chained with the pipe %\>% operator:

``` r
xml_text <- xml_doc %>% html_text()
```

The object xml\_text is a character vector that contains the content of
the html file.

## Extracting elements h2

Before attempting extracting the href attributes, let’s begin with
something simpler. For example, let’s see how to extract the value of
all the HTML elements h2 (i.e. headings of level 2). This can be done
with the function html\_nodes(), and then html\_text()

``` r
# content of h2 nodes
xml_doc %>%
  html_nodes("h2") %>%
  html_text() 
```

    ##  [1] "Conference Standings"         " "                           
    ##  [3] "Division Standings"           " "                           
    ##  [5] "Playoff Series"               "Per Game Stats"              
    ##  [7] "Per Game Stats"               "Total Stats"                 
    ##  [9] "Total Stats"                  "Per 100 Poss Stats"          
    ## [11] "Per 100 Poss Stats"           "Advanced Stats"              
    ## [13] "Shooting Stats"               "Shooting Stats"              
    ## [15] "League Awards"                "Players of the Week & Month" 
    ## [17] "League Leaders"               "All-NBA"                     
    ## [19] "All-Defensive"                "All-Rookie"                  
    ## [21] "All-Star Game Rosters"        "More 2016-17 NBA Pages"      
    ## [23] "Full Site Menu"               "We're Social...for Statheads"
    ## [25] "FAQs, Tip & Tricks"

You can pass the name of an HTML element (i.e. a tag or node) to
html\_nodes(). In this case, we indicate that we want to locate the
nodes “h2”. And then we call html\_text() to extract the actual content
in those nodes.

### Your turn

Use html\_nodes() and html\_text() to extract the values of nodes:

  - “h1”
  - “strong”
  - “button”

<!-- end list -->

``` r
#h1
xml_doc %>%
  html_nodes("h1") %>%
  html_text() 
```

    ## [1] "\n\t\t\t\t\n\t\t\t\t2016-17 NBA Season Summary\n\t\t\t\t\n\t\t\t"

``` r
#strong
xml_doc %>%
  html_nodes("strong") %>%
  html_text() 
```

    ##  [1] "Season Summary"       "League Champion"      "Most Valuable Player"
    ##  [4] "Rookie of the Year"   "PPG Leader"           "RPG Leader"          
    ##  [7] "APG Leader"           "WS Leader"            "Player Stats"        
    ## [10] "Other"                "Atlantic Division"    "Central Division"    
    ## [13] "Southeast Division"   "Northwest Division"   "Pacific Division"    
    ## [16] "Southwest Division"   "Player Stats"         "Other"               
    ## [19] "Season Summary"       "In the News"          "All-Time Greats"     
    ## [22] "Active Greats"        "Atlantic"             "Central"             
    ## [25] "Southeast"            "Northwest"            "Pacific"             
    ## [28] "Southwest"            "Player Finders"       "Team Finders"        
    ## [31] "WNBA Tools"           "Other Finders"        "Site Last Updated:"

``` r
#button
xml_doc %>%
  html_nodes("button") %>%
  html_text() 
```

    ## [1] "More league info"

What if you want to extract HTML tags or nodes that have an attribute?
For instance, if you look at the source code, starting at line 356 you
will see the HTML elements for Player Stats

As you can tell, there is a p element (i.e. html paragraph) of class
“listhead”. You can actually specify this type of node with the name
of the html element, followed by a dot, followed by the name of the
attribute

``` r
# node with an attribute
xml_doc %>%
  html_nodes("p.listhead") %>%
  html_text()
```

    ## [1] "Player Stats"          "Other"                 "2017 Playoffs Summary"
    ## [4] "On this page:"         "Player Stats"          "Other"                
    ## [7] "2017 Playoffs Summary"

# XPath

In order to specify HTML elements that are embeded inside other HTML
elements, you need to use XPaths.

XPath expressions have a syntax similar to the way files are located in
a hierarchy of directories/folders in a computer file system. To be more
precise, Xpath expressions allow you to indicate the specific path that
must be taken to arrive at a given node.

In general, we can specify paths through the tree structure:

  - based on node names
  - based on node content
  - based on a node’s relationship to other nodes

Let’s go back to the p.listhead nodes. These can be extracted with an
Xpath expression like this:

``` r
xml_doc %>%
  html_nodes(xpath = '//p[@class="listhead"]') %>%
  html_text()
```

    ## [1] "Player Stats"          "Other"                 "2017 Playoffs Summary"
    ## [4] "Player Stats"          "Other"                 "2017 Playoffs Summary"

The XPath ‘//p\[@class="listhead"\]’ means that we want to locate,
anywhere in the tree (//), all

<p>

nodes that have an attribute named class that takes the value
“listhead”.

What if you want to extract the <a> values inside the listed items

<li>

, within the unlisted list

<ul>

?

``` r
xml_doc %>%
  html_nodes(xpath = '//ul[@class=""]/li/a') %>%
  html_text()
```

    ##  [1] "Per Game"             "Totals"               "Per 36 Minutes"      
    ##  [4] "Per 100 Possessions"  "Adjusted Shooting"    "Advanced"            
    ##  [7] "Play-by-Play"         "Shooting"             "Rookies"             
    ## [10] "Final Season"         "Team Ratings"         "Uniform Numbers"     
    ## [13] "Transactions"         "Standings by Date"    "Preseason Odds"      
    ## [16] "Standings"            "Schedule and Results" "Leaders"             
    ## [19] "Coaches"              "Per Game"             "Totals"              
    ## [22] "Per 36 Minutes"       "Per 100 Possessions"  "Adjusted Shooting"   
    ## [25] "Advanced"             "Play-by-Play"         "Shooting"            
    ## [28] "Rookies"              "Final Season"         "Team Ratings"        
    ## [31] "Uniform Numbers"      "Transactions"         "Standings by Date"   
    ## [34] "Preseason Odds"       "Standings"            "Schedule and Results"
    ## [37] "Leaders"              "Coaches"              "Per Game"            
    ## [40] "Totals"               "Per 36 Minutes"       "Per 100 Possessions" 
    ## [43] "Adjusted Shooting"    "Advanced"             "Play-by-Play"        
    ## [46] "Shooting"             "Rookies"              "Final Season"        
    ## [49] "Team Ratings"         "Uniform Numbers"      "Transactions"        
    ## [52] "Standings by Date"    "Preseason Odds"

or equivalently:

``` r
xml_doc %>%
  html_nodes(xpath = '//ul[@class=""]//a') %>%
  html_text()
```

    ##  [1] "Per Game"             "Totals"               "Per 36 Minutes"      
    ##  [4] "Per 100 Possessions"  "Adjusted Shooting"    "Advanced"            
    ##  [7] "Play-by-Play"         "Shooting"             "Rookies"             
    ## [10] "Final Season"         "Team Ratings"         "Uniform Numbers"     
    ## [13] "Transactions"         "Standings by Date"    "Preseason Odds"      
    ## [16] "Standings"            "Schedule and Results" "Leaders"             
    ## [19] "Coaches"              "Per Game"             "Totals"              
    ## [22] "Per 36 Minutes"       "Per 100 Possessions"  "Adjusted Shooting"   
    ## [25] "Advanced"             "Play-by-Play"         "Shooting"            
    ## [28] "Rookies"              "Final Season"         "Team Ratings"        
    ## [31] "Uniform Numbers"      "Transactions"         "Standings by Date"   
    ## [34] "Preseason Odds"       "Standings"            "Schedule and Results"
    ## [37] "Leaders"              "Coaches"              "Per Game"            
    ## [40] "Totals"               "Per 36 Minutes"       "Per 100 Possessions" 
    ## [43] "Adjusted Shooting"    "Advanced"             "Play-by-Play"        
    ## [46] "Shooting"             "Rookies"              "Final Season"        
    ## [49] "Team Ratings"         "Uniform Numbers"      "Transactions"        
    ## [52] "Standings by Date"    "Preseason Odds"

## Extracting href attributes

Let’s focus again on the first two html tables of the page
<https://www.basketball-reference.com/leagues/NBA_2017.html>.

To extract the first “table” you can use html\_nodes() and extract() as
follows:

``` r
# extracting first table 
xml_table1 <- xml_doc %>%
  html_nodes("table") %>%
  extract(1)

class(xml_table1)
```

    ## [1] "xml_nodeset"

The object xml\_table1 is not really an R table, but an object of class
xml\_nodeset. To extract the html table as a data frame, “rvest”
provides the function html\_table():

``` r
tbl1 <- html_table(xml_table1)

head(tbl1)
```

    ## [[1]]
    ##      Eastern Conference  W  L  W/L%   GB  PS/G  PA/G   SRS
    ## 1       Boston Celtics* 53 29 0.646    — 108.0 105.4  2.25
    ## 2  Cleveland Cavaliers* 51 31 0.622  2.0 110.3 107.2  2.87
    ## 3      Toronto Raptors* 51 31 0.622  2.0 106.9 102.6  3.65
    ## 4   Washington Wizards* 49 33 0.598  4.0 109.2 107.4  1.36
    ## 5        Atlanta Hawks* 43 39 0.524 10.0 103.2 104.0 -1.23
    ## 6      Milwaukee Bucks* 42 40 0.512 11.0 103.6 103.8 -0.45
    ## 7       Indiana Pacers* 42 40 0.512 11.0 105.1 105.3 -0.64
    ## 8        Chicago Bulls* 41 41 0.500 12.0 102.9 102.4  0.03
    ## 9            Miami Heat 41 41 0.500 12.0 103.2 102.1  0.77
    ## 10      Detroit Pistons 37 45 0.451 16.0 101.3 102.5 -1.29
    ## 11    Charlotte Hornets 36 46 0.439 17.0 104.9 104.7 -0.07
    ## 12      New York Knicks 31 51 0.378 22.0 104.3 108.0 -3.87
    ## 13        Orlando Magic 29 53 0.354 24.0 101.1 107.6 -6.61
    ## 14   Philadelphia 76ers 28 54 0.341 25.0 102.4 108.1 -5.83
    ## 15        Brooklyn Nets 20 62 0.244 33.0 105.8 112.5 -6.74

Likewise, the second html table can be extracted (as an xml\_nodeset) in
the following way:

``` r
# extracting second table 
xml_table2 <- xml_doc %>%
  html_nodes("table") %>%
  extract(2)
```

Actually, both tables can be extracted simultaneously:

``` r
# two html tables
xml_tables <- xml_doc %>%
  html_nodes("table") %>%
  extract(1:2)
```

Having extracted the tables we are interested in, we can select the <a>
nodes, and then extract the content that corresponds to the name of the
teams:

``` r
# extract names of teams
xml_tables %>% 
  html_nodes("a") %>%
  html_text()
```

    ##  [1] "Boston Celtics"         "Cleveland Cavaliers"    "Toronto Raptors"       
    ##  [4] "Washington Wizards"     "Atlanta Hawks"          "Milwaukee Bucks"       
    ##  [7] "Indiana Pacers"         "Chicago Bulls"          "Miami Heat"            
    ## [10] "Detroit Pistons"        "Charlotte Hornets"      "New York Knicks"       
    ## [13] "Orlando Magic"          "Philadelphia 76ers"     "Brooklyn Nets"         
    ## [16] "Golden State Warriors"  "San Antonio Spurs"      "Houston Rockets"       
    ## [19] "Los Angeles Clippers"   "Utah Jazz"              "Oklahoma City Thunder" 
    ## [22] "Memphis Grizzlies"      "Portland Trail Blazers" "Denver Nuggets"        
    ## [25] "New Orleans Pelicans"   "Dallas Mavericks"       "Sacramento Kings"      
    ## [28] "Minnesota Timberwolves" "Los Angeles Lakers"     "Phoenix Suns"

In order to get the href attributes we need to use the html\_attr()
function:

``` r
# href attributes
xml_tables %>% 
  html_nodes("a") %>%
  html_attr("href")
```

    ##  [1] "/teams/BOS/2017.html" "/teams/CLE/2017.html" "/teams/TOR/2017.html"
    ##  [4] "/teams/WAS/2017.html" "/teams/ATL/2017.html" "/teams/MIL/2017.html"
    ##  [7] "/teams/IND/2017.html" "/teams/CHI/2017.html" "/teams/MIA/2017.html"
    ## [10] "/teams/DET/2017.html" "/teams/CHO/2017.html" "/teams/NYK/2017.html"
    ## [13] "/teams/ORL/2017.html" "/teams/PHI/2017.html" "/teams/BRK/2017.html"
    ## [16] "/teams/GSW/2017.html" "/teams/SAS/2017.html" "/teams/HOU/2017.html"
    ## [19] "/teams/LAC/2017.html" "/teams/UTA/2017.html" "/teams/OKC/2017.html"
    ## [22] "/teams/MEM/2017.html" "/teams/POR/2017.html" "/teams/DEN/2017.html"
    ## [25] "/teams/NOP/2017.html" "/teams/DAL/2017.html" "/teams/SAC/2017.html"
    ## [28] "/teams/MIN/2017.html" "/teams/LAL/2017.html" "/teams/PHO/2017.html"

Bingo\!\!\!

## Your turn

  - Store the href attributes in a character vector hrefs.

<!-- end list -->

``` r
hrefs <- xml_tables %>% 
  html_nodes("a") %>%
  html_attr("href")
```

  - Use string manipulation functions to create a character vector teams
    that contains just the team abbreviations: e.g. “BOS”, “CLE”, “TOR”,
    …

<!-- end list -->

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
library(stringr)

abbreviations <- str_sub(hrefs, -13, -11)


# vector of team abbreviations
teams <- str_sub(hrefs, 8, 10)
```

  - Create a character vector files with elements:
    “BOS-roster-2017.csv”, “CLE-roster-2017.csv”,
    “TOR-roster-2017.csv”, …

<!-- end list -->

``` r
csv <- hrefs %>%
  str_sub(-13) %>%
  str_replace(pattern = '/', replacement = '-roster-') %>%
  str_replace(pattern = 'html', replacement = 'csv')


# vector of csv file names
files <- paste0(teams, '-roster-2017.csv')
```

  - Use the object basket and the first element of hrefs
    (i.e. hrefs\[1\]) to assemble a team\_url like the one used for
    gsw\_url:

<!-- end list -->

``` r
# modify with `hrefs[1]`
basket <- "https://www.basketball-reference.com"
gsw <- "/teams/GSW/2017.html"
gsw_url <- paste0(basket, gsw)
```

  - Read the html document of team\_url.

<!-- end list -->

``` r
# first team
team_url <- paste0(basket, hrefs[1])
```

  - Use html\_table() to extract the content of the html table as a data
    frame called roster.

<!-- end list -->

``` r
# roster table(as a data frame)
roster <- read_html(team_url) %>%
  html_nodes("table") %>%
  html_table()
```

  - Store the data frame in a csv file: “BOS-roster-2017.csv”.

<!-- end list -->

``` r
# exporting first csv file
write.csv(roster[[1]], files[1])
```

Having making sure that your code above works, now generalize it to more
teams. In theory, your code should be able to collect all 30 roster
tables. However, since everyone will be making constant requests to the
basketball-reference website at the same time, write code that scrapes a
couple of roster tables (e.g. 5 or 7 teams).

  - Create a for () loop to extract a handful of the roster tables as
    data frames.
  - Store each table in its own csv file: e.g. “GSW-roster-2017.csv”

<!-- end list -->

``` r
# for loop for all roster tables
for (i in 1:length(teams)) {
  # assemble url
  team_url <- paste0(basket, hrefs[i])
  # get roster (data frame)
  roster <- read_html(team_url) %>%
    html_nodes("table") %>%
    html_table()
  # export table
  write.csv(roster[[1]], files[i])
}
```
