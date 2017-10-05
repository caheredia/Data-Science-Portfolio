# Data analysis exercise

The purpose of this exercise is to provide an example of how you organize, perform, and communicate your work. The exercise itself is not meant to be difficult or particularly time consuming. We value our time, and we value your time. Feel free to explain what you would do if you had more time. Please include all of the source code for your analysis in your report, and please describe all of the steps. We should be able to reproduce your analysis with little work using the content of your report.

This exercise asks some questions about a collection of records that simulate personal information such as name, address, and phone number. The associated data file contains records in [JSON Lines](http://jsonlines.org/) format with one JSON object per line. The records contain nested fields, and different records might contain different fields. The high level concept of this exercise is to picture this data set as a structured table. Because each JSON record is independent, some or all of the columns in this table can have missing values. Below, we refer to the names of the columns in this table as named fields.

Please present your solution as a single report that includes code, descriptive text, and results. We encourage you to include explanations of your approach to each problem. Examples of acceptable formats are PDF or HTML files generated from [RMarkdown](http://rmarkdown.rstudio.com/), [Juypter Notebooks](http://jupyter.org/), or any another method you prefer.

1. Start by making a list of all of the nested named fields that appear in any record. Concatenate nested field names using a period '.' to defind named fields for nested records. Present the list in alphabetical order. For example, if our data file contained the following

        {"name": "Jane Doe", "address": {"personal": {"street": "123 Main St.", "city": "Springfield"}}}
        {"name": "John Doe", "email": "johndoe@example.com"}
        {"name": {"first": "Anne", "last": "Smyth"}, "phone": "123-245-7890"}

    then the ordered list of fields would be

        ["address.personal.city", "address.personal.street", "email", "name", "name.first", "name.last", "phone"]

    Note that a top-level named field such as "name" could contain either text or a nested JSON object. Thus "name" and "name.first" could both exists as separate fields in your list.

2. Answer the following questions for each field in your list from question 1.

        - What percentage of the records contain the field?
        - What are the five most common values of the field?
    
    In the example data above, the field "address.personal.city" occurs in 1 out of 3 records so the fraction of records containing that field is 1/3. The exact percentage is 100/3. For this exercise, please approximate numeric answers to a reasonable precision such as 33.3%. Note that the field "name" occurs in the first and second record but not in the third record where the fields "name.first" and "name.last" are present. Thus, the "name" field occurs in 2/3 or roughly 66.6% of the records in the example above.

3. How many distinct first names appear in this data set? Explain your procedure for identifying distinct first names.

4. How many distinct street names appear in this data set? Explain your procedure for identifying distinct [street names](https://en.wikipedia.org/wiki/Street_or_road_name).

5. What are the 5 most common US area codes in the phone number field? Explain your approach to identify the US area codes in this data set.
