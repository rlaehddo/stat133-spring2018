#=============
#title: nba players shots 
#description: this script is the data preparation phase and create a csv data file that contain variables used in the visualization phase.
#input: nba-players.csv
#output: nba-players-summary.txt
#Author: Amy Kim
#Date: 3/5/2018
#=============

#Part 2.1: Download the data and PART 3:Data Preparation
library(dplyr)

#data import
getwd()

curry <- read.csv("./data/stephen-curry.csv", stringsAsFactors = FALSE)
green <- read.csv("./data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("./data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("./data/klay-thompson.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("./data/andre-iguodala.csv", stringsAsFactors = FALSE)


#adjust data: add name
curry["name"] = "Stephen Curry"
green["name"] = "Draymond Green"
durant["name"] = "Kevin Durant"
thompson["name"] = "Klay Thompson"
iguodala["name"] = "Andre Iguodala"

#adjust data: shots made and missed
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "made_shot"
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "missed_shot"
green$shot_made_flag[green$shot_made_flag == "y"] <- "made_shot"
green$shot_made_flag[green$shot_made_flag == "n"] <- "missed_shot"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "made_shot"
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "missed_shot"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "made_shot"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "missed_shot"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "made_shot"
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "missed_shot"

#adjust data: minute scored
curry <- mutate(curry, minute = ((period*12) - minutes_remaining))
green <- mutate(green, minute = ((period*12) - minutes_remaining))
durant <- mutate(durant, minute = ((period*12) - minutes_remaining))
thompson <- mutate(thompson, minute = ((period*12) - minutes_remaining))
iguodala <- mutate(iguodala, minute = ((period*12) - minutes_remaining))


shots_data <-mutate(shots_data, minute = ((period*12) - minutes_remaining))


#sink summary
sink(file = "./output/stephen-curry-summary.txt")
summary(curry)
sink()
sink(file = "./output/draymond-green-summary.txt")
summary(green)
sink()
sink(file = "./output/kevin-durant-summary.txt")
summary(durant)
sink()
sink(file = "./output/klay-thompson-summary.txt")
summary(thompson)
sink()
sink(file = "./output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

#combine dataframes
shots_data <- rbind(curry, green, durant, thompson, iguodala)

#write assembled table
write.csv(shots_data, file = "./data/shots-data.csv")

#shots_data_summary
sink(file = "./output/shots-data-summary.txt")
summary(shots_data)
sink()

