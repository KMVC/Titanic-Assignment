#load libraries/packages
#library(tidyverse)

#step 0: load data
titanic <- read.csv("titanic_original.csv", na = c("","NA", "NDA"))

#Step 1: Fill blank values in Port of Embarkation with "S"

titanic$embarked[is.na(titanic$embarked)] <-"S"

#Step 2: Use the mean to populate missing values in Age column

#calculate mean age
mean(titanic$age, na.rm = TRUE)

# populate missing age values with mean age
titanic$age <- ifelse(is.na(titanic$age), mean(titanic$age, na.rm = TRUE), titanic$age)

#Question: what other ways could missing age values be filled? why choose mean (or not)?

#Another way of populating the "age" column besides using the mean age, might be to use the 
#median age, as it is also a "middle" value and would ensure that any outlier ages would not inordinately
#impact the data set. However, as we have no way of knowing the passengers' exact ages,
#taking into account the whole spectrum of values, including the extremes when filling in the missing values, 
#might not be warranted. 

#However, there might be ways to populate the missing values, other than simply using the mean of all the values
#in the age column.

#In examining the data set, one can see in the column "name" that titles are given. It could be assumed that
#anyone with the title of "Master" is a minor (under 18), and it is quite likely that anyone with the title "Mrs"
#is an adult. One could also think about dividing the passengers by gender, taking the average age of females 
#and males, and using those to fill in the missing values, as the age range of males would likely be larger, considering 
#social norms in this era.

#One could also attempt to be more specific by calculating the mean/median age of passengers 
#by ports of embarkment(assuming that local cultures and norms might mean that similar "types" of people 
# from a particular place would be interested and able to take such a cruise) - although this is conjecture. 
#In short, it might be worthwhile to work with subsets when filling in the missing age values.

#Step 3: Fill in empty values in Lifeboat column with NA or None
#add None level

levels(titanic$boat) <- c(levels(titanic$boat), "None")

#change NA to None for Titanic$boat
titanic$boat[is.na(titanic$boat)] <- "None"



#Step 4: Cabin

#4a Does it make sense to fill missing cabin numbers with a value?

#It does not make sense to fill missing values in the cabin column with values, 
# as cabin numbers are categorical variables(the cabin number does not actually have a numerical value
# - the cabins could have just as likely been given names)that one would be assigned by the cruise ship company - 
#calculating the mean or mode would in no way provide an accurate picture of possible cabin values,especially
#because each cabin would have a unique name/number.

# 4b What does a missing value here mean?
#It is possible that a missing value in this column might mean that a passenger did not survive and therefore,
#could not provide this information. As well, there is the possibility that poorer workers on the ship might
#not have been assigned a cabin. 

#4c Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise. 

#use mutate to create new column
titanic <- titanic %>% mutate("has_cabin_number" = ifelse(is.na(`cabin`) == TRUE, 0,1))


#Save as titanic_clean.csv
write.csv(titanic, file = "titanic_clean.csv")


