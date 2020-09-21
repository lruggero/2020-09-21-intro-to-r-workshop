#    ___       _               _          ____  
#   |_ _|_ __ | |_ _ __ ___   | |_ ___   |  _ \ 
#    | || '_ \| __| '__/ _ \  | __/ _ \  | |_) |
#    | || | | | |_| | | (_) | | || (_) | |  _ < 
#   |___|_| |_|\__|_|  \___/   \__\___/  |_| \_\
# 
# Derived from: https://datacarpentry.org/R-genomics/

#
# Topic: Basic Calculations and using Objects
# Presented by: Belinda Fabian

# R can do sums ...
3 + 5
12 / 7

# Command+Enter = run the command (without clicking the button)

# other operators in built in the system)
#
# - * / ** ^ ( )

# 
# Excercises
#

# What does: 11 + 1 / 6  evaluate to ?

# Solution:
11+(1/6)

# Calculate 10 plus 2 all divided by 3 and then squared

# Solution:
((10+2)/3)^2


# <- alt + minus sign is the shortcut to get this store function below

# Storing values
a <- 3              # assign the number 3 to OBJECT (variable) called "a"
b <- 5              # assign 5 to b

a                   # so what's the value of OBJECT "a"
b                   # ... and what's b

a + b               # we can add them together just like numbers

a <- 8

a+b


# --------
# Exercise
# --------
#
# What happens if we change a and then re-add a and b? [Hint: Try it now]
#
# Does it work if you just change a in the script and then add a and b? [Hint: Try it]
#
# Did you still get the same answer after you changed a? 
# If so, why do you think that might be?
#
# We can also assign the result of a + b to a new variable, c. 
# How would you do this?
#
# Solution:

# (a+b) <- c (I tried this and it didn't work)
# 12 <- c  (I tried this and it didn't work)
#because the one you're assigning a variable TO needs to be on the left

c <- a + b

# Logical operators
#
# == != < > >= <= !
1 < 124
1 == 4

#
# Sensible object names are sensible ...
# EG "Z" is not a helpful name for naming a variable
date_of_birth <- 7
z <- 19.5
THEMOL <- 42
camelCaseIsGenerallyNotRecommended <- "Unless you follow Google's Style guide"
# This is a stylistic thing - up to you
names_that_are_unreasonably_long_are_not_a_good_idea <- "correct"
# putting things into inverted commas makes it a "text string"
# longer variable names will get cut off in the system

nouns_are_good <- TRUE
TRUE <- 17


# this objects (code doesnt run, becasue you can't assign a value to a logical operator)

ekljre2jklwef023ijlefj93jkl23rj90f32k <- 1

# 
# Exercise
# 
#
# Assign the name of this workshop to a object with a good name.
#
# Solution: [Hint:       <- "Introduction to R"]
Intro_R <- "Introduction to R"

# Assign the name of video conferencing tool we are using to an object
#
# Solution: [Hint:      <- "Zoom"]
Workshop_Platform <- "Zoom"

# Which of these are valid object names: [Hint: Try them out]
#
min_height 
max.height
_age #doesn't like this one (can't start with an underscore?)
.mass
MaxLength
min-length 
2widths #doesn't like this one (can't start with a number)
celsius2kelvin

#
# Topic: Displaying results
#

weight_lb <- 55    # doesn't print anything
(weight_lb <- 55)  # but putting parenthesis () around an expression makes it assign and also display
weight_lb          # and just typing the name of the object will also display it

# There are 2 and a bit pounds in a kilogram 
2.20462 * weight_lb

weight_lb <- 57.5
2.20462 * weight_lb

weight_kg <- 2.20462 * weight_lb
weight_kg

# 
# 
# What are the values after each statement in the following?
# 
# mass <- 47.5            # mass is: 47.5
# age  <- 122             # age is: 122
# mass <- mass * 2.0      # mass is: 95
# age  <- age - 20        # age is: 102
# mass_index <- mass/age  # mass_index is:  0.9313725
#
# How do we do we know if our answers are correct ? 
# [Hint: <highlight> [ALT][ENTER] (just run "mass" or "age" again to check what the currently stored value is)

#
# Topic: Comments
#

# Comments (like this one) are usually helpful

     # they can also be indented (and on the same line as a code)

# They should be supportive (not redundant e.g. "this is a comment")

# 
# Exercise
# 
#
# Add explanatory comments to the following lines of code

ft <- 3           # assigning that length in feet = 3
in <- ft * 12     # conversion from feet to inches
cms <- in * 2.54  # 2.54 isthe conversion factor between inches and centimetres
m = cms / 100     # assigning that metres is cms divided by 100

#
# Topic: Functions and Arguments
#
sqrt(2) #sqrt is the name of the function, 2 is the 'argument'
a <- 64
sqrt(a) # can't run this of course until you assign a number to a
abs(-23.3) #absolue value
round(3.14159)
pi

# Getting help about particular functions 
?round #will tell you about the round funciton
args(round) # will tell you about the arguments required to run this funciton

round(3.14159, digits = 2)
round(digits = 2, x = 3.14159)
# you can't just flip the order around, unless you tell it which one is which with labels

#
# Exercise
#
# what does the function called log10() do ?  Can you test it ?
#
# Answer:

?log10
args(log10)
log10(2)
log10(456)


#
# Topic: Vectors and Data Types
# Presented by: Richard Miller

# Combine some values in a vector
glengths <- c(4.6, 3000, 50000)
glengths

species <- c("ecoli", "human", "corn")
species

length(glengths)
length(species)

5 * glengths

double_lengths <- glengths + glengths
double_lengths

class(glengths)
class(species)

str(glengths)
str(species)

lengths <- c(glengths, 90)        # adding at the end  Combine the existing lengths with 90 (it adds an extra number in the sequence)
lengths <- c(30, glengths)        # adding at the start
lengths

