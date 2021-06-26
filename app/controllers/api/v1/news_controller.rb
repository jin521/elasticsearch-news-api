# frozen_string_literal: true

require "#{Rails.root}/app/services/elasticsearch_news"

module Api
  module V1
    class NewsController < ApplicationController
      def index
        query = params[:query]
        before = params[:before]
        after = params[:after]
        interval = params[:interval]

        command = Services::ElasticsearchNews.new(query: query, before: before, after: after, interval: interval)
        news = command.execute

        render json: news
      end
    end
  end
end
