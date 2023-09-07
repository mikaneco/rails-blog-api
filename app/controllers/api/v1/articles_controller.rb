# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_user, only: %i[index show]
      before_action :set_article, only: %i[show update destroy]
      before_action :authorize_user!, only: %i[update destroy]

      def index
        @articles = if current_api_v1_user&.id == @user.id
                      @user.articles
                    else
                      @user.articles.published
                    end
        render json: @articles
      end

      def show
        if @article.public_status == 'published' || owner_of_draft?
          render json: @article
        else
          render json: { status: 401, message: 'unauthorized' }
        end
      end

      def create
        @article = current_api_v1_user.articles.build(article_params)
        if @article.save
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      def update
        if @article.update(article_params)
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @article.delete!
          render json: { status: 200, message: 'article deleted' }
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      private

      def article_params
        params.require(:article).permit(:title, :content, :public_status)
      end

      def set_user
        @user = User.find(params[:user_id])
      end

      def set_article
        @article = current_api_v1_user.articles.find(params[:id])
      end

      def owner_of_draft?
        @article.public_status == 'draft' && @article.user_id == current_api_v1_user.id
      end

      def authorize_user!
        render json: { status: 401, message: 'unauthorized' } unless @article.user_id == current_api_v1_user.id
      end
    end
  end
end
