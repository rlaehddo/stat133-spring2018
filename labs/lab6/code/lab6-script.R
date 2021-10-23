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


# packages
library(readr)    # importing data
library(dplyr)    # data wrangling
library(ggplot2)  # graphics

data <- read_csv('/Users/akii_my/Desktop/school/stat133/labs/lab6/data/nba2017-players.csv')

data %>%
  filter(team == "GSW") %>%
  arrange(salary)

write.csv(gsw, file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/data/warriors.csv', row.names = FALSE)

lakers <- dat %>% 
  filter(team == "Los Angeles Lakers") %>%
  arrange(desc(experience))

write.csv(gsw, file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/data/lakers.csv', row.names = FALSE)


sink(file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/output/data-structure.txt')
str(dat)
sink()


sink(file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/output/summary-warriors.txt')
summary(gsw)
sink()



sink(file = '/Users/akii_my/Desktop/school/stat133/labs/lab6/output/summary-lakers.txt')
summary(lakers)
sink()


# saving a scatterplot in png format
png(filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/scatterplot-height-weight.png")
plot(dat$height, dat$weight, pch = 20, 
     xlab = 'Height', ylab = 'Height')
dev.off()


png(filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/scatterplot-height-weight.png")
plot( y = dat$height, x = dat$weight, pch = 20, 
      xlab = 'Weight', ylab = 'Height')
dev.off()


png(filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/high-scatterplot-height-weight.png", res = 110)
plot( y = dat$height, x = dat$weight, pch = 20, 
      xlab = 'Weight', ylab = 'Height')
dev.off()


jpeg(filename = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/scatterplot-height-weight.jpeg", width = 600, height = 400, units = "px")
plot( y = dat$height, x = dat$weight, pch = 20, 
      xlab = 'Weight', ylab = 'Height')
dev.off()


pdf(file = "/Users/akii_my/Desktop/school/stat133/labs/lab6/images/scatterplot-height-weight.pdf", width = 7, height = 5)
plot(y = dat$height, x = dat$weight, pch = 20, 
     xlab = 'Weight', ylab = 'Height')
dev.off()




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



dat %>%
  filter(team == "LAL") %>%
  select(player)

dat %>%
  filter(team == "GSW" & position == "PG") %>%
  select(player, salary)

dat %>%
  filter(experience > 10 & salary < 1000000 | salary == 1000000) %>%
  select(player, age, team)

dat %>%
  filter(experience < 1 & age == 20) %>%
  select(player, team, height, weight) %>%
  slice(1:5)

dat %>%
  filter(team == "GSW") %>%
  summarise(player, experience, min_per_game = games/minutes) %>%
  arrange(desc(min_per_game))

dat %>%
  group_by(team) %>%
  summarise(ave_triple = mean(points3)) %>%
  arrange(ave_triple) %>%
  slice(5:10)

dat %>%
  filter(position == "PF" & experience < 10 | experience > 5 | experience  == 10 | experience == 5) %>%
  summarise(mean_age = mean(age), sd_age = sd(age))
