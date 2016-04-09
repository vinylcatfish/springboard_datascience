setwd("~/projects/github/springboard_datascience/")

# Clear the buffer
rm(list=ls())

# 0 Load the data
df <- read.csv("titanic_original.csv")

# 1 - Replace missing value with S
df$embarked <- as.character(df$embarked)
df$embarked[df$embarked == "NA"] <- "S"

# 2 - Calculate the mean of the Age column and use that value to populate the missing values
df$age[is.na(df$age) == TRUE] <- mean(df$age[is.na(df$age) == FALSE]) 

# 3 - Fill these empty slots with a dummy value e.g. NA in boat column
df$boat <- as.character(df$boat)
df$boat[df$boat == ""] <- "NA"

#4 - Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
df$has_cabin_number[df$cabin != ""] <- 1
df$has_cabin_number[df$cabin == ""] <- 0

#5 - There was not a #5 :)

#6 - Save as titanic_clean.csv - without quotes, without row numbers
write.table(df, file = "titanic_clean.csv",quote=FALSE,sep=",",row.names=FALSE, col.names=TRUE)

