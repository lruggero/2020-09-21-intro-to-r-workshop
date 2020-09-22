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


# first row (as a data frame)
surveys[1,]

# first three elements in the 7th column (as a vector)


# the 3rd row of the data frame (as a data.frame)


# equivalent to head(metadata)


# looking at the 1:6 more closely


# we also use other objects to specify the range



#
# Challenge: Using slicing, see if you can produce the same result as:
#
#   tail(surveys)
#
# i.e., print just last 6 rows of the surveys dataframe
#
# Solution:



# We can omit (leave out) columns using '-'



# column "names" can be used in place of the column numbers



#
# Topic: Factors (for categorical data)
#


# factors have an order


# Converting factors


# can be tricky if the levels are numbers


# so does our survey data have any factors


#
# Topic:  Dealing with Dates
#

# R has a whole library for dealing with dates ...



# R can concatenated things together using paste()


# 'sep' indicates the character to use to separate each component


# paste() also works for entire columns


# let's save the dates in a new column of our dataframe surveys$date 


# and ask summary() to summarise 


# but what about the "Warning: 129 failed to parse"


