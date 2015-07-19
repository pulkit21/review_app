class ItemsController < ApplicationController

  before_action :set_current_merchant
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @items = @merchant.items
    render json: @items, status: 200
  end

  def create
    @item = @merchant.items.new(item_params)
    if @item.save
      render :show, format: :json, status: 201
    else
      render json: @item.errors, status: 422
    end
  end

  def show
    render json: @item.as_json.merge(
      positive_review: (@item.comments.sum(:positive_analysis).to_i / @item.comments.count),
      negative_review: (@item.comments.sum(:negative_analysis).to_i / @item.comments.count),
      neutral_review: (@item.comments.sum(:neutral_analysis).to_i / @item.comments.count)
      )
  end

  def update
    if @item.update(item_params)
      render :show, format: :json, status: 200
    else
      render json: @item.errors, status: 422
    end
  end

  def destroy
    @item.destroy
    render json: @item, status: 204
  end

  #######
  private
  #######

  def item_params
    params.require(:item).permit(:name)
  end

  def set_item
    @item = @merchant.items.find(params[:id])
  end

  def set_current_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
