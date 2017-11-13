# -*- coding: utf-8 -*-
import scrapy

# Read in previosly saved urls from macys.com
with open('test_urls.txt') as f:
    urls = f.read().splitlines()
    
class macySpider(scrapy.Spider):
    name = 'macybot'
    allowed_domains = ['www.macys.com']
    start_urls = urls

    def parse(self, response):
        #Extracting the content using css selectors
        titles = response.css(".productDescLink::attr(title)").extract()
        #url = response.css(".productDescLink::attr(href)").extract()
        price = response.css(".regular::text").extract()
  

        #Give the extracted content row wise
        for item in zip(titles,price):
            #create a dictionary to store the scraped info
            scraped_data = {
            'title' : item[0],
            'price' : item[1].strip(),
            #'url' : response.urljoin(item[2]),
            }

            #yield or give the scraped info to scrapy
            yield scraped_data
            
        # follow pagination link 
        next_page_url = response.css(".nextPage > a::attr(href)").extract_first()
        # Check to see if next page exists
        if next_page_url:
            next_page_url = response.urljoin(next_page_url)
            yield scrapy.Request(url = next_page_url, callback = self.parse)
            


