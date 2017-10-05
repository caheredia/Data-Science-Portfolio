# ------------Old Operations-------------------------------

# Grabs nested elements 
first.name <- small_data$name$firstname
# Access first name in nested "name" field, http://r4ds.had.co.nz/lists.html
small_data$name[[1]]$firstname

# List Column names
colnames(test)


# Build column with first names
# Entries without firstname list will have to be fixed later with function that selects first name string
test2 <-NULL
test2[1:10] <- "NA"
for(i in 1:10){
  test2[i] <- as.character(small_data$name[[i]]$firstname)
}
str(test2)

# Combine columns with first names
new_small_data <- cbind(small_data, first.names = test2)

# Arrange columns in alphabetical order
new_small_data <- new_small_data[ , order(names(new_small_data)) ]
