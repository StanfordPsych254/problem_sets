library(tidyverse)

head(iris)
unique(iris$Species)
hist(iris$Sepal.Width)
qplot(Sepal.Width, data = iris)
qplot(Sepal.Width, data = iris, binwidth = .2)

# gather up
tidy_iris <- iris %>%
  mutate(index = 1:n()) %>%
  gather(measure_name, measure_value, 
         Sepal.Length, Sepal.Width, 
         Petal.Length, Petal.Width) 

# spread just for kicks
wide_iris <- tidy_iris %>%
  spread(measure_name, measure_value)

# plot
qplot(measure_value, 
      facets = measure_name ~ Species,
      data = tidy_iris)