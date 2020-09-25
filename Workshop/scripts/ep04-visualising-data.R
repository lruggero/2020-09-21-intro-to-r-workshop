##VISUALISING DATA WITH ggplot2

#load the packages you need
#you don't need quotation marks to select it 
#as we've already 'downloaded' the tidyverse to this project, so R will know what it's looking for
#you could also load the entire tidyverse, rather than just ggplot

library(ggplot2)
#now load the data
surveys_complete <- read_csv("data_raw/surveys_complete.csv")

#error tells us that it needs a package to read in the data (read.csv is from base R, read_csv is form the tidyverse)
#so lets load that
library(tidyverse)
surveys_complete <- read_csv("data_raw/surveys_complete.csv")
#now we've been able to read the csv in

#lets make a plot
ggplot(data = surveys_complete)
#it knows I want to make a plot - but I haven't given it enough info
#we need to give it the axes
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))
#still not enough - we need to tell it what type of display we want:
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()
#we have made a plot!
#you always need those 3 steps (the grammar of plotting):
#give it data, tell it the mappings (x & y aixs in this came) and tell it a geom (how to display)

#good to know:
#any aesthetic that you add inside the ggplot parentheses will be added at every layer (global)
#aesthetics that you add into the geom parentheses will just be added at that layer

#lets assign a plot to a object/variable
surveys_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))
#to look at it, run the object as code (need to add a geom)
surveys_plot +
  geom_point()
surveys_plot +
  geom_boxplot()


#CHALLENGES:
#-------
##CHALLENGE 1
# Change the mappings so weight is on the y-axis and hindfoot_length is on the x-axis

ggplot(data = surveys_complete, mapping = aes(y = weight, x = hindfoot_length)) + 
  geom_point()

#you could also take the object we stored as a plot, but tell it at the top layer to swap the axes around:
surveys_plot + 
  geom_point(aes(y = weight, x = hindfoot_length))



## CHALLENGE 2
#how would you create a histogram of weights?

ggplot(data = surveys_complete, mapping = aes(weight)) +
  geom_histogram()
#this warms that it is default using bin width = 30 and i might like to try changing it
#ie this changes the width of the columns and also the no of columns across the axis (more resolution)

ggplot(data = surveys_complete, mapping = aes(weight)) +
  geom_histogram(binwidth = 10)

#(Or not using ggpolt you could use base R):
hist(surveys_complete$weight)

#-------

#

