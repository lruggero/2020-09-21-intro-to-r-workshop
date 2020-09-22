#   _____ _             _   _                        _ _   _       _____        _        
#  / ____| |           | | (_)                      (_| | | |     |  __ \      | |       
# | (___ | |_ __ _ _ __| |_ _ _ __   __ _  __      ___| |_| |__   | |  | | __ _| |_ __ _ 
#  \___ \| __/ _` | '__| __| | '_ \ / _` | \ \ /\ / | | __| '_ \  | |  | |/ _` | __/ _` |
#  ____) | || (_| | |  | |_| | | | | (_| |  \ V  V /| | |_| | | | | |__| | (_| | || (_| |
# |_____/ \__\__,_|_|   \__|_|_| |_|\__, |   \_/\_/ |_|\__|_| |_| |_____/ \__,_|\__\__,_|
#                                    __/ |                                               
#                                   |___/                                                
#
# Based on: https://datacarpentry.org/R-ecology-lesson/02-starting-with-data.html



# Lets download some data (make sure the data folder exists)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv") # this tells R to make a copy of this CSV, call it "portal data" and put it in the folder "data raw"

# you can also manually insert a file through "files" in the right hand lower corner then uploading it
# if you're using R locally on your computer - there's no need to upload because R can just read the files straight off your drive
# in cloud versions you definitely need to import the file


# now we will read this "csv" into an R object called "surveys"
surveys <- read.csv("data_raw/portal_data_joined.csv") # this assigns the csv to a new object in R called "Surveys"

#once done it will appear in the environment

# and take a look at it
surveys
# in the console pane it will show you the first ~75 rows but then stop, and not bother to show you all 30 000 rows

head(surveys)
#this just gives a preview of the head of the data (beginning)

tail(surveys)
#this will show you the last 6 rows

#you can change the number you want to see by adding an argument
tail(surveys, 2)

View(surveys)
#this will show you a more traditional spreadsheet view in a new tab

names(surveys)
#this will show you the first row of the columns / variables IE what are your variables/columns called?
row.names(surveys)
#this will sho you the row names (if you have them assigned)

summary(surveys)
#gives a general summary of your data, by column/variable names (mean, median, quartilces, min, max, no per category of category variables)


# BTW, we assumed our data was comma separated, however this might not
# always be the case. So we may need to tell read.csv more about our file.



# So what kind of an R object is "surveys" ?
# it's not a vector becasue it's got multiple rows and columns, of different types
# R specifically has an object for coping with spreadsheet type data: "dataframe"
class(surveys)
# [1] "data.frame"

# ok - so what are dataframes ?
?data.frame
str(surveys) #this asks for the structure - IE meta info about the spreadsheet (this variable is an integer, this is a 'factor' or categorial variable)
dim(surveys) #this gives us dimanesions (rows and columns)
nrow(surveys)
ncol(surveys)

# --------
# Exercise
# --------
#
# What is the class of the object surveys?
    #class(surveys) = data.frame
# Answer:


# How many rows and how many columns are in this survey ?
    # dim function for dimensions
    # nrow for rows (rows and observations used interchangeably in R functions)
    # ncol for columns (columns and variables used interchangeably in R functions)
# Answer: 34786 and 13

# What's the average weight of survey animals
mean(surveys$weight, na.rm=TRUE)
# 1 go and figure out what the column is called
# use the mean function, specify what project, what column and tell it to remove the NA values
# but you could also use te sumamry function to find this
# Answer: 42.67243



# Are there more Birds than Rodents ?
# could use the summary function to have a look at the means for everything
#
# Answer: No
# could also use code to find out these two numbers
sum(surveys$taxa == 'Rodent')
sum(surveys$taxa == 'Bird')



# 
# Topic: Sub-setting
# need to use square brackets to select a subset of data

# first element in the first column of the data frame (as a vector)
surveys[1,1] # this says tell me row 1, column 1

# first element in the 6th column (as a vector)
surveys[1,6] # it will give you row 1, column 6, the actual value then it also tells you waht all the possible categorical values are

# sixth column of the data frame (as a vector)
surveys[,6] #you just leave out the row number to tell it to give you the whole column (in this case it will cut out because it's too large to bother)
surveys[,2]

# first column of the data frame (as a data frame)
surveys[1] #with no comma, it requests a single column dataframe (spreadsheet)
head(surveys[1]) # this says show me the first 6 entries in column one
head(surveys[,1]) # this says give it to me again but as a vector
head(surveys[1,]) # this says show me the first 6 entries in row one, as a vectpr


# first row (as a data frame)
surveys[1,]

# first three elements in the 7th column (as a vector)
surveys[1:3,7]
#this gives me 2 Ms - there are two males and an NA so this is correct




# the 3rd row of the data frame (as a data.frame)
surveys[3,]


# equivalent to head(surveys)
head(surveys)
# the manual way of doing this:
surveys[1:6,] #give me rows 1-6 and no specifying any particular (therefore all) columns


# looking at the 1:6 more closely
# this is a shorthand for a range (IE 1:6 in R = 1-6)
#what it actually does is give you a sequence within tha range
1:6
1:12  # =  1  2  3  4  5  6  7  8  9 10 11 12
567:569 # = 567 568 569

surveys[ c(2,4,6),]
# this gives you (a combination of ) rows 2,4 and 6 of the data

surveys[1:6,3]
# this gives me

#COPIED FROM SCRATCHAD:
  # looking at the 1:6 more closely
  1:6 # this represents the sequence of numbers between 1 to 6 (inclusive) 
