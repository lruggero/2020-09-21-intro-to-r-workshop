#####################
# MANIPULATING DATA #
#       using       #
#     TIDYVERSE     #
#####################
#
#
# Based on: https://datacarpentry.org/R-ecology-lesson/03-dplyr.html

# Data is available from the following link (we should already have it)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

#---------------------
# Learning Objectives
#---------------------

#    Describe the purpose of the dplyr and tidyr packages.
#    Select certain columns in a data frame with the dplyr function select.
#    Select certain rows in a data frame according to filtering conditions with the dplyr function filter .
#    Link the output of one dplyr function to the input of another function with the ‘pipe’ operator %>%.
#    Add new columns to a data frame that are functions of existing columns with mutate.
#    Use the split-apply-combine concept for data analysis.
#    Use summarize, group_by, and count to split a data frame into groups of observations, apply summary statistics for each group, and then combine the results.
#    Describe the concept of a wide and a long table format and for which purpose those formats are useful.
#    Describe what key-value pairs are.
#    Reshape a data frame from long to wide format and back with the pivit_wider and pivit_longer commands from the tidyr package.
#    Export a data frame to a .csv file.
#----------------------

#------------------
# Lets get started!
#------------------

install.packages("tidyverse")
library(tidyverse)

# Whare the conflicts that come up? You need to make sure some packages are installed in different orders, or they wil cancel each other out
# (not relevant for today)
#dplyer - to manipulate data
# tidyr - helps witha  common problem of wanting to reshape data for plotting

#now load the data set
surveys <- read_csv("data_raw/portal_data_joined.csv")


#check structure
str(surveys)
#yep, looks like the right data set
# it tells us: Classes ‘spec_tbl_df’, ‘tbl_df’, ‘tbl’ and 'data.frame'  -- take note of this for later


#-----------------------------------
# Selecting columns & filtering rows
#-----------------------------------


#lets say we only want to see some of the columns
select(surveys, plot_id, species_id, weight)

#lets say we don't want to see some of the columns
select(surveys, -record_id, -species_id)
#you cna also use "-1" to remove say column number one.

#lets say we want to filter for a particular year
filter(surveys, year == 1995)
#lets say you wanted to keep this for later
surveys1995 <- filter(surveys, year == 1995)
#this stores it and puts it in the environment

surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)
#this has made a second dataset which is a subset ofte data which only includes observatons where weig is lessthan 5

#this is another way of running that without 2 individual lines of code:
surveys_sml <- select(filter(surveys, weight < 5), species_id, sex, weight)


#-------
# Pipes
#-------

#a pipe is %>% 
#shortcut for that is Ctrl+Shft+M
#lets use the pipe to combine them together

surveys %>% 
  filter(weight<5) %>% 
  select(species_id, sex, weight)  
#you don't need to surround every one of these statements with surveys because it's all 'under' surveys in this pipe way of doing it

# you can then assign that whole tset of instructions to a new object:

surveys_sml <- surveys %>% 
  filter(weight<5) %>% 
  select(species_id, sex, weight) 


#now we have created an object called surveys_sml which is a subsert of the original data - with only observations
#where weight is less than 5, and only has obseervations for 3 specific columns


#remember - you can't filter on a column that doesn't exist in the new dataframe - so you need to filter on weight before you create a dataset that doesn't have the weight column in it!





#-----------
# CHALLENGE
#-----------

# Using pipes, subset the ```surveys``` data to include animals collected before 1995 and 
# retain only the columns ```year```, ```sex```, and ```weight```.

surveys %>% 
  filter(year<1995) %>% 
  select(year, sex, weight)  

#AND, to store it and give it a name, you can assign the whole thing:
survey_pre1995 <- surveys %>% 
  filter(year<1995) %>% 
  select(year, sex, weight)  


#--------
# Mutate
#--------

#we can create a new column / multiples by 'mutating'

surveys %>% 
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2)

#assign it:

surveys_weights <- surveys %>% 
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2)

#to check if it's worked: we can pipe it into a head just to look at the first few rows

surveys %>% 
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>% 
  head()


#to filter out the NAs:

surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight / 1000) %>% 
  head
#you can see in the head first few rows that it's re-run without any of the rows that have an NA in the weight column



#-----------
# CHALLENGE
#-----------

# Create a new data frame from the ```surveys``` data that meets the following criteria: 
# contains only the ```species_id``` column and a new column called ```hindfoot_cm``` containing 
# the ```hindfoot_length``` values converted to centimeters. In this hindfoot_cm column, 
# there are no ```NA```s and all values are less than 3.

# Hint: think about how the commands should be ordered to produce this data frame!

surveys_HFcms <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_cms = hindfoot_length / 10) %>% 
    filter(hindfoot_cms<3) %>% 
    select(species_id, hindfoot_cms) %>% 
  head



#---------------------
# Split-apply-combine
#---------------------

#Eg if you have data from 4 different hospitals, you can combine them, or get the averages for each one individually with one piece of code

surveys %>% 
  group_by(sex) %>% 
  summarise(mean_weight = mean(weight))

#too many NAs coming up

surveys %>% 
  group_by(sex) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE))

#This has given us average weights for female, male and NAs 

summarise(surveys) #this is a tidyverse function and doens't work on the whole dataset as the columns are all different types of variables (numbers, categorical, etc)
summary(surveys) #this works and is a BASE funciton

