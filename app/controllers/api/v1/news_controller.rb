module Api
  module V1
    class NewsController < ApplicationController
      ALLOWED_DATA = %(query before after interval).freeze

      def index
        query = params[:query]
        before = params[:before]
        after = params[:after]
        interval = params[:interval]

        client = Elasticsearch::Client.new url: 'https://sample.es.streem.com.au', user: 'candidate', password: 'streem', log: true
     
        client.cluster.health
    
          # GET news_201908/_search
          # {
          #   "query": {
          #     "match": {
          #       "text": "scott morrison"
          #     } 
          #   },
          #   "size": 0,
          #   "aggs": {
          #     "first_aggs": {
          #       "histogram": {
          #         "field": "timestamp",
          #         "interval":86400000
          #       },
          #       "aggregations": {
          #         "count_by_medium_type": {
          #           "terms": { "field": "medium" }
          #         }
          #       }
          #     }
          #   }
          # }
    
        news = client.search(index: 'news', body: { query: { match: { text: query } } })
          # news = client.search q: 'test'

        render json: news
      end
    end
  end
end
