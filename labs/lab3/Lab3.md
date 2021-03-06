Lab 3: Command Line Basics and Git
================
Amy Kim

# Basic Bash shell commands

The first part of the lab involves navigating the file system and
manipulating files (and directories) with the following basic bash
commands:

  - pwd: print working directory
  - ls: list files and directories
  - cd: change directory (move to another directory)
  - mkdir: create a new directory
  - touch: create a new (empty) file
  - cp: copy file(s)
  - mv: rename file(s)
  - rm: delete file(s)

If you are using git-bash (i.e. your OS is Windows) you don’t have the
man command to see the manual documentation of other commands. In this
case you can check the man pages online:

[link](http://man7.org/linux/man-pages/index.html)

## Your Turn

Write your bash commands in a text editor (NOT a word processor) and
save them in a text file: e.g. lab03-gaston-sanchez.txt.

  - Open (or launch) the command line

  - Use mkdir to create a new directory stat133-lab03

  - Change to the directory stat133-lab03

  - Use the command curl to download the following text file: “curl -O
    <http://textfiles.com/food/bread.txt>”

  - Use the command ls to list the contents in your current directory

  - Use the command curl to download these other text files

[link](http://textfiles.com/food/btaco.txt)

[link](http://textfiles.com/food/1st_aid.txt)

[link](http://textfiles.com/food/beesherb.txt)

  - Use the command curl to download the following csv
files:

[link](http://archive.ics.uci.edu/ml/machine-learning-databases/forest-fires/forestfires.csv)

[link](http://www.math.uah.edu/stat/data/Fisher.csv)

[link](http://web.pdx.edu/~gerbing/data/cars.csv)

  - Now try ls -l to list the contents in your current directory in long
    format

  - Look at the man documentation of ls to find out how to list the
    contents in reverse order

  - How would you list the contents in long format and by time?

  - Inside stat133-lab03 create a directory data

  - Change to the directory data

  - Create a directory txt-files

  - Create a directory csv-files

  - Use the command mv to move the bread.txt file to the folder
    txt-files

  - Use the wildcard \* to move all the text files to the directory
    txt-files

  - Use the wildcard \* to move all the .csv files to the directory
    csv-files

  - Go back to the parent directory stat133-lab03

  - Create a directory copies

  - Use the command cp to copy the bread.txt file (the one inside the
    folder txt-files) to the copies directory

  - Use the wildcard \* to copy all the .txt files in the directory
    copies

  - Use the wildcard \* to copy all the .csv files in the directory
    copies

  - Change to the directory copies

  - Use the command mv to rename the file bread.txt as bread-recipe.txt

  - Rename the file Fisher.csv as iris.csv

  - Rename the file btaco.txt as breakfast-taco.txt

  - Change to the parent directory (i.e. stat133-lab03)

  - Rename the directory copies as copy-files

  - Find out how to use the rm command to delete the directory
    copy-files

  - List the contents of the directory txt-files displaying the results
    in reverse (alphabetical) order

# Git and Github Practice

## 1\) Create a New GitHub Repository

  - Open your browser and Sign in to your github account.
  - Locate the + button (next to your avatar).
  - Select the New repository option.
  - Choose a name for your repository: e.g. demo-repo.
  - In the Description field add a brief description: e.g. “this is a
    demo repo”
  - Use the default settings, and click the green button Create
    repository.
  - You should see some content similar (but not identical) to the one
    below:

<!-- end list -->

``` r
#echo "# Demo Repo" >> README.md
#git init
#git add README.md
#git commit -m "first commit"
#git remote add origin https://github.com/gastonstat/demo-repo.git
#git push -u origin master
```

## 2\) Create a local Git Repository

  - Open the terminal (Mac Terminal, or Git-Bash for Windows users).

  - Optional: change directory to your preferred location e.g. your
    Desktop

<!-- end list -->

``` r
#cd Desktop
```

  - Create a directory with the name of your github repo

<!-- end list -->

``` r
#mkdir demo-repo
```

  - Change to the directory you just created

<!-- end list -->

``` r
#cd demo-repo
```

  - Initialize the directory as a git repository

<!-- end list -->

``` r
#git init
```

It’s possible that you encounter some error message, e.g. Mac users may
get a message related with a missing component for CommandLineTools. If
this your case, then type in the terminal console:

``` r
# Mac users may need to run this command
# xcode-select --install
```

The command git init will set-up your directory demo-repo as a Git
repository (NOT to confuse with your GitHub repository). This is
basically your local repository.

## 3\) Adding a README file

It is customary to add a README.md file at the top level. This file must
contain (at least) a description of what the repository is about. The
following command will create a README.md file with some minimalist
content:

``` r
# echo "# Demo Repo" >> README.md
```

  - So far there you have a “new” file in your local repo, but this
    change has not been recorded by Git. You can confirm this by
    checking the status of the repo:

<!-- end list -->

``` r
# git status
```

  - Notice that Git knows that README.md is untracked. So let’s add the
    changes to Git’s database:

<!-- end list -->

``` r
# git add README.md
```

  - Check the status of the repo again:

<!-- end list -->

``` r
#git status
```

  - Now Git is tracking the file README.md.

  - Next thing consists of committing the changes

<!-- end list -->

``` r
#git commit -m "first commit"
```

## 4\) Adding a remote

Right now you have a (local) Git repository in your computer. And you
also have a GitHub repository in your GitHub account. Both repositories
should have the same name, and the goal is to link them. To do this, you
need to tell Git that a remote repository (i.e. the one in GitHub) will
be added:

To add a remote repository use the command below with your own username:

``` r
# git remote add origin https://github.com/username/demo-repo.git
```

Verify your new remote

``` r
# git remote -v
```

If everything is okay, you should be able to see a message (with your
own username) like this:

``` r
# Verify new remote
#origin  https://github.com/username/demo-repo.git (fetch)
#origin  https://github.com/username/demo-repo.git (push)
```

## Pushing changes to a remote repo

  - Now that you have linked your local repo with your remote repo, you
    can start pushing (i.e. uploading) commits to GitHub.

  - As part of the basic workflow with git and github, you want to
    constantly check the status of your repo

<!-- end list -->

``` r
#git status
```

  - Now let’s push your recent commit to the remote branch (origin) from
    the local branch (master):

<!-- end list -->

``` r
#git push origin master
```

  - Go to your Github repository and refresh the browser. If everything
    went fine, you should be able to see the contents of your customized
    README.md file.
