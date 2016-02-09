rm(list=ls())
library(ggplot2)
library(tidyr)
library(dplyr)

head(iris)
unique(iris$Species)
hist(iris$Sepal.Width)
qplot(Sepal.Width, data = iris)
qplot(Sepal.Length, data = iris)

tidy.iris <- iris %>%
  mutate(index = 1:n()) %>%
  gather(measure_name, measure_value, 
         Sepal.Length, Sepal.Width, 
         Petal.Length, Petal.Width) %>%
  spread(measure_name, measure_value)

qplot(measure_value, 
      facets = ~ Species,
      data = tidy.iris)