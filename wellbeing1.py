#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Aug  6 18:08:18 2017

@author: evanodell
"""

from bs4 import BeautifulSoup as bsoup
import requests as rq

import pandas as pd

from requests.exceptions import ConnectionError

import time

no_sitemap = []


site_list = pd.read_csv('sites.csv')## CSV file with list of 29 random sites from the directory

for site in range(len(site_list)):

    wellbeing = site_list.name[site] + "sitemap.xml"
    r = rq.get(wellbeing)
    print('Site ' + str(site) +' of ' + str(len(site_list)))
    if r.status_code == 200:
        page = rq.get(wellbeing)
        sitemap_index = bsoup(page.content, 'lxml')
        urls = [element.text for element in sitemap_index.find_all('loc')]
            
        page_list = [] 
                        
        page_list.extend(urls) ## Add URLs to list of pages
        
        for xx in urls: ## Loops over each list of first page sitemap URLS looking for nested sitemap URLS
            sub_sitemap_feed = xx
            sub_page = rq.get(sub_sitemap_feed)
            sub_sitemap_index = bsoup(sub_page.content, 'lxml')
            sub_urls = [element.text for element in sub_sitemap_index.findAll('loc')]
            page_list.extend(sub_urls)
        
        site_name = (site_list.name[site] + '.txt') 
        
        site_name = site_name.replace("http://", "") ## Get rid of extra URL things for cleaner file names
        site_name = site_name.replace("https://", "")
        site_name = site_name.replace("www.", "")
        site_name = site_name.replace("/", "")
        site_name = site_name.replace("^[0-9]", "")
            
        acct = open(site_name, "ab")
        
        for i in range(len(page_list)): ## Parses text from list of pages
                url = page_list[i]
                if url[-4:] != ".xml": ## Avoid sitemap pages in URL
                    try:
                        r = rq.get(url)
                        soup = bsoup(r.content, 'lxml')
                        for script in soup(["script", "style"]):
                            script.extract() 
                        results = soup.get_text().encode('utf-8')
                        acct.write(results)
                        print('Page ' + str(i) +' of ' + str(len(page_list)))
                        print(results)
                    except ConnectionError as e:    # This is the correct syntax
                        print (e)
                        r = "No response"
                time.sleep(1) ## To avoid hammering websites too much
    else:    
        print("Website doesn't have sitemap") ## Pages without sitemaps are more time consuming to scrape and parse
        no_sitemap.append(site_list.name[site])
    
        
no_sitemap = pd.DataFrame(no_sitemap, columns=["colummn"])
no_sitemap.to_csv('no_sitemap.csv', index=False)