# frozen_string_literal: true

module Services
  class NewsPresenter
    attr_accessor :elasticsearch_hash

    def initialize(elasticsearch_hash)
      @elasticsearch_hash = elasticsearch_hash
    end

    def present
      arr = []

      aggs = elasticsearch_hash['aggregations']['first_agg']['buckets']

      # data structure of aggs
      # => {"key_as_string"=>"2019-08-01T00:00:00.000Z",
      #   "key"=>1564617600000.0,
      #   "doc_count"=>1,
      #   "count_by_medium_type"=>
      #    {"doc_count_error_upper_bound"=>0,
      #     "sum_other_doc_count"=>0,
      #     "buckets"=>[{"key"=>"Online", "doc_count"=>1}]}}

      aggs.each do |hash|
        array_by_medium_type = hash['count_by_medium_type']['buckets']

        chart_hash = {
          name: format_date(hash['key_as_string']),
          social: find_count_for_medium_type(array_by_medium_type, 'Social'),
          print: find_count_for_medium_type(array_by_medium_type, 'Print'),
          online: find_count_for_medium_type(array_by_medium_type, 'Online'),
          tv: find_count_for_medium_type(array_by_medium_type, 'Tv'),
          radio: find_count_for_medium_type(array_by_medium_type, 'Radio')
        }

        arr << chart_hash
      end

      arr
    end

    private

    # from "2019-08-06T00:00:00.000Z" to "2019-08-06"
    def format_date(date)
      DateTime.parse(date).strftime('%F')
    end

    def find_count_for_medium_type(arr, medium_type)
      return 0 if arr.empty?
      return 0 unless arr.select { |el| el['key'] == medium_type }.present?

      arr.select { |el| el['key'] == medium_type } [0]['doc_count']
    end
  end
end
