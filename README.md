# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.5.1

* Technologies used 
 ruby on rails, elasticseach, react, rechart

* System dependencies


* How to get started

clone this repositary and run `bundle exec rails s`

This API serves two purposes:
1. accept a request with a boolean query, as well as before/after milliseconds timestamps and a time interval. it performs a double aggregation on a Elasticsearch index, to get counts broken down by date and medium type and return the results as JSON


sample request: 

```
http://localhost:3000/api/v1/news?chart=0&query="scott morrison"&before=1554037199999&after=1551358800000&interval=1
```

2. it displays a visualization of the returned data
once start the rails server, go to localhost:3000

sample results 

<img width="652" alt="Screen Shot 2021-06-27 at 11 44 44 pm" src="https://user-images.githubusercontent.com/19368990/123546837-ae5d7900-d7a1-11eb-803e-7d2a21db0bcd.png">



* How to run the test suite


* Deployment instructions

* ...
