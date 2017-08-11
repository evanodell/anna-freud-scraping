import scrapy
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor
from bs4 import BeautifulSoup as bsoup

class MySpider(CrawlSpider):
    name = 'anna'
    allowed_domains = ['example.com']
    start_urls = ['http://www.example.com']

    rules = (
        Rule(LinkExtractor(allow=(''), callback='parse_items',follow = True),
    )

    def parse_item(self, response):
        item = dict()
        # or better just save whole source
        item['source'] = response.body
        return item