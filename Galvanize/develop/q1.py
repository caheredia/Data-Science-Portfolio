
# coding: utf-8

# In[4]:

import pandas as pd
import numpy as np


# In[13]:

def main():
    
    text_file  = input("Enter text file, with no quotes (e.g. sample.txt): ")   #name of file to read 
    
    df = pd.read_csv('../data/' + text_file, delim_whitespace=True, header = 
    None).T 
    #load into dataframe to utilize pandas operations 
    df.columns = ['words'] #rename column
    df.words = df.words.str.replace('[^\w\s]','') #remove special charectors
    df.words = df.words.str.lower(); #convert to lower case 
    
    word_count = len(df)
    unique_words = len(df.words.unique()) 
    word_counts = df.words.value_counts() 
   
    #counts the number of periods to determine number of sentences
    sentences = open('../data/'+text_file, 'r').read().count('.') 


    
    print('1. The total word count: ', word_count )
    print('2. The count of unique words: ', unique_words)
    print('3. The number of sentences: ', sentences)
    print ( 'Brownie points' )
    print('3. A list of words used, in order of descending frequency: \n', word_counts)

main()


# In[ ]:



