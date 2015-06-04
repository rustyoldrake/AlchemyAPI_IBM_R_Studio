# R PROGRAMMING LANGUAGE - SDK FOR ALCHEMYAPI
# Light Version of A SDK (Software Development Kit) for enthusiastic newbiews who want to 
# Use the IBM Watson / AlchemyAPI tools with R and R Studio
# "AlchemyAPI can be easily used with any major programming language: Java, C/C++, C#, Perl, PHP, Python, Ruby, Javascript and Android OS. "
# http://www.alchemyapi.com/developers/sdks 
# MOST OF THIS IS REPURPOSED FROM PYTHON CODE HERE: https://github.com/AlchemyAPI/alchemyapi_python 
# and REST API docs http://www.alchemyapi.com/api/calling-the-api 

# You will need your own Free API key here - http://www.alchemyapi.com/api/register.html

library(httr) # for connecting to API
library(RCurl) # for connecting to API
library(stringr) # for pulling info from JSON
library(rjson) # for pulling info from JSON
library(XML) # for translating XML to R Tables
library(plyr)
library(ggplot2)
library(gridExtra)

## TESTING - Response on Basic Sentiment?
alchemy_url <- "http://access.alchemyapi.com/calls/url/"
api_feature <- "URLGetTextSentiment"
the_url <- "https://dreamtolearn.com/node/8OVIWY2C5RLZZSYD9OHCKM8AI/80"
api_key <- "<<YOUR_API_KEY>>"  # alchemy API secret key 
output_mode <- "json"
query <- paste(alchemy_url,api_feature,"?url=",the_url,"&apikey=",api_key,"&outputMode=",output_mode, sep="")
query
POST(query)



#News API
#Get count of articles over the past 30 days
#https://access.alchemyapi.com/calls/data/GetNews?apikey=YOUR_APP_APIKEY&outputMode=json&start=now-30d&end=now
#Get count of articles over the past 12 hours
#https://access.alchemyapi.com/calls/data/GetNews?apikey=YOUR_APP_APIKEY&outputMode=json&start=now-12h&end=now
#Get a time series count of articles over the past 7 days divided into 12 hour buckets
#https://access.alchemyapi.com/calls/data/GetNews?apikey=YOUR_APP_APIKEY&outputMode=json&start=now-7d&end=now&timeSlice=12h
alchemy_url <- "https://access.alchemyapi.com/calls/"
api_feature <- "data/GetNews"
output_mode <- "xml"  # or json
start <- "now-30d"
end <- "now"
field_name <- "andresson"
news_query <- paste(alchemy_url,api_feature,"?apikey=",api_key,"&outputMode=",output_mode,
                    "&start=",start,"&end=",end,"&q.enriched.url.title=",field_name,
                    sep="")
news_query
results <- POST(news_query) # works
results
### https://access.alchemyapi.com/calls/url/URLGetRankedTaxonomy/&apikey=<<YOUR_API_KEY>>&url=http://cranbrook.ca/our-city/
### https://access.alchemyapi.com/calls/url/URLGetRankedTaxonomy?apikey=<<YOUR_API_KEY>>&url=http://cheeseboardcollective.coop/about

######
alchemy_url <- "https://access.alchemyapi.com/calls/"
api_feature <- "url/URLGetRankedTaxonomy"
api_key <- "<<YOUR_API_KEY>>"  # alchemy API secret key 
output_mode <- "xml"  # or json
the_url <- "http://cheeseboardcollective.coop/about"
taxonomy_query <- paste(alchemy_url,api_feature,"?apikey=",api_key,
                        "&outputMode=",output_mode,"&url=", the_url,
                        sep="")
taxonomy_query
results <- POST(taxonomy_query) # works
results
xmlfile=xmlParse(results)
xmlfile
class(xmlfile) #"XMLInternalDocument" "XMLAbstractDocument"
xmltop = xmlRoot(xmlfile) #gives content of root
class(xmltop)#"XMLInternalElementNode" "XMLInternalNode" "XMLAbstractNode"
xmlName(xmltop) #give name of node, PubmedArticleSet
xmlSize(xmltop) #how many children in node, 19
xmlName(xmltop[[1]]) #name of root's children
# have a look at the content of the first child entry
xmltop[[1]]
# have a look at the content of the 2nd child entry
xmltop[[2]]
xmltop[[3]]
xmltop[[4]]
xmltop[[5]]
xmltop[[6]]

xmltop[[6]][[1]][[1]]
xmltop[[6]][[2]][[1]]
xmltop[[6]][[3]][[1]]

data=ldply(xmlToList(xmltop), data.frame) #completes with errors: "row names were found from a short variable and have been discarded"
data <- data[6,] # peel away rows of no interest (assumes row 6 is taxonomy good info)
data<- data[7:12] # peel away columns of no interes
data


# also works from browser -> https://access.alchemyapi.com/calls/data/GetNews?apikey=<<YOUR_API_KEY>>&outputMode=json&start=now-30d&end=now&q.enriched.url.title=anresson

# let's try just 3 days
start <- "now-3d"
news_query <- paste(alchemy_url,api_feature,"?apikey=",api_key,"&outputMode=",output_mode,
                    "&start=",start,"&end=",end,"&q.enriched.url.title=",field_name,
                    sep="")
POST(news_query) # works

Sentiment Analysis
Taxonomy
Concept Tagging
Entity Extraction
Keyword Extraction
Relation Extraction
Text Extraction
Face Detection
Image Link Extraction
Image Tagging
Author Extraction
Authors Extraction
Language Detection
Feed Detection
Microformats Parsing
Combined Call
Publication Date


