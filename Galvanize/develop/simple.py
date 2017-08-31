
# coding: utf-8

# In[2]:

import pandas as pd
import numpy as np


# In[3]:

def main():

    file  = open('sample.txt', 'r').read()
    team  = input("Enter word: ")
    count = file.count(team)

    print(count)

main()


# In[ ]:



