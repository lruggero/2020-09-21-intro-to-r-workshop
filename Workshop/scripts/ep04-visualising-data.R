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

#BUILDING PLOTS ITERATIVELY:
#we can change lots of things about the plot

#EG change transparency of the dots, then you can see where there's higher density areas:
ggplot(data = surveys_complete, mapping = aes(y = weight, x = hindfoot_length)) + 
  geom_point(alpha = 0.1)

#EG add colour
ggplot(data = surveys_complete, mapping = aes(y = weight, x = hindfoot_length)) + 
  geom_point(alpha = 0.1, colour = "blue")

#use data to do the colouring for us
ggplot(data = surveys_complete, mapping = aes(y = weight, x = hindfoot_length)) + 
  geom_point(alpha = 0.1, aes(colour = species_id))

#the colour can be at either the global or local level in this current code
ggplot(data = surveys_complete, mapping = aes(y = weight, x = hindfoot_length, colour = species_id)) + 
  geom_point(alpha = 0.1)

#CHALLENGE 3
#Use what you just learned to create a scatter plot of weight over species_id with the plot type showing in different colours. 
# Is this a good way to show this type of data?

ggplot(data = surveys_complete, mapping = aes(y = weight, x = species_id, colour = plot_type)) + 
  geom_point(alpha = 0.2)

#different way of displaying is 'jitter' plot - so the points are not so overlapping
ggplot(data = surveys_complete, mapping = aes(y = weight, x = species_id, colour = plot_type)) + 
  geom_jitter(alpha = 0.4)

#is this a good way to display the data?
#no - this illustrates the point that sometimes you need to try one and then try a bunch of others

#different way of displaying is 'jitter' plot - so the points are not so overlapping
ggplot(data = surveys_complete, mapping = aes(y = weight, x = species_id, colour = plot_type)) + 
  geom_boxplot(alpha = 0.4)



#BOXPLOTS:
#good for when you have 1x discrete (categorical variable) and 1x continuous variable
ggplot(data = surveys_complete, mapping =aes(x = species_id, y = weight))+
  geom_boxplot()
#this looks much better

#we can play around with it eg add scatter points on top of the boxplot to show the distribution
ggplot(data = surveys_complete, mapping =aes(x = species_id, y = weight))+
  geom_boxplot(alpha = 0) + 
  geom_jitter(alpha = 0.3,colour = "tomato")

#Challenge 4
#Notice how the boxplot layer is behind the jitter layer? What do you need to change in the code to put the boxplot in front of the points such that it’s not hidden?
#reorder which one R is told first. If it's told jitter first, it will plot anything else it's told on top of that
  
ggplot(data = surveys_complete, mapping =aes(x = species_id, y = weight))+
  geom_jitter(alpha = 0.3,colour = "tomato") +
  geom_boxplot(alpha = 0)

#you can also change the transparency of the box in the boxplot
ggplot(data = surveys_complete, mapping =aes(x = species_id, y = weight))+
  geom_jitter(alpha = 0.3,colour = "tomato") +
  geom_boxplot(alpha = 0.5)

#Challenge 5
#Boxplots are useful summaries but hide the shape of the distribution. For example, if there is a bimodal distribution, it would not be observed with a boxplot. An alternative to the boxplot is the violin plot (sometimes known as a beanplot), where the shape (of the density of points) is drawn.
#Replace the box plot with a violin plot

ggplot(data = surveys_complete, mapping =aes(x = species_id, y = weight))+
  geom_violin(alpha = 0.3,colour = "tomato")


#Challenge 6
#So far, we’ve looked at the distribution of weight within species. 
#Make a new plot to explore the distribution of hindfoot_length within each species.
#Add color to the data points on your boxplot according to the plot from which the sample was taken (plot_id).
#Hint: Check the class for plot_id. Consider changing the class of plot_id from integer to factor. How and why does this change how R makes the graph?


ggplot(data = surveys_complete, mapping =aes(x = species_id, y = hindfoot_length))+
  geom_jitter(alpha = 0.3, colour = "blue") +
  geom_boxplot(alpha = 0)

#BUt plot_id is currently a number (integer class)

ggplot(data = surveys_complete, mapping =aes(x = species_id, y = hindfoot_length))+
  geom_jitter(alpha = 0.3, aes(colour = plot_id)) +
  geom_boxplot(alpha = 0)
#you need to put it inside as AES bracket!! (i missed why but it was on the recording, 
#something about telling it to get this infor from the dataframe and not the package)

#now it is giving us all shades of blue, becasue it's integer
#lets check this:
class(surveys_complete$plot_id)
#it's numeric
#to change the colouring to all colours, then we need to change it to being a factor (categorical variable)

surveys_complete$plot_id <- 
as.factor(surveys_complete$plot_id)
#this is saying to svave it over the top of the same column
#check the environment - it has changed to being listed as a factor

#now we can re-run the plot
ggplot(data = surveys_complete, mapping =aes(x = species_id, y = hindfoot_length))+
  geom_jitter(alpha = 0.3, aes(colour = plot_id)) +
  geom_boxplot(alpha = 0)
#and we get a plot with different colouts for each plot_id


#we could just change it to a factor 'on the fly' in the plot, rather than permamantly in the data set
ggplot(data = surveys_complete, mapping =aes(x = species_id, y = hindfoot_length))+
  geom_jitter(alpha = 0.3, aes(colour = as.factor(plot_id))) +
  geom_boxplot(alpha = 0)



#Challenge 7
#In many types of data, it is important to consider the scale of the observations. 
#For example, it may be worth changing the scale of the axis to better distribute the observations in the space of the plot. 
#Changing the scale of the axes is done similarly to adding/modifying other components 
#(i.e., by incrementally adding commands). 
#Make a scatter plot of species_id on the x-axis and weight on the y-axis with a log10 scale.

ggplot(data = surveys_complete, mapping =aes(x = species_id, y = weight))+
  geom_point()+
  scale_y_log10()
#you can see here that the 7 axis increases exponentiallu now 
#which makes it easier to see all the data points where there's small weights

#of course - you can make it clearer with a jitter and prettier :)
ggplot(data = surveys_complete, mapping =aes(x = species_id, y = weight))+
  geom_jitter(alpha = 0.3, colour = surveys_complete$plot_id)+
  scale_y_log10()



#PLOTTING TIME SERIES DATA

#lets look at how many data points there are per year, for each genus

yearly_counts <- surveys_complete %>% 
  count(year, genus)

#lets check it's there
yearly_counts

ggplot(data = yearly_counts, mapping = aes(x = year, y = n))+
  geom_line()

#this way of doing a line graph doesn't look good because it's jumping betwwen each year and there's no data in between them
#also we havent' asked it to split up by genus yet

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group=genus))+
  geom_line()
#this adds a line on the line graph for each genus
#ie it has added a third dimension to the plot
#now lets try colouring it by genus

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group=genus, colour = genus))+
  geom_line()