5:10 # sequence of numbers 5 to 10 (inclusive)
surveys[ c(1,2,3,4, 5,6), ] # returns rows 1 to 6 inclusive
surveys[ c(2, 4, 6), ] # returns rows 2, 4 and 6

# we also use other objects to specify the range
rows <- 6
surveys[1:6, 3]
surveys[1:rows, 3] # returns same as above line as expected



#
# Challenge: Using slicing, see if you can produce the same result as:
#
#   tail(surveys)
#
# i.e., print just last 6 rows of the surveys dataframe
#
#######################
Had a lot of trouble udnerstanding this section
# Solution:
surveys[34781:34786, ]
#this has chosen them manually
#more elegant way of doing it?
nrow(surveys) #this tells us how may rows there are in the wholw dataset
surveys[(nrow(surveys)-6):nrow(surveys), ]
#you can use code to manipulate where it runs the code to and from

?nrow #tells us the number of rows



# We can omit (leave out) columns using '-'
surveys[-1] #this means run it without column 1
head(surveys[-1:-3]) #this means run it without columns 1-3
head(surveys[-3:-5]) #this means run it without columns 3-5
head(surveys[-(3:5)]) #this means run it without columns 3-5 BUT APPLIES THE MINUS FORM THE OUTSIDE SO YOU DON'T NEED TO TYPE IT MULTIPLE TIMES
head(surveys[c(-3,-5,-8)]) #this means run it without columns 3, 5 and 8



  # column "names" can be used in place of the column numbers
#especially since your column numbers might change if you move thigns around
head(surveys["species"]) #this means run only the column named species
head(surveys["month"])


#
# Topic: Factors (for categorical data)
#
gender <- factor(c("male", "male", "female"))
# we've just reprogrammed gender to be a factor with 2 "levels" or options
gender
class(gender) #if we check - it is stroed as a factor
levels(gender) #we can check what the levels are
nlevels(gender) # we can check the no of levels


# factors have an order
# like responses on a likert scale
# in some cases it doesn't make sense to say eg lvPPA is greater than svPPA
temperature <- factor(c("hot", "cold", "hot", "warm"))
temperature
temperature[1] # it will tell you what the levels of the variables are but they are alphabetical
levels(temperature)
#to reorder them based on how we want to order them we need to tell it
temperature <- factor(c("hot", "cold", "hot", "warm"), levels = c("cold", "warm", "hot"))

levels(temperature)
#now we can see that it has stored them in the order we've asked it to

# Converting factors
as.numeric(temperature)
as.character(temperature)


# can be tricky if the levels are numbers
# ie if you have the years 1980, 1993, 1998, 2015
#if you make this a factor (ie a categorical variable) you can't do calculations with it
year <- factor(c(1990, 1983, 1977, 1998, 1990))
year

as.numeric(year)  # so first you need to change it to a number, then character, then number again to be able to do maths with the years ie 'how many years apart were they?'
as.character(year) #what's this bit?
as.numeric(as.character(year))




# so does our survey data have any factors
#we can tell by looking at the structure
str(surveys)
#yes, there are plenty of factors (categ vars): genus, species, sex


#R will automatcally import things that look like factors as factors - sometimes you will need to go in and fix these
#there is also an option to supress this conversion when you import a csv
#search 'strings become factors'




#
# Topic:  Dealing with Dates
#

# R has a whole library for dealing with dates ...
library(lubridate) #tells my R studio I want the functionality that will come from running this package
#date: 7-16-1977 (into this format)

my_date <- ymd("2015-01-01")
my_date
class(my_date) #it has learnt this as a date!


# R can concatenated things together using paste()
#which is good because our dates are entered into days, months and years at the moment

paste("abc", "123")   #gives back:  "abc 123" - with a seperator in between to show you there are discrete things
paste("abc", "123", sep = "+")  # but you can replace the seperator of a space with something else
paste("2015", "01", "26", sep = "-") # returns  "2015-01-26"
ymd(paste("2015", "01", "26", sep = "-")) # this LOOKS identical, but it's no longer a character string but a date format
class(my_date)


# paste() also works for entire columns
surveys$year  # this is another way of selecting a column (with the $ sign)
paste(surveys$year, surveys$month, surveys$day, sep = "-") #this combines the columns to make dates, but they are still characters at this point

ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-")) # this has converted it to dates, but it's very long!

# let's save the dates in a new column of our dataframe surveys$date
#we can save it into the dataframe in a new column - bc the column you label here doesn't exist, it creastes it
surveys$date <- ymd(paste(surveys$year, 
                          surveys$month, 
                          surveys$day, sep = "-"))

# now you can perform operations with the dates eg subtract them etc
 



# and ask summary() to summarise 
summary(surveys)  # now you can see in the summary that it summarises the new column as well



# but what about the "Warning: 129 failed to parse"
summary(surveys$date)  #lets look
# it tells are there are 129 NAs
# we need to go looking for them to see what needs to be fixed

is.na(surveys$date)  #if we printes all the cells we would find eht odd "TRUE" although we can't see at first glance when we do this and get a preview
#lets convert is to a variable to find them
missing_date <- surveys[is.na(surveys$date), "date"]
missing_date  #now it's just showing me the NAs and not 'reading' the other cells that have dates in them
missing_date <- surveys[is.na(surveys$date), c("year", "month", "day", "record_id")] 
#lets reprogram missing_date so we can see what is in those origianl cells, that it won't convert to a date
#adding the record no means you can see where it's coming from in the spreadsheet
#now it's  showing me the NAs and what is in their correspondin D, M Y cells
missing_date
#now you can see what they all have in common - they are all impossible dates, which don't have a "31st" (eg APril)
#then you would have to decide how to handle the data - you could use R to change all those 31sts to 30ths.




