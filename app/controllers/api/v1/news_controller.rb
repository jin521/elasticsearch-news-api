# frozen_string_literal: true

require "#{Rails.root}/app/services/elasticsearch_news"
require "#{Rails.root}/app/services/news_presenter"

module Api
  module V1
    class NewsController < ApplicationController
      def index
        debug = news_params[:debug] ||= false

        raw_news = fetch_elasticsearch_news

        render json: (debug ? raw_news : chart_presenter(raw_news))
      end

      private

      def fetch_elasticsearch_news
        command = Services::ElasticsearchNews.new(
          query: news_params[:query],
          before: news_params[:before], 
          after: news_params[:after], 
          interval: news_params[:interval])
        command.execute
      end

      def chart_presenter(raw_news)
        presenter = Services::NewsPresenter.new(raw_news)
        presenter.present
      end

      def news_params
        params.permit(:debug, :query, :before, :after, :interval)
      end
    end
  end
end
