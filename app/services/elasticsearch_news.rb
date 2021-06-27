# frozen_string_literal: true

module Services
  class ElasticsearchNews
    attr_accessor :query, :before, :after, :interval

    def initialize(query:, before:, after:, interval:)
      @query = query
      @before = before
      @after = after
      @interval = interval
    end

    def execute
      client.cluster.health

      client.search(index: 'news',
                    type: 'doc',
                    body: {
                      query: {
                        'bool': {
                          'should': [
                            {
                              'match': {
                                'text': query
                              }
                            },
                            {
                              'range': {
                                'timestamp': {
                                  'gte': after,
                                  'lte': before
                                }
                              }
                            }
                          ]
                        }
                      },
                      aggs: {
                        'first_agg': {
                          'histogram': {
                            'field': 'timestamp',
                            'interval': day_to_milliseconds(interval.to_i)
                          },
                          'aggregations': {
                            'count_by_medium_type': {
                              'terms': { 'field': 'medium' }
                            }
                          }
                        }
                      }
                    })
    end

    private

    def client
      @client ||= Elasticsearch::Client.new(url: 'https://sample.es.streem.com.au',
                                            user: 'candidate',
                                            password: 'streem',
                                            log: true)
    end

    def day_to_milliseconds(day)
      day * 86_400_000
    end
  end
end
