# frozen_string_literal: true

require "#{Rails.root}/app/services/elasticsearch_news"
require "#{Rails.root}/app/services/news_presenter"

module Api
  module V1
    class NewsController < ApplicationController
      def index
        chart = params[:chart]
        query = params[:query]
        before = params[:before]
        after = params[:after]
        interval = params[:interval]

        command = Services::ElasticsearchNews.new(query: query, before: before, after: after, interval: interval)
        news = command.execute

        if chart == '1'
          presenter = Services::NewsPresenter.new(news)
          news = presenter.present
        end

        render json: news
      end
    end
  end
end
