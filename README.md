# README

This repositary is working in conjunction with a react frontend app, sourcecode can be found here

https://github.com/jin521/news-react

## Ruby version

 `2.5.1`
 
## Rails version

 `5.2.6`

## Technologies used

 Ruby on rails, elasticseach, react, rechart


## How to get started

clone this repositary and run 
    
   `$ bundle exec rails server`
    
then go to `localhost:3000`


## This API serves two purposes:
    
1.Accept a request with a boolean query, as well as before/after milliseconds timestamps and a time interval. it performs a double aggregation on a Elasticsearch index, to get counts broken down by date and medium type and return the results as JSON, As this is raw data form Elasticsearch index, it would be mostly used for debugging purpose, in real life this would be a security leak and most possiblity won't be exposed, therefore it needs a `debug=true` to be passed in query params.


    # sample request: 

    ```
    http://localhost:3000/api/v1/news?debug=true&query="scott morrison"&before=1554037199999&after=1551358800000&interval=1
    ```
    

2. It displays a visualization of the returned data

once start the rails server, go to `localhost:3000`

# sample results 

<img width="565" alt="Screen Shot 2021-06-29 at 11 03 48 pm" src="https://user-images.githubusercontent.com/19368990/123803874-05915400-d930-11eb-91a2-0fc0d032fb23.png">




## How to run the test suite

    `$ rspec`

## Deployment instructions
