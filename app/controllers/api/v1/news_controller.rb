# frozen_string_literal: true

require "#{Rails.root}/app/services/elasticsearch_news"
require "#{Rails.root}/app/services/news_presenter"

module Api
  module V1
    class NewsController < ApplicationController
      def index
        query = params[:query]
        before = params[:before]
        after = params[:after]
        interval = params[:interval]

        command = Services::ElasticsearchNews.new(query: query, before: before, after: after, interval: interval)
        elasticsearch_hash = command.execute

        presenter = Services::NewsPresenter.new(elasticsearch_hash)
        news = presenter.present

        render json: news
      end
    end
  end
end