?summarize
#this tells you there are different versions - select which one you mean (from which package)


surveys %>% 
  dplyr::group_by(sex)  #we need to specify which "group by" we want to use - make sure you tell it explicitly which package you're running it through

#sex = "col character" it's interpreting it as characters but actually we want it to be factors (categorical variable)
#lets do that
surveys$sex <- as.factor(surveys$sex)
#and check it
str(surveys$sex)


surveys %>% 
  dplyr::group_by(sex)  %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE))

#now we've run it as a factor, it shows us the summary in alphabetical order

surveys %>% 
  summary


#what if we want to filter EG filter out the NAs in the weights and sex columns while we ask it to summarise other columns and group together?

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>%  
  summarise(mean_weight = mean(weight))

# this tells it, show me the average weight for each of these cells
#( female ape, female zebra, female giraffe, male ape, male zebra, male giraffe, etc). 
#It won't collapse any further because you've asked it to group by two differnet variables - 
#so IE if it collapsed all the sex together it ould inadvertently also pile differnet species into one cell


#to see more rows:
surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>%  
  summarise(mean_weight = mean(weight)) %>% 
  print (n=40)

#some times you might want to arrange them in a different order eg by min to max weight:

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>%  
  summarise(mean_weight = mean(weight),
            min_weight = min(weight)) %>% 
  arrange(min_weight) %>% 
  print(n=30)
#i want you to arrange by the minimum weight for each 'cell' (object min-weight that we just created)
  
surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>%  
  summarise(mean_weight = mean(weight),
            min_weight = min(weight)) %>% 
  arrange(mean_weight) %>% 
  print(n=30)
#i want you to arrange by the average weight for each 'cell'

#count function
surveys %>% 
    count(sex)
#1 F     15690
#2 M     17348
#3 NA     1748


#we can get the same result by also coding like this:
surveys %>% 
  group_by(sex) %>% 
  summarise(count = n())

#we can get it to group by multiple variables
surveys %>% 
  group_by(sex, species, taxa) %>% 
  summarise(count = n())

#-----------
# CHALLENGE
#-----------

# 1. How many animals were caught in each ```plot_type``` surveyed?

surveys %>% 
  group_by(plot_type) %>% 
  summarise(count = n())

#OR

surveys %>% 
  count(plot_type)

#  plot_type                 count
# <chr>                     <int>
# 1 Control                   15611
# 2 Long-term Krat Exclosure   5118
# 3 Rodent Exclosure           4233
# 4 Short-term Krat Exclosure  5906
# 5 Spectab exclosure          3918



# 2. Use ```group_by()``` and ```summarize()``` to find the mean, min, and max hindfoot length 
#    for each species (using ```species_id```). Also add the number of observations 
#    (hint: see ```?n```).

surveys %>% 
  group_by(species_id) %>% 
  filter(!is.na(hindfoot_length)) %>% 
  summarise(mean(hindfoot_length), min(hindfoot_length), max(hindfoot_length), count = n())

#species_id `mean(hindfoot_length)` `min(hindfoot_length)` `max(hindfoot_length)`
#<chr>                        <dbl>                  <dbl>                  <dbl>
# 1 AH                            33                       31                     35
# 2 BA                            13                        6                     16
# 3 DM                            36.0                     16                     50
# 4 DO                            35.6                     26                     64
# 5 DS                            49.9                     39                     58
# 6 NL                            32.3                     21                     70
# 7 OL                            20.5                     12                     39
# 8 OT                            20.3                     13                     50
# 9 OX                            19.1                     13                     21
# 10 PB                            26.1                      2                     47




# 3. What was the heaviest animal measured in each year? 
#    Return the columns ```year```, ```genus```, ```species_id```, and ```weight```.


surveys %>% 
  group_by(year, genus, species_id, weight) %>% 
  summarise(count = n())


heaviest_year <- surveys %>% 
  group_by(year) %>% 
  select(year, genus, species_id, weight) %>%
  mutate(max_weight = max(weight, na.rm = TRUE)) %>% 
  ungroup()

heaviest_year


#-----------
# Reshaping
#-----------







#-----------
# CHALLENGE
#-----------

# 1. Spread the surveys data frame with year as columns, plot_id as rows, 
#    and the number of genera per plot as the values. You will need to summarize before reshaping, 
#    and use the function n_distinct() to get the number of unique genera within a particular chunk of data. 
#    It’s a powerful function! See ?n_distinct for more.

# 2. Now take that data frame and pivot_longer() it again, so each row is a unique plot_id by year combination.

# 3. The surveys data set has two measurement columns: hindfoot_length and weight. 
#    This makes it difficult to do things like look at the relationship between mean values of each 
#    measurement per year in different plot types. Let’s walk through a common solution for this type of problem. 
#    First, use pivot_longer() to create a dataset where we have a key column called measurement and a value column that 
#    takes on the value of either hindfoot_length or weight. 
#    Hint: You’ll need to specify which columns are being pivoted.

# 4. With this new data set, calculate the average of each measurement in each year for each different plot_type. 
#    Then pivot_wider() them into a data set with a column for hindfoot_length and weight. 
#    Hint: You only need to specify the key and value columns for pivot_wider().





#----------------
# Exporting data
#----------------












