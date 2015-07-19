class CommentsController < ApplicationController

  before_action :set_current_merchant
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @comments = @merchant.comments
    if @comments.present?
      @positive_review = ((@merchant.comments.sum(:positive_analysis).to_i / @merchant.comments.count))
      @negative_review = ((@merchant.comments.sum(:negative_analysis).to_i / @merchant.comments.count))
      @neutral_review = ((@merchant.comments.sum(:neutral_analysis).to_i / @merchant.comments.count))
      render json: {comments: @comments, avg_positive_analysis: @positive_review, avg_negative_analysis: @negative_review, avg_neutral_analysis: @neutral_review}, status: 200
    else
      render json: {error: "No reviews"}, status: 422
    end
  end

  def create
    @comment = @merchant.comments.new(comment_params)
    if @comment.save
      @comment.delay.text_processing(params)
      data = {review_text: @comment.review, review_rating: @comment.rating, review_site: @comment.site, review_user: @comment.user_name, tags: @merchant.items.map{|i| i.name}}.to_json
      $redis.publish("nltk_data", data)
      render :show, format: :json, status: 201
    else
      render json: @comment.errors, status: 422
    end
  end

  def show
    render :show, format: :json, status: 200
  end

  def update
    if @comment.update(comment_params)
      render :show, format: :json, status: 200
    else
      render json: @comment.errors, status: 422
    end
  end

  def destroy
    @comment.destroy
    render json: @comment, status: 204
  end

  #######
  private
  #######

  def comment_params
    params.require(:comment).permit(:site, :rating, :review, :semantics, :user_name)
  end

  def set_comment
    @comment = @merchant.comments.find(params[:id])
  end

  def set_current_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
