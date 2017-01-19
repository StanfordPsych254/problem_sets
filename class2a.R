# Code Demo for Class 2a (on the tidyverse)
library(tidyverse)
library(knitr)

################################################################################
# how does group_by work:
d <- expand.grid(name = c("mike","alison","madeline"),
                 condition = c("boring","interesting"))

# group_by will make the mutate operate over different chunks of the data
# here over all the data
d %>% mutate(index = 1:n()) 

# here over names
d %>% 
  group_by(name) %>%
  mutate(index = 1:n()) %>%
  summarise(mean = mean(index))

# here over conditions
d %>% 
  group_by(condition) %>%
  mutate(index = 1:n()) %>%
  summarise(mean = mean(index), 
            variance = var(index))

################################################################################
# base R explorations of the iris dataset
head(iris)
unique(iris$Species)
hist(iris$Sepal.Width)

# ggplot2
qplot(Sepal.Width, data = iris)
qplot(Sepal.Width, data = iris, binwidth = .2)

# gather demo
tidy_iris <- iris %>%
  mutate(iris_id = 1:n()) %>%
  gather(measure_name, centimeters, 
         Sepal.Length, Sepal.Width, 
         Petal.Length, Petal.Width) %>%
  separate(measure_name, 
           into = c("feature","dimension"), 
           sep = "\\.")

# different ways to spread the data: by feature
tidy_iris %>%
  spread(feature, centimeters) %>%
  head %>%
  kable

# by measurement type
tidy_iris %>%
  spread(dimension, centimeters) %>%
  mutate(area = Length * Width) %>%
  head %>%
  kable

# plot
qplot(centimeters, fill = Species, 
      facets = dimension ~ feature,
      data = tidy_iris)

################################################################################
# EXERCISE

# Which species has the widest petals
tidy_iris %>%
  filter(feature == "Petal",
         dimension == "Width") %>%
  group_by(Species) %>%
  summarise(mean = mean(centimeters))

# Which species has the largest (area) petals
iris %>%
  group_by(Species) %>%
  summarise(area = mean(Petal.Width * Petal.Length))

# Another way of doing the same thing
tidy_iris %>%
  filter(feature == "Petal") %>%
  group_by(Species, iris_id) %>%
  summarise(area = centimeters[dimension == "Width"] * 
              centimeters[dimension == "Length"]) %>%
  group_by(Species) %>%
  summarise(mean = mean(area))
