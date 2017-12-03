# -*- coding: utf-8 -*-
import scrapy


class macySpider(scrapy.Spider):
    name = 'macybot2'
    allowed_domains = ['www.macys.com']
    #start_urls = ['https://www.macys.com/cms/slp/2/Site-Index']
    start_urls = ['http://www1.macys.com/shop/makeup-and-perfume/nail-polish?id=69901']

    def parse(self, response):
        # Extracting the content using css selectors
        titles = response.css(".productDescLink::attr(title)").extract()
        #url = response.css(".productDescLink::attr(href)").extract()
        price = response.css(".regular::text").extract()

        # Give the extracted content row wise
        for item in zip(titles, price):
            # create a dictionary to store the scraped info
            scraped_data = {
                'title': item[0],
                'price': item[1].strip(),
                #'url' : response.urljoin(item[2]),
            }

            # yield or give the scraped info to scrapy
            yield scraped_data

        # follow pagination link
        next_page_url = response.css(".nextPage > a::attr(href)").extract_first()
        # Check to see if next page exists
        if next_page_url:
            next_page_url = response.urljoin(next_page_url)
            yield scrapy.Request(url=next_page_url, callback=self.parse)

#        # file through cleaned up links in index page
#        for url in response.xpath('//a/@href').extract():
#            if 'http://www' in url and 'java' not in url:
#                yield scrapy.Request(url, callback=self.parse)
