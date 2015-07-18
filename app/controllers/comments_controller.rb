class CommentsController < ApplicationController

  before_action :set_current_merchant
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @comments = @merchant.comments
    render json: @comments, status: 200
  end

  def create
    @comment = @merchant.comments.new(comment_params)
    if @comment.save
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
    params.require(:comment).permit(:site, :rating, :review, :semantics)
  end

  def set_comment
    @comment = @merchant.comments.find(params[:id])
  end

  def set_current_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
