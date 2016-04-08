library(dplyr)
library(tidyr)

setwd("~/projects/github/springboard_datascience/")

# Clear the buffer
rm(list=ls())

# 0 - load data into R
refineData <- read.csv("refine_original.csv")

# 1 - clean up the brand names
# convert first column to lowercase
refineDataLC <- data.frame(apply(refineData[1],2,tolower),refineData[,-1])
# transform the values in the column to be: philips, akzo, van houten and unilever (all lowercase).
refineDataLC$company[grep('^.*il.*ips.*?',refineDataLC$company)] <- "philips"
refineDataLC$company[grep('^.*van.*ten?',refineDataLC$company)] <- "van houten"
refineDataLC$company[grep('^.*un.*ver?',refineDataLC$company)] <- "unilever"
refineDataLC$company[grep('^.*ak.*z?',refineDataLC$company)] <- "akzo"

# 2 - separate the product code and product number
refineDataLC <- refineDataLC %>% separate(Product.code...number, c("product_code", "product_number"), sep = "\\-")

# 3 - add product categories: p = Smartphone, v = TV, x = Laptop, q = Tablet
refineDataLC$product_category[refineDataLC$product_code == "p"] <- "Smartphone"
refineDataLC$product_category[refineDataLC$product_code == "v"] <- "TV"
refineDataLC$product_category[refineDataLC$product_code == "x"] <- "Laptop"
refineDataLC$product_category[refineDataLC$product_code == "q"] <- "Tablet"

# 4 - add full address for geocoding
refineDataLC$full_address <- paste(refineDataLC$address,refineDataLC$city,refineDataLC$country,sep = ",")

# 5 - create dummy variables for company and product category
refineDataLC$company_philips <- 0
refineDataLC$company_philips[grep('^.*il.*ips.*?',refineDataLC$company)] <- 1
refineDataLC$company_akzo <- 0
refineDataLC$company_akzo[grep('^.*ak.*z?',refineDataLC$company)] <- 1 
refineDataLC$company_van_houten <- 0
refineDataLC$company_van_houten[grep('^.*van.*ten?',refineDataLC$company)] <- 1
refineDataLC$company_unilever <- 0
refineDataLC$company_unilever[grep('^.*un.*ver?',refineDataLC$company)] <- 1

#6 - Save as refine_clean.csv - without quotes, without row numbers
write.table(refineDataLC, file = "refine_clean.csv",quote=FALSE,sep=",",row.names=FALSE, col.names=TRUE)

