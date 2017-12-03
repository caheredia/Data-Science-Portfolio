import scrapy


class QuotesSpider(scrapy.Spider):
    name = "example.com"
    allowed_domains = ['example.com', 'www.iana.org']
    start_urls = [
        'http://www.example.com'
    ]

    def parse(self, response):
        for h1 in response.xpath('//h1/text()').extract():
            print('-----------------------------------print items here: ' + h1)
            yield {'title': h1}

        for url in response.xpath('//a/@href').extract():
            yield scrapy.Request(url, callback=self.parse)
