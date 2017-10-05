# Make sure jsonlite package is installed
# Load jsonlite Library 
install.packages("jsonlite")
install.packages("plyr")
library(jsonlite)
library(scales)
library (plyr)
#Stream in json file, convert NULL to NA
json_file <- stream_in(file("ida_wrangling_exercise_data.2017-02-13.jsonl.gz"))
json_file$address[json_file$address=="NULL"] <- "NA"
json_file$name[json_file$name=="NULL"] <- "NA"



# Start by making a list of all of the nested named fields that appear in any record. 
# Concatenate nested field names using a period '.' to defind named fields for nested records. 
# Present the list in alphabetical order. For example, if our data file contained the following


# ------------Operations will be tested on subset of data first-------------------------------

# Grab a subset (10 rows) of data to test, and examine overall structure
small_data <- json_file[1:10, ]
str(small_data)
# The data reveals two nested lists: Address and names



# 1. Concatenate fields------------------------------------

# Concatenate name fields
# This will unpack nested name lists and return strings for names 
small_nested_names <- ldply (small_data$name, data.frame)
small_nested_names <- data.frame(lapply(small_nested_names, as.character), stringsAsFactors=FALSE)
# Renames the columns to desired format
colnames(small_nested_names) <- c("name.first","name.last", "name.middle", "name")

# Delete old names column 
small_data$name <- NULL
# Combine new string name columns
small_data <- cbind(small_data, small_nested_names)


# Concatenate address fields
# This will unpack nested lists and return strings for names 
small_nested_address <- ldply (small_data$address, data.frame)
small_nested_address <- data.frame(lapply(small_nested_address, as.character), stringsAsFactors=FALSE)
# Renames the columns to desired format
colnames(small_nested_address) <- c("address.street","address.city", "address.state", "address.zip","address")



# Delete old address column 
small_data$address <- NULL
# Combine new string name columns
small_data <- cbind(small_data, small_nested_address)

# Arrange columns in alphabetical order
small_data <- small_data[ , order(names(small_data)) ]

# List Column names
small_names_list <- colnames(small_data)
small_names_list

# 2. What percentage of the records contain the field?---------------------------

# -------Field: address-------
# Determine number of instances for address, divide by number of rows, then print  
paste("small address", percent(sum(complete.cases(small_data$address))/nrow(small_data)))

# -------Field: address.city-------
paste("small address.city", percent(sum(complete.cases(small_data$address.city))/nrow(small_data)))

# -------Field: name.last-------
paste("small name.last", percent(sum(complete.cases(small_data$name.last))/nrow(small_data)))

# -------Field: name.middle-------
paste("small name.middle", percent(sum(complete.cases(small_data$name.middle))/nrow(small_data)))


# 2. What are the five most common values of the field?-------

# -------Field: name.last-------
# Plots table of first five common elements 
barplot(sort(table(small_data$name.last),decreasing=TRUE)[1:5], main = "Common last names")

# -------Field: name.middle-------
barplot(sort(table(small_data$name.middle),decreasing=TRUE)[1:5], main = "Common middle names")

# 3. How many distinct first names appear in this data set? Explain your procedure for identifying distinct first names.--
# Examine the first few names in small set 
head(small_data$name.first)

# How many unique first names in small set, excluding NA values
length(unique(na.exclude(small_data$name.first)))

# 4. How many unique street names?
# Strips numbers from address.street 
street_names <- lapply(strsplit(small_data$address.street, "(?<=\\d)\\b ", perl=T), function(x) if (length(x)<2) c("", x) else x)
street_names <- do.call(rbind, street_names)
colnames(street_names) <- c("Street Number", "Street Name")

# Find Unique names in street_names, excluding NA
street_names<- data.frame(street_names)
street_names <- data.frame(lapply(street_names, as.character), stringsAsFactors=FALSE)
paste("Unique small street names:",length(unique(na.exclude(street_names$Street.Name))))
# With more time, I would strip the street names from address column too
# 5 most common street names
barplot(sort(table(street_names$Street.Name),decreasing=TRUE)[1:5], main = "5 Most common street names")


# 5. What are the 5 most common US area codes in the phone number field? 
# Explain your approach to identify the US area codes in this data set.
small_area_codes <- small_data$phone
small_area_codes <- gsub("[[:punct:]]", " ", small_area_codes)
# Need another line of code here to remove "1 "
# The step below strips the first three numbers
small_area_codes <- substring(small_area_codes, 1, 3)
barplot(sort(table(small_area_codes),decreasing=TRUE)[1:5], main = "5 Most common area codes")