# note all the elements have to be the same type
length_species <- c(4.5, "ecoli") # lets see what happens if we try to combine  a number and a word in one vector
length_species

# this doesn't work - R automatically converts the number 4.5 into a "textual representation". So it's not longer the number 4.5, it's a text entry.

# This automatic conversion is called 'coercion' or 'casting' ..

# and there are other types (of vectors) as well ...
#first lets create some objects
sqrt_of_minus_one <- 1i
true_or_false_value <- TRUE
decimal_number = 54.0  # Most of the tie you can use the  = sign but occassionally it doesn't work and you need to use the proper assignment sign
whole_number = -54L

# now run the vectors

class(sqrt_of_minus_one)
class(true_or_false_value)
class(whole_number)
class(decimal_number)

# --------
# Exercise
# --------
#
# We’ve seen that vectors can be of type character, 
# numeric (or double), integer, and logical. 
#
# But what happens if we try to mix these types in a single vector?
#
# eg:
#
#   thing <- c("some characters", 3.141, 100, TRUE)
thing <- c("some characters", 3.141, 100, TRUE)
#   thing - this tells us that's its converted all of these into character strings because everything is now in inverted commas
#   class(thing) - running this tells us that it has made it a character string - if you were unsure what type of string it was
#
# What will happen in each of these examples?
#
#   num_char <- c(1, 2, 3, "a")
num_char <- c(1, 2, 3, "a")
num_char # when I run this then it tells me that it's made them all characters
class(num_char) # confirms that it's converted to character string

#Ctrl SHift C - it gets rid of the comment symbol

#   num_logical <- c(1, 2, 3, TRUE)

#   char_logical <- c("a", "b", "c", TRUE)

#   tricky <- c(1, 2, 3, "4")
tricky <- c(1, 2, 3, "4")
tricky 

#
# [Hint: use class() to check the data type of your objects]
#
# Can you explain why you think it happens?

# --------
# Exercise
# --------
# How many values in combined_logical are "TRUE" (ie character 4 characters)
# in the following example:
#   
#   num_logical <- c(1, 2, 3, TRUE)
#   char_logical <- c("a", "b", "c", TRUE)
#   combined_logical <- c(num_logical, char_logical)


#
# Topic: Subsetting vectors
# Presented by: Evan Matthews

animals <- c("mouse", "rat", "dog", "cat")
animals
animals[2] # says just tell me the second one in the vector - must use sq brackets
animals[c(3, 2)] # says just tell me the third then the second one in the vector 

more_animals <- animals[c(1, 2, 3, 2, 1, 4)]
more_animals

# Conditional subsetting
weight_g <- c(21,   34,    39,   54,   55)
weight_g[   c(TRUE, FALSE, TRUE, TRUE, FALSE)] # instead of giving it numbers, I can tell it whether I want each of those elements or not

weight_g > 50 #I'm asking is weight greater thatn 50 for al the values in the vector? (it will tell me [1] FALSE FALSE FALSE  TRUE  TRUE)
weight_g[weight_g > 50]

weight_g[weight_g < 30 | weight_g > 50] # vertical bar = "OR" function # show me all the values that are less than 30 OR more than 50

weight_g[weight_g >= 30 & weight_g == 21] # show me al the vvalued which are less than or equal to 30 AND equal to 21



animals <- c("mouse", "rat", "dog", "cat")
animals[animals == "cat" | animals == "rat"] # returns both rat and cat

animals %in% c("rat", "cat", "dog", "duck", "goat") #Check if the thing I'm interested in (animals) is in this current set?
animals[animals %in% c("rat", "cat", "dog", "duck", "goat")] #in this animal array, give me all ones that are in this subset


# Challenge
#
# Can you explain  why 
#
#  "four" > "five" 
#
# returns TRUE?
#
# Answer:
# because they are character strings "chars" - the comparison operator > < etc means alphabetically and fo does come after fi alphabetically

"z" > "a"
"z" > "A" # in other languages the case can cause different answers. But R will evaluate regardless of case




# Topic: Missing data (NA - Not Available)

heights <- c(2, 4, 4, NA, 6) #denote missing data with NA - R doesn't care at this point
#but if you try to run functions with a NA, it can cause problems

mean(heights) # will return "NA" - this is the conservative answer because you can't average thigns when the NA could be anything!
max(heights)
mean(heights, na.rm = TRUE) #add an extra argument to say that you want to means, but "remove the NA values"
max(heights, na.rm = TRUE)

is.na(heights) # show me - is there an NA in here? ("is.na" checks the argument for NAs) - FALSE FALSE FALSE  TRUE FALSE
!is.na(heights) # show me which ones are values in here (no NAs) - TRUE  TRUE  TRUE FALSE  TRUE
#these True values now correspond to which values you want to keep

heights[!is.na(heights)] # use that thing we just figured out to select out the interger values only - give me all the values in the heights vector which are not NAs - 2 4 4 6

na.omit(heights) # loost the plot on what this was
heights[complete.cases(heights)]
heights

#
# Exercise (extended)
#
#
# Using this vector of heights in inches, create a new vector 
# with the NAs removed.
# 
#   heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
!is.na(heights) # show me which ones are values in here (no NAs) 
na.omit(heights)

#returned this: 63 69 60 65 68 61 70 61 59 64 69 63 63 72 65 64 70 63 65

#
# Solution

# Use the function median() to calculate the median of the heights vector.
#
# Solution

median(na.omit(heights))
#OR
median(heights,na.rm = TRUE)
# we have to omit the NAs to calculate this, then it will run the medians


# Use R to figure out how many people in the set are taller than 67 inches.
#
# [Hint: R has a builtin function called length() that tells you 
# how many values are in a vector
